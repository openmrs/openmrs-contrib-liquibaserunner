package org.openmrs.contrib.liquibaserunner.customchange;

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

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import liquibase.FileOpener;
import liquibase.change.custom.CustomSqlChange;
import liquibase.database.Database;
import liquibase.database.DatabaseConnection;
import liquibase.database.sql.DropTableStatement;
import liquibase.database.sql.SqlStatement;
import liquibase.exception.CustomChangeException;
import liquibase.exception.InvalidChangeDefinitionException;
import liquibase.exception.SetupException;

/**
 * Drops tables other than needed by the concept dictionary.
 */
public class DropNonDictionaryTables implements CustomSqlChange {
	
	/**
	 * @see liquibase.change.custom.CustomSqlChange#generateStatements(liquibase.database.Database)
	 */
	public SqlStatement[] generateStatements(Database database) throws CustomChangeException {
		final DatabaseConnection connection = database.getConnection();
		
		try {
			final String schema = connection.getCatalog();
			
			final Statement selectTableNames = connection.createStatement();
			selectTableNames
			        .execute("SELECT TABLES.TABLE_NAME FROM INFORMATION_SCHEMA.TABLES TABLES WHERE TABLES.TABLE_SCHEMA = '"
			                + schema + "'");
			
			ResultSet results = selectTableNames.getResultSet();
			
			List<DropTableStatement> dropStatements = new ArrayList<DropTableStatement>();
			while (results.next()) {
				String tableName = results.getString(1);
				if (!tableName.startsWith("concept") && !tableName.startsWith("databasechangelog")
						&& !tableName.equalsIgnoreCase("drug") && !tableName.equalsIgnoreCase("drug_ingredient")) {
					dropStatements.add(new DropTableStatement(schema, tableName, true));
				}
			}
			
			return dropStatements.toArray(new SqlStatement[0]);
		}
		catch (Exception e) {
			throw new CustomChangeException(e);
		}
	}
	
	@Override
	public String getConfirmationMessage() {
		return null;
	}
	
	@Override
	public void setFileOpener(FileOpener arg0) {
		
	}
	
	@Override
	public void setUp() throws SetupException {
		
	}
	
	@Override
	public void validate(Database arg0) throws InvalidChangeDefinitionException {
		
	}
	
}
