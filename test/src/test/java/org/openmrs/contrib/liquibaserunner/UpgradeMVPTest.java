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
import java.util.Properties;

import org.junit.Test;

/**
 * Upgrades the MVP dictionary.
 */
public class UpgradeMVPTest {
	
	@Test
	public void shouldUpgradeMVP() throws SQLException, IOException {
		Properties properties = LiquibaseRunner.loadProperties();

		Integer step = Integer.parseInt(properties.getProperty("mvp.step"));

		LiquibaseRunner liquibase;

		if (step == 0 || step == 1) {
			liquibase = new LiquibaseRunner("openmrs-1.11.x/1.11.0-clean.xml", false);
			liquibase.dropAll();
			liquibase.update();
			liquibase.close();

			liquibase = new LiquibaseRunner(properties.getProperty("mvp.file"), false);
			liquibase.update();
			liquibase.close();

			liquibase = new LiquibaseRunner(LiquibaseRunner.OPENMRS_UPDATE_FILE, true);
			liquibase.update();
			liquibase.close();
		}

		if (step == 2) {
			// Upgrade MVP to the latest version in the second run
			liquibase = new LiquibaseRunner(LiquibaseRunner.OPENMRS_UPDATE_FILE, true);
			liquibase.update();
			liquibase.close();
		}

		if (step == 0 || step == 2) {
			liquibase = new LiquibaseRunner("mvp/prepare-dictionary.xml", false);
			liquibase.update();

			liquibase.dropChangeLogAndClose();
		}
	}
}
