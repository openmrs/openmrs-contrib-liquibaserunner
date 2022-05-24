#!/bin/bash

mysql -e "CREATE DATABASE IF NOT EXISTS liquibaserunner CHARACTER SET utf8 COLLATE utf8_general_ci;" -uroot
mysql -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));" -uroot

if [ "$TWO_STEP" = "true"]; then
  mvn install -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="2.3.0" -Ddb.user="root" -Ddb.password="" -Dmvp.step=1 -Dmvp.file="$TRAVIS_BUILD_DIR/openmrs_concepts_1_6.zip"
  mvn install -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="$OPENMRS_VERSION" -Ddb.user="root" -Ddb.password="" -Dmvp.step=2 -Dmvp.file="$TRAVIS_BUILD_DIR/openmrs_concepts_1_6.zip"
else
  mvn install -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="$OPENMRS_VERSION" -Ddb.user="root" -Ddb.password="" -Dmvp.file="$TRAVIS_BUILD_DIR/openmrs_concepts_1_6.zip"
fi

mysqldump -uroot liquibaserunner > "openmrs_concepts_$FILE_SUFFIX.sql"
zip "openmrs_concepts_$FILE_SUFFIX.zip" "openmrs_concepts_$FILE_SUFFIX.sql"