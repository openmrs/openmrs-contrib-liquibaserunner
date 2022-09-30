/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.contrib.liquibaserunner;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import liquibase.ClassLoaderFileOpener;
import liquibase.FileSystemFileOpener;
import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

/**
 * {@link Liquibase} wrapper.
 */
public class LiquibaseRunner {
	
	public static final String OPENMRS_UPDATE_FILE = "liquibase-update-to-latest.xml";
	
	private final Liquibase liquibase;
	
	private final String changeLogTable;
	
	private final String changeLogLockTable;
	
	private final Connection connection;
	
	public LiquibaseRunner(final String changeLogFile, final boolean useOpenmrsChangeLog) throws LiquibaseRunnerException {
		try {
			final Properties properties = loadProperties();
			connection = openConnection(properties);
			
			final Database database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(connection);
			
			if (useOpenmrsChangeLog) {
				changeLogTable = "liquibasechangelog";
				changeLogLockTable = "liquibasechangeloglock";
			} else {
				changeLogTable = "databasechangelog_v1";
				changeLogLockTable = "databasechangeloglock_v1";
			}
			
			database.setDatabaseChangeLogTableName(changeLogTable);
			database.setDatabaseChangeLogLockTableName(changeLogLockTable);
			
			if (ClassLoader.getSystemResource(changeLogFile) != null) {
				liquibase = new Liquibase(changeLogFile, new ClassLoaderFileOpener(), database);
			} else {
				final String changeLogTempFile = createTempChangeLogFile(changeLogFile);
				liquibase = new Liquibase(changeLogTempFile, new FileSystemFileOpener(), database);
			}
			liquibase.forceReleaseLocks();
		}
		catch (Exception e) {
			throw new LiquibaseRunnerException(e);
		}
	}
	
	/**
	 * @param changeLogFile
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private String createTempChangeLogFile(final String changeLogFile) throws IOException {
		InputStream input = null;
		OutputStream output = null;
		File tempFile = null;
		try {
			input = ClassLoader.getSystemResourceAsStream("sqlfile-changeset.xml");
			String changeset = IOUtils.toString(input, "UTF-8");
			input.close();

			File file = new File(changeLogFile);
			if (file.getName().endsWith(".zip")) {
				File unzippedFile = extractSqlFromZip(file);

				changeset = changeset.replace("${sqlfile}", unzippedFile.getAbsolutePath());
			} else {
				changeset = changeset.replace("${sqlfile}", file.getAbsolutePath());
			}
			
			tempFile = File.createTempFile("liquibaserunner", ".xml");
			
			output = new FileOutputStream(tempFile);
			IOUtils.write(changeset, output, "UTF-8");
			output.close();
			
			return tempFile.getAbsolutePath();
		}
		finally {
			if (tempFile != null) {
				tempFile.deleteOnExit();
			}
			IOUtils.closeQuietly(input);
			IOUtils.closeQuietly(output);
		}
	}

	private File extractSqlFromZip(File file) throws IOException {
		ZipFile zipFile = null;
		FileOutputStream unzippedFileOut = null;
		try {
			zipFile = new ZipFile(file);
			ZipEntry zipEntry = null;
			while (zipFile.entries().hasMoreElements()) {
				zipEntry = zipFile.entries().nextElement();
				if (zipEntry.getName().endsWith(".sql")) {
					break;
				} else {
					zipEntry = null;
				}
			}
			if (zipEntry == null) {
				throw new IllegalArgumentException(file.getName() + " does not contain any .sql file");
			}

			File unzippedFile = File.createTempFile(StringUtils.stripEnd(file.getName(), ".zip"), ".sql");
			unzippedFileOut = new FileOutputStream(unzippedFile);

			IOUtils.copy(zipFile.getInputStream(zipEntry), unzippedFileOut);

			zipFile.close();
			unzippedFileOut.close();

			return unzippedFile;
		} finally {
			if (zipFile != null) {
				try {
					zipFile.close();
				} catch (Exception e) {
					//close quietly
				}
			}
			IOUtils.closeQuietly(unzippedFileOut);
		}
	}
	
	public void update() throws LiquibaseRunnerException {
		try {
			liquibase.update("");
		}
		catch (Exception e) {
			close();
			throw new LiquibaseRunnerException(e);
		}
	}
	
	public void dropAll() throws LiquibaseRunnerException {
		try {
			liquibase.dropAll();
		}
		catch (Exception e) {
			close();
			throw new LiquibaseRunnerException(e);
		}
	}
	
	public void dropChangeLogAndClose() throws LiquibaseRunnerException {
        try {
        	Statement statement = getConnection().createStatement();
	        statement.execute("drop table " + changeLogTable);
			statement.execute("drop table " + changeLogLockTable);
			getConnection().commit();
        }
        catch (SQLException e) {
        	throw new LiquibaseRunnerException(e);
        } finally {
        	close();
        }
	}
	
	public static Properties loadProperties() {
		InputStream input = null;
		try {
			final Properties properties = new Properties();
			
			input = LiquibaseRunner.class.getClassLoader().getResourceAsStream("liquibaserunner.properties");
			if (input == null) {
				throw new IOException("'liquibaserunner.properties' is missing!");
			}
			properties.load(input);
			input.close();
			
			String propertiesFile = properties.getProperty("properties.file");
			if (!StringUtils.isBlank(propertiesFile)) {
				input = new FileInputStream(propertiesFile);
				properties.load(input);
				input.close();
			}
			
			return properties;
		}
		catch (IOException e) {
			throw new RuntimeException(e);
		}
		finally {
			IOUtils.closeQuietly(input);
		}
	}
	
	/**
	 * @throws IOException
	 * @throws SQLException
	 */
	protected Connection openConnection(final Properties properties) throws IOException, SQLException {
		final String url = properties.getProperty("db.url");
		final String user = properties.getProperty("db.user");
		final String password = properties.getProperty("db.password");
		
		return DriverManager.getConnection(url, user, password);
		
	}
	
	/**
	 * @return the connection
	 */
	public Connection getConnection() {
		return connection;
	}
	
	public void close() throws LiquibaseRunnerException {
		try {
			liquibase.forceReleaseLocks();
			connection.close();
		}
		catch (Exception e) {
			throw new LiquibaseRunnerException(e);
		}
	}
	
}
