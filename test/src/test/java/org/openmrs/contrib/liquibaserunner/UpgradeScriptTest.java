package org.openmrs.contrib.liquibaserunner;


import junit.framework.Assert;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Test;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.openmrs.util.DatabaseUpdateException;
import org.openmrs.util.DatabaseUpdater;
import org.openmrs.util.InputRequiredException;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;

public class UpgradeScriptTest extends BaseModuleContextSensitiveTest {
	@Test
	public void shouldUpgradeScript() throws SQLException, IOException {
		Properties properties = LiquibaseRunner.loadProperties();
		String script = properties.getProperty("script.file");

		if (StringUtils.isEmpty(script)) {
			Assert.fail("The liquibase upgrade script must be specified. (-Dscript.file=<path to file>)");
		}

		script = FilenameUtils.getFullPath(script);
		if (!new File(script).exists()) {
			Assert.fail("Could not find a liquibase upgrade script at: " + script);
		}

		try {
			DatabaseUpdater.executeChangelog(properties.getProperty("script.file"), null);

		} catch (InputRequiredException e) {
			e.printStackTrace();

			Assert.fail(e.getMessage());
		} catch (DatabaseUpdateException e) {
			e.printStackTrace();

			Assert.fail(e.getMessage());
		}
	}
}
