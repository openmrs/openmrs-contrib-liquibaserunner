#!/bin/bash
set -e


mysql -e "DROP DATABASE IF EXISTS liquibaserunner;" -h 127.0.0.1 -uroot -proot
mysql -e "CREATE DATABASE liquibaserunner CHARACTER SET utf8 COLLATE utf8_general_ci;" -h 127.0.0.1 -uroot -proot

if [ "$TWO_STEP" = "true" ]; then
  mvn install -e -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="2.3.0" -Ddb.user="root" -Ddb.password="root" -Dmvp.step=1 -Dmvp.file="${GITHUB_WORKSPACE}/openmrs_concepts_1_6.zip"
  mvn install -e -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="$OPENMRS_VERSION" -Ddb.user="root" -Ddb.password="root" -Dmvp.step=2 -Dmvp.file="${GITHUB_WORKSPACE}/openmrs_concepts_1_6.zip"
else
  mvn install -e -q $PROFILE -Dtest=UpgradeMVPTest -DfailIfNoTests=false -Dopenmrs.version="$OPENMRS_VERSION" -Ddb.user="root" -Ddb.password="root" -Dmvp.file="${GITHUB_WORKSPACE}/openmrs_concepts_1_6.zip"
fi

mysqldump -h 127.0.0.1 -uroot -proot liquibaserunner > "openmrs_concepts_$FILE_SUFFIX.sql"
zip "openmrs_concepts_$FILE_SUFFIX.zip" "openmrs_concepts_$FILE_SUFFIX.sql"
