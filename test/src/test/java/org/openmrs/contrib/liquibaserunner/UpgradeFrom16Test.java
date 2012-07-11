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

import org.junit.Test;

/**
 * Tests upgrade scenarios.
 */
public class UpgradeFrom16Test {
	
	@Test
	public void shouldUpgradeFrom16Clean() {
		LiquibaseRunner runner = new LiquibaseRunner("openmrs-1.6.x/1.6.6.27476-2012.05.28-clean.xml", false);
		runner.dropAll();
		runner.update();
		runner.close();
		
		runner = new LiquibaseRunner(LiquibaseRunner.OPENMRS_UPDATE_FILE, true);
		runner.update();
		runner.close();
	}
}
