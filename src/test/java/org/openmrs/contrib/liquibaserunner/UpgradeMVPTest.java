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

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.junit.Test;

/**
 * Upgrades the MVP dictionary.
 */
public class UpgradeMVPTest {
	
	@Test
	public void shouldUpgradeMVP() throws SQLException, IOException {
		LiquibaseRunner liquibase = new LiquibaseRunner("openmrs-1.6.x/1.6.6.27476-2012.05.28-clean.xml", false);
		liquibase.dropAll();
		liquibase.update();
		liquibase.close();
		
		Properties properties = LiquibaseRunner.loadProperties();
		
		liquibase = new LiquibaseRunner(properties.getProperty("mvp.file"), false);
		liquibase.update();
		liquibase.close();
		
		liquibase = new LiquibaseRunner(LiquibaseRunner.OPENMRS_UPDATE_FILE, true);
		liquibase.update();
		liquibase.close();
		
		liquibase = new LiquibaseRunner("mvp/prepare-dictionary.xml", false);
		liquibase.update();
		
		try {
			Statement statement = liquibase.getConnection().createStatement();
			statement.execute("drop table databasechangelog");
			statement.execute("drop table databasechangeloglock");
			liquibase.getConnection().commit();
		}
		finally {
			liquibase.close();
		}
	}
}
