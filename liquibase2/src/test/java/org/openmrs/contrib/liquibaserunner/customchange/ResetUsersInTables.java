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
package org.openmrs.contrib.liquibaserunner.customchange;

import java.lang.reflect.Constructor;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import liquibase.change.custom.CustomSqlChange;
import liquibase.database.Database;
import liquibase.database.jvm.JdbcConnection;
import liquibase.exception.CustomChangeException;
import liquibase.exception.SetupException;
import liquibase.exception.ValidationErrors;
import liquibase.resource.ResourceAccessor;
import liquibase.statement.SqlStatement;
import liquibase.statement.core.UpdateStatement;

/**
 * Sets all user references to 1.
 */
public class ResetUsersInTables implements CustomSqlChange {
	
	/**
	 * @see liquibase.change.custom.CustomSqlChange#generateStatements(liquibase.database.Database)
	 */
	public SqlStatement[] generateStatements(Database database) throws CustomChangeException {
		final JdbcConnection connection = (JdbcConnection) database.getConnection();
		try {
			final String schemaName = connection.getCatalog();
			
			final String[] columnNames = new String[] { "creator", "voided_by", "retired_by", "changed_by" };
			
			final List<UpdateStatement> updateStatements = new ArrayList<UpdateStatement>();
			
			for (String columnName : columnNames) {
				Statement selectTablesWithColumn = connection.createStatement();
				selectTablesWithColumn.execute("SELECT COLUMNS.TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS COLUMNS"
				        + " WHERE COLUMNS.TABLE_SCHEMA = '" + schemaName + "' AND COLUMNS.COLUMN_NAME = '" + columnName
				        + "'");
				ResultSet results = selectTablesWithColumn.getResultSet();
				
				while (results.next()) {
					String tableName = results.getString(1);
					UpdateStatement updateStatement = null;
					try {
						Constructor<?> clazz = UpdateStatement.class.getConstructor(String.class, String.class);
						updateStatement = (UpdateStatement) clazz.newInstance(schemaName, tableName);
					} catch (NoSuchMethodException e) {
						Constructor<?> clazz = UpdateStatement.class.getConstructor(String.class, String.class, String.class);
						updateStatement = (UpdateStatement) clazz.newInstance(null, schemaName, tableName);
					}
					updateStatement.addNewColumnValue(columnName, 1);
					updateStatements.add(updateStatement);
				}
				selectTablesWithColumn.close();
			}
			
			return updateStatements.toArray(new UpdateStatement[0]);
		}
		catch (Exception e) {
			throw new CustomChangeException(e);
		}
		
	}
	
	/**
	 * @see liquibase.change.custom.CustomChange#getConfirmationMessage()
	 */
	public String getConfirmationMessage() {
		return null;
	}
	
	/**
	 * @see liquibase.change.custom.CustomChange#setUp()
	 */
	public void setUp() throws SetupException {
		
	}
	
	/**
	 * @see liquibase.change.custom.CustomChange#setFileOpener(liquibase.resource.ResourceAccessor)
	 */
	public void setFileOpener(ResourceAccessor resourceAccessor) {
		
	}
	
	/**
	 * @see liquibase.change.custom.CustomChange#validate(liquibase.database.Database)
	 */
	public ValidationErrors validate(Database database) {
		return null;
	}
	
}
