-- MySQL dump 10.13  Distrib 5.5.18, for Win64 (x86)
--
-- Host: localhost    Database: liquibaserunner
-- ------------------------------------------------------
-- Server version	5.5.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `cohort_uuid_index` (`uuid`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort`
--

LOCK TABLES `cohort` WRITE;
/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL DEFAULT '0',
  `patient_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cohort_id`,`patient_id`),
  KEY `member_patient` (`patient_id`),
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort_member`
--

LOCK TABLES `cohort_member` WRITE;
/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `short_name` varchar(255) DEFAULT NULL,
  `description` text,
  `form_text` text,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `default_charge` int(11) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `concept_uuid_index` (`uuid`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`),
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `concept_answer_uuid_index` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answers_for_concept` (`concept_id`),
  KEY `answer_creator` (`creator`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_answer`
--

LOCK TABLES `concept_answer` WRITE;
/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `concept_class_uuid_index` (`uuid`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `concept_class_creator` (`creator`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_class`
--

LOCK TABLES `concept_class` WRITE;
/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
INSERT INTO `concept_class` VALUES (1,'Test','Acq. during patient encounter (vitals, labs, etc.)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f'),(2,'Procedure','Describes a clinical procedure',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d490bf4-c2cc-11de-8d13-0010c6dffd0f'),(3,'Drug','Drug',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d490dfc-c2cc-11de-8d13-0010c6dffd0f'),(4,'Diagnosis','Conclusion drawn through findings',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4918b0-c2cc-11de-8d13-0010c6dffd0f'),(5,'Finding','Practitioner observation/finding',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f'),(6,'Anatomy','Anatomic sites / descriptors',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491c7a-c2cc-11de-8d13-0010c6dffd0f'),(7,'Question','Question (eg, patient history, SF36 items)',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491e50-c2cc-11de-8d13-0010c6dffd0f'),(8,'LabSet','Term to describe laboratory sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492026-c2cc-11de-8d13-0010c6dffd0f'),(9,'MedSet','Term to describe medication sets',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4923b4-c2cc-11de-8d13-0010c6dffd0f'),(10,'ConvSet','Term to describe convenience sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492594-c2cc-11de-8d13-0010c6dffd0f'),(11,'Misc','Terms which don\'t fit other categories',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492774-c2cc-11de-8d13-0010c6dffd0f'),(12,'Symptom','Patient-reported observation',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492954-c2cc-11de-8d13-0010c6dffd0f'),(13,'Symptom/Finding','Observation that can be reported from patient or found on exam',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492b2a-c2cc-11de-8d13-0010c6dffd0f'),(14,'Specimen','Body or fluid specimen',1,'2004-12-02 00:00:00',0,NULL,NULL,NULL,'8d492d0a-c2cc-11de-8d13-0010c6dffd0f'),(15,'Misc Order','Orderable items which aren\'t tests or drugs',1,'2005-02-17 00:00:00',0,NULL,NULL,NULL,'8d492ee0-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_complex`
--

LOCK TABLES `concept_complex` WRITE;
/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `concept_datatype_uuid_index` (`uuid`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_datatype`
--

LOCK TABLES `concept_datatype` WRITE;
/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
INSERT INTO `concept_datatype` VALUES (1,'Numeric','NM','Numeric value, including integer or float (e.g., creatinine, weight)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f'),(2,'Coded','CWE','Value determined by term dictionary lookup (i.e., term identifier)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f'),(3,'Text','ST','Free text',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f'),(4,'N/A','ZZ','Not associated with a datatype (e.g., term answers, sets)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f'),(5,'Document','RP','Pointer to a binary or text-based document (e.g., clinical document, RTF, XML, EKG, image, etc.) stored in complex_obs table',1,'2004-04-15 00:00:00',0,NULL,NULL,NULL,'8d4a4e74-c2cc-11de-8d13-0010c6dffd0f'),(6,'Date','DT','Absolute date',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a505e-c2cc-11de-8d13-0010c6dffd0f'),(7,'Time','TM','Absolute time of day',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a591e-c2cc-11de-8d13-0010c6dffd0f'),(8,'Datetime','TS','Absolute date and time',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a5af4-c2cc-11de-8d13-0010c6dffd0f'),(10,'Boolean','BIT','Boolean value (yes/no, true/false)',1,'2004-08-26 00:00:00',0,NULL,NULL,NULL,'8d4a5cca-c2cc-11de-8d13-0010c6dffd0f'),(11,'Rule','ZZ','Value derived from other data',1,'2006-09-11 00:00:00',0,NULL,NULL,NULL,'8d4a5e96-c2cc-11de-8d13-0010c6dffd0f'),(12,'Structured Numeric','SN','Complex numeric values possible (ie, <5, 1-10, etc.)',1,'2005-08-06 00:00:00',0,NULL,NULL,NULL,'8d4a606c-c2cc-11de-8d13-0010c6dffd0f'),(13,'Complex','ED','Complex value.  Analogous to HL7 Embedded Datatype',1,'2008-05-28 12:25:34',0,NULL,NULL,NULL,'8d4a6242-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_derived`
--

DROP TABLE IF EXISTS `concept_derived`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_derived` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `rule` mediumtext,
  `compile_date` datetime DEFAULT NULL,
  `compile_status` varchar(255) DEFAULT NULL,
  `class_name` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `derived_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_derived`
--

LOCK TABLES `concept_derived` WRITE;
/*!40000 ALTER TABLE `concept_derived` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_derived` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `concept_description_uuid_index` (`uuid`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_description`
--

LOCK TABLES `concept_description` WRITE;
/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_map`
--

DROP TABLE IF EXISTS `concept_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) DEFAULT NULL,
  `source_code` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `concept_map_uuid_index` (`uuid`),
  KEY `map_for_concept` (`concept_id`),
  KEY `map_creator` (`creator`),
  KEY `map_source` (`source`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `map_source` FOREIGN KEY (`source`) REFERENCES `concept_source` (`concept_source_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_map`
--

LOCK TABLES `concept_map` WRITE;
/*!40000 ALTER TABLE `concept_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name` (
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `concept_name_uuid_index` (`uuid`),
  KEY `name_of_concept` (`name`),
  KEY `name_for_concept` (`concept_id`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name`
--

LOCK TABLES `concept_name` WRITE;
/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_unique_tags` (`tag`),
  UNIQUE KEY `concept_name_tag_uuid_index` (`uuid`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`)
) AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag`
--

LOCK TABLES `concept_name_tag` WRITE;
/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
INSERT INTO `concept_name_tag` VALUES (1,'default','name to use when nothing else is available',1,'2007-05-01 00:00:00',0,NULL,NULL,NULL,'ea293fca-a8ab-11e1-bdf3-70f39542ef8f'),(2,'short','preferred short name for a concept',1,'2007-05-01 00:00:00',0,NULL,NULL,NULL,'ea294365-a8ab-11e1-bdf3-70f39542ef8f'),(3,'synonym','a different word with similar meaning',1,'2007-05-01 00:00:00',0,NULL,NULL,NULL,'ea29452b-a8ab-11e1-bdf3-70f39542ef8f'),(4,'preferred','preferred name in English',1,'2007-05-01 00:00:00',0,NULL,NULL,NULL,'ea2946d7-a8ab-11e1-bdf3-70f39542ef8f');
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag_map`
--

LOCK TABLES `concept_name_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `precise` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_numeric`
--

LOCK TABLES `concept_numeric` WRITE;
/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) NOT NULL DEFAULT '',
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `concept_proposal_uuid_index` (`uuid`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `user_who_created_proposal` (`creator`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal`
--

LOCK TABLES `concept_proposal` WRITE;
/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal_tag_map`
--

LOCK TABLES `concept_proposal_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `concept_set_uuid_index` (`uuid`),
  KEY `has_a` (`concept_set`),
  KEY `user_who_created` (`creator`),
  KEY `idx_concept_set_concept` (`concept_id`),
  CONSTRAINT `is_a` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set`
--

LOCK TABLES `concept_set` WRITE;
/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_set_derived`
--

DROP TABLE IF EXISTS `concept_set_derived`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set_derived` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`concept_id`,`concept_set`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set_derived`
--

LOCK TABLES `concept_set_derived` WRITE;
/*!40000 ALTER TABLE `concept_set_derived` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set_derived` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_source`
--

DROP TABLE IF EXISTS `concept_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hl7_code` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `concept_source_uuid_index` (`uuid`),
  KEY `unique_hl7_code` (`hl7_code`,`retired`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_source`
--

LOCK TABLES `concept_source` WRITE;
/*!40000 ALTER TABLE `concept_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `concept_state_conversion_uuid_index` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`),
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_state_conversion`
--

LOCK TABLES `concept_state_conversion` WRITE;
/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_word`
--

DROP TABLE IF EXISTS `concept_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_word` (
  `concept_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `word` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(20) NOT NULL DEFAULT '',
  `concept_name_id` int(11) NOT NULL,
  PRIMARY KEY (`concept_word_id`),
  KEY `word_in_concept_name` (`word`),
  KEY `concept_word_concept_idx` (`concept_id`),
  KEY `word_for_name` (`concept_name_id`),
  CONSTRAINT `word_for` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `word_for_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_word`
--

LOCK TABLES `concept_word` WRITE;
/*!40000 ALTER TABLE `concept_word` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `combination` smallint(6) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `dose_strength` double DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `drug_uuid_index` (`uuid`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `drug_creator` (`creator`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_ingredient` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `ingredient_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ingredient_id`,`concept_id`),
  KEY `combination_drug` (`concept_id`),
  CONSTRAINT `ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `combination_drug` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_ingredient`
--

LOCK TABLES `drug_ingredient` WRITE;
/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT '0',
  `dose` double DEFAULT NULL,
  `equivalent_daily_dose` double DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) DEFAULT NULL,
  `prn` smallint(6) NOT NULL DEFAULT '0',
  `complex` smallint(6) NOT NULL DEFAULT '0',
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `inventory_item` (`drug_inventory_id`),
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_order`
--

LOCK TABLES `drug_order` WRITE;
/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL DEFAULT '0',
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `encounter_uuid_index` (`uuid`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_provider` (`provider_id`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `encounter_provider` FOREIGN KEY (`provider_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `encounter_type_uuid_index` (`uuid`),
  KEY `retired_status` (`retired`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_type`
--

LOCK TABLES `encounter_type` WRITE;
/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
INSERT INTO `encounter_type` VALUES (1,'ADULTINITIAL','Outpatient Adult Initial Visit',1,'2005-02-24 00:00:00',0,NULL,NULL,NULL,'8d5b27bc-c2cc-11de-8d13-0010c6dffd0f'),(2,'ADULTRETURN','Outpatient Adult Return Visit',1,'2005-02-24 00:00:00',0,NULL,NULL,NULL,'8d5b2be0-c2cc-11de-8d13-0010c6dffd0f'),(3,'PEDSINITIAL','Outpatient Pediatric Initial Visit',1,'2005-02-24 00:00:00',0,NULL,NULL,NULL,'8d5b2dde-c2cc-11de-8d13-0010c6dffd0f'),(4,'PEDSRETURN','Outpatient Pediatric Return Visit',1,'2005-02-24 00:00:00',0,NULL,NULL,NULL,'8d5b3108-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text,
  `select_multiple` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_uuid_index` (`uuid`),
  KEY `field_retired_status` (`retired`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `concept_for_field` (`concept_id`),
  KEY `user_who_created_field` (`creator`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`),
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `field_answer_uuid_index` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_answer`
--

LOCK TABLES `field_answer` WRITE;
/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` longtext,
  `is_set` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `field_type_uuid_index` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` VALUES (1,'Concept','',0,1,'2005-02-22 00:00:00','8d5e7d7c-c2cc-11de-8d13-0010c6dffd0f'),(2,'Database element','',0,1,'2005-02-22 00:00:00','8d5e8196-c2cc-11de-8d13-0010c6dffd0f'),(3,'Set of Concepts','',1,1,'2005-02-22 00:00:00','8d5e836c-c2cc-11de-8d13-0010c6dffd0f'),(4,'Miscellaneous Set','',1,1,'2005-02-22 00:00:00','8d5e852e-c2cc-11de-8d13-0010c6dffd0f'),(5,'Section','',1,1,'2005-02-22 00:00:00','8d5e86fa-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(50) NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` smallint(6) NOT NULL DEFAULT '0',
  `description` text,
  `encounter_type` int(11) DEFAULT NULL,
  `template` mediumtext,
  `xslt` mediumtext,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_uuid_index` (`uuid`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_created_form` (`creator`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` smallint(6) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `sort_weight` float(11,5) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `form_field_uuid_index` (`uuid`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`),
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` mediumtext,
  `description` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `global_property_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_property`
--

LOCK TABLES `global_property` WRITE;
/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
INSERT INTO `global_property` VALUES ('concept.causeOfDeath','5002','Concept id of the concept defining the CAUSE OF DEATH concept','0807c125-b706-44b9-a60b-fde3e61ccb88'),('concept.cd4_count','5497','Concept id of the concept defining the CD4 count concept','fe0889d1-c2fe-477a-a860-a2e3b7c1b29b'),('concept.height','5090','Concept id of the concept defining the HEIGHT concept','6fa212e1-5f8b-4fa8-884a-5cb6e35183ce'),('concept.medicalRecordObservations','1238','The concept id of the MEDICAL_RECORD_OBSERVATIONS concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','77ded36f-3f71-4a57-8b25-aa4f1713dbb8'),('concept.none','1107','Concept id of the concept defining the NONE concept','63a62589-73c6-4c33-8880-11e693d3db4c'),('concept.otherNonCoded','5622','Concept id of the concept defining the OTHER NON-CODED concept','f8a647b8-b13c-4e8d-9cae-1c1d59941ade'),('concept.patientDied','1742','Concept id of the concept defining the PATIENT DIED concept','2d71ba27-bf53-4387-9303-ce13a5b13d89'),('concept.problemList','1284','The concept id of the PROBLEM LIST concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','a9fa5905-b483-4b0f-a7f6-6df1d3307c1a'),('concept.reasonExitedCare','','Concept id of the concept defining the REASON EXITED CARE concept','acbadf47-9158-401e-b3a9-ee6387883441'),('concept.reasonOrderStopped','1812','Concept id of the concept defining the REASON ORDER STOPPED concept','2d3c2e1e-58e1-4f87-8dfb-f74bb98f43fb'),('concept.weight','5089','Concept id of the concept defining the WEIGHT concept','2a81f5ae-7f23-453f-abf1-6d733223510c'),('concepts.locked','false','true/false whether or not concepts can be edited in this database.','0b9736de-7be8-45fe-b98b-87462683c87b'),('dashboard.encounters.showEditLink','true','true/false whether or not to show the \'Edit Encounter\' link on the patient dashboard','140e955a-2da8-4c36-a75e-c835a74a87b7'),('dashboard.encounters.showEmptyFields','true','true/false whether or not to show empty fields on the \'View Encounter\' window','f6321981-e4a8-45ee-8858-eb7f2d96015c'),('dashboard.encounters.showViewLink','true','true/false whether or not to show the \'View Encounter\' link on the patient dashboard','6c0e2b5b-d070-424b-bc01-97874b136127'),('dashboard.encounters.usePages','smart','true/false/smart on how to show the pages on the \'View Encounter\' window.  \'smart\' means that if > 50% of the fields have page numbers defined, show data in pages','2de6cead-ec6c-4cbe-8c4e-b1add6f33207'),('dashboard.header.programs_to_show','','List of programs to show Enrollment details of in the patient header. (Should be an ordered comma-separated list of program_ids or names.)','5c92803e-ed6e-46ec-acb6-cf1930b898d6'),('dashboard.header.workflows_to_show','','List of programs to show Enrollment details of in the patient header. List of workflows to show current status of in the patient header. These will only be displayed if they belong to a program listed above. (Should be a comma-separated list of program_workflow_ids.)','0caf2755-64d0-45a3-bf29-025627b04831'),('dashboard.overview.showConcepts','','Comma delimited list of concepts ids to show on the patient dashboard overview tab','7d0dd6c4-8c6f-423a-8763-d6537cf8978c'),('dashboard.regimen.displayDrugSetIds','ANTIRETROVIRAL DRUGS,TUBERCULOSIS TREATMENT DRUGS','Drug sets that appear on the Patient Dashboard Regimen tab. Comma separated list of name of concepts that are defined as drug sets.','7edc005e-e0ac-4ef1-9539-8cfd1214f3b9'),('dashboard.regimen.standardRegimens','<list>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>2</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>3TC + d4T(30) + NVP (Triomune-30)</displayName>    <codeName>standardTri30</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>3</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>3TC + d4T(40) + NVP (Triomune-40)</displayName>    <codeName>standardTri40</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>39</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion>        <drugId>22</drugId>        <dose>200</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>AZT + 3TC + NVP</displayName>    <codeName>standardAztNvp</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion reference=\"../../../regimenSuggestion[3]/drugComponents/drugSuggestion\"/>      <drugSuggestion>        <drugId>11</drugId>        <dose>600</dose>        <units>mg</units>        <frequency>1/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>AZT + 3TC + EFV(600)</displayName>    <codeName>standardAztEfv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>5</drugId>        <dose>30</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion>        <drugId>42</drugId>        <dose>150</dose>        		<units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion reference=\"../../../regimenSuggestion[4]/drugComponents/drugSuggestion[2]\"/>    </drugComponents>    <displayName>d4T(30) + 3TC + EFV(600)</displayName>    <codeName>standardD4t30Efv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>6</drugId>        <dose>40</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion reference=\"../../../regimenSuggestion[5]/drugComponents/drugSuggestion[2]\"/>      <drugSuggestion reference=\"../../../regimenSuggestion[4]/drugComponents/drugSuggestion[2]\"/>    </drugComponents>    <displayName>d4T(40) + 3TC + EFV(600)</displayName>    <codeName>standardD4t40Efv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion></list>','XML description of standard drug regimens, to be shown as shortcuts on the dashboard regimen entry tab','7813d68d-524c-49ed-8bc2-fd7c435ca579'),('dashboard.relationships.show_types','','Types of relationships separated by commas.  Doctor/Patient,Parent/Child','a3853e2a-5a1a-486f-b92a-9dfa7d2722fb'),('default_locale','en_GB','Specifies the default locale. You can specify both the language code(ISO-639) and the country code(ISO-3166), e.g. \'en_GB\' or just country: e.g. \'en\'','63455993-c64d-4fd4-8987-51fe7395477a'),('encounterForm.obsSortOrder','number','The sort order for the obs listed on the encounter edit form.  \'number\' sorts on the associated numbering from the form schema.  \'weight\' sorts on the order displayed in the form schema.','4061e5a8-e50c-4ac2-a4ed-d70a80622c43'),('FormEntry.enableDashboardTab','true','true/false whether or not to show a Form Entry tab on the patient dashboard','1822b1d1-cd8a-4357-89e8-dfe51967aba8'),('FormEntry.enableOnEncounterTab','false','true/false whether or not to show a Enter Form button on the encounters tab of the patient dashboard','66fe9f5f-e9af-4998-ac37-6a8cc24b6399'),('gzip.enabled','false','Set to \'true\' to turn on OpenMRS\'s gzip filter, and have the webapp compress data before sending it to any client that supports it. Generally use this if you are running Tomcat standalone. If you are running Tomcat behind Apache, then you\'d want to use Apache to do gzip compression.','99ad7e2f-94fc-4950-9197-a55448401e4f'),('hl7_processor.ignore_missing_patient_non_local','false','If true, hl7 messages for patients that are not found and are non-local will silently be dropped/ignored','8c7842c9-ee07-4ad0-98dc-08ce0336695d'),('layout.address.format','general','Format in which to display the person addresses.  Valid values are general, kenya, rwanda, usa, and lesotho','cdd05f05-6dd8-4f92-906e-d6ffb7e86003'),('layout.name.format','short','Format in which to display the person names.  Valid values are short, long','e31347d6-5970-44e5-8d22-491a9234c011'),('locale.allowed.list','en, es, fr, it, pt','Comma delimited list of locales allowed for use on system','c173faf6-c755-4604-b3cb-69acc958657f'),('log.level.openmrs','info','log level used by the logger \'org.openmrs\'. This value will override the log4j.xml value. Valid values are trace, debug, info, warn, error or fatal','a881249c-fd4d-43fb-843f-c6d6f8d65f5c'),('logic.database_version','1.4','DO NOT MODIFY.  Current database version number for the logic module.','29d15610-72c1-44cd-8603-3905ca06a071'),('logic.default.ruleClassDirectory','logic/class','Default folder where compiled rule will be stored','cea97186-4056-488d-8ff4-40d42e3a3c6e'),('logic.default.ruleJavaDirectory','logic/sources','Default folder where rule\'s java file will be stored','261e09e2-313e-4c1a-8db7-60e3eecedb4f'),('logic.defaultTokens.conceptClasses','','When registering default tokens for logic, if you specify a comma-separated list of concept class names here, only concepts of those classes will have tokens registered. If you leave this blank, all classes will have tokens registered for their concepts.','68dabae9-0832-4b3e-a62d-3ed0eb9bd13e'),('logic.mandatory','false','true/false whether or not the logic module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','8acc893c-aeb8-4a89-9da7-62121748bd8b'),('logic.started','true','DO NOT MODIFY. true/false whether or not the logic module has been started.  This is used to make sure modules that were running  prior to a restart are started again','74d8a7b1-cf88-466b-bf45-ce031cd5c881'),('mail.debug','false','true/false whether to print debugging information during mailing','23446014-d7fa-464e-9d87-9477de056fdf'),('mail.default_content_type','text/plain','Content type to append to the mail messages','e94063ef-ddd1-4b8a-943e-d1d14bc16fea'),('mail.from','info@openmrs.org','Email address to use as the default from address','5ef03d89-ff43-4d84-8b7b-dd662783a31d'),('mail.password','test','Password for the SMTP user (if smtp_auth is enabled)','9ebb0fea-03ea-4a41-8593-8a1b767ce28e'),('mail.smtp_auth','false','true/false whether the smtp host requires authentication','bf258c22-104d-4075-9a29-e1888a4f5f53'),('mail.smtp_host','localhost','SMTP host name','eae0f8db-823b-434c-9093-a1d7078b8793'),('mail.smtp_port','25','SMTP port','337c5491-87d8-4081-8282-6e38e2e78500'),('mail.transport_protocol','smtp','Transport protocol for the messaging engine. Valid values: smtp','dddb3ff0-9e31-4436-9a73-a9923d4d5ac3'),('mail.user','test','Username of the SMTP user (if smtp_auth is enabled)','9cd291f5-2f5c-4458-a511-2f2989772dac'),('minSearchCharacters','3','Number of characters user must input before searching is started.','68d6dc67-77a2-4d4b-add6-006f5ab594b7'),('module_repository_folder','modules','Name of the folder in which to store the modules','508f72a2-a9d8-45e4-bce6-a34b7936c792'),('newPatientForm.relationships','','Comma separated list of the RelationshipTypes to show on the new/short patient form.  The list is defined like \'3a, 4b, 7a\'.  The number is the RelationshipTypeId and the \'a\' vs \'b\' part is which side of the relationship is filled in by the user.','c6214db1-3dbe-456d-82c9-d59bd9ac9c3c'),('new_patient_form.showRelationships','false','true/false whether or not to show the relationship editor on the addPatient.htm screen','2519d2a1-511b-436c-94ab-39979dd791bc'),('obs.complex_obs_dir','complex_obs','Default directory for storing complex obs.','1414ef72-dd6b-4550-84bc-0c5f2c39dc5d'),('patient.defaultPatientIdentifierValidator','org.openmrs.patient.impl.LuhnIdentifierValidator','This property sets the default patient identifier validator.  The default validator is only used in a handful of (mostly legacy) instances.  For example, it\'s used to generate the isValidCheckDigit calculated column and to append the string \"(default)\" to the name of the default validator on the editPatientIdentifierType form.','861164f0-652d-44aa-a18c-7b5376fb1919'),('patient.headerAttributeTypes','','A comma delimited list of PersonAttributeType names that will be shown on the patient dashboard','63dfb3da-e27d-439c-b190-e3e3eb29a581'),('patient.identifierPrefix','','This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','16d45574-e597-4aa2-95b0-ad87a8f49392'),('patient.identifierRegex','','WARNING: Using this search property can cause a drop in mysql performance with large patient sets.  A MySQL regular expression for the patient identifier search strings.  The @SEARCH@ string is replaced at runtime with the user\'s search string.  An empty regex will cause a simply \'like\' sql search to be used. Example: ^0*@SEARCH@([A-Z]+-[0-9])?$','418c5480-4a56-471b-9cc6-a2951be1be9d'),('patient.identifierSearchPattern','','If this is empty, the regex or suffix/prefix search is used.  Comma separated list of identifiers to check.  Allows for faster searching of multiple options rather than the slow regex. e.g. @SEARCH@,0@SEARCH@,@SEARCH-1@-@CHECKDIGIT@,0@SEARCH-1@-@CHECKDIGIT@ would turn a request for \"4127\" into a search for \"in (\'4127\',\'04127\',\'412-7\',\'0412-7\')\"','0682e913-df24-4076-b44c-acf2c925def4'),('patient.identifierSuffix','','This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','29aba404-b2b6-404e-a253-c3a143ee9859'),('patient.listingAttributeTypes','','A comma delimited list of PersonAttributeType names that should be displayed for patients in _lists_','7aa28c3e-bbc6-427d-95f3-365a40ed8c7c'),('patient.viewingAttributeTypes','','A comma delimited list of PersonAttributeType names that should be displayed for patients when _viewing individually_','72aa7a71-83a6-45ec-a67d-6c9816376ed9'),('patient_identifier.importantTypes','','A comma delimited list of PatientIdentifier names : PatientIdentifier locations that will be displayed on the patient dashboard.  E.g.: TRACnet ID:Rwanda,ELDID:Kenya','77a5a9f3-34e9-4a58-b6fb-6867400b83f0'),('person.searchMaxResults','1000','The maximum number of results returned by patient searches','294eda94-c0e4-45f9-96f1-dd0b50778550'),('report.xmlMacros','','Macros that will be applied to Report Schema XMLs when they are interpreted. This should be java.util.properties format.','0b1d59cd-144e-4d20-864a-4ee590c45d6b'),('scheduler.password','test','Password for the OpenMRS user that will perform the scheduler activities','c196f9ed-9de6-4b2b-a8ff-eaf8834b1ec9'),('scheduler.username','admin','Username for the OpenMRS user that will perform the scheduler activities','f868d600-d258-4196-b3bf-321787906fa0'),('security.passwordCannotMatchUsername','true','Configure whether passwords must not match user\'s username or system id','a5699c6c-a6ad-4a7d-b938-5f26428c485c'),('security.passwordCustomRegex','','Configure a custom regular expression that a password must match','fc38473f-7cfb-4b83-b276-3ed43fcc1155'),('security.passwordMinimumLength','8','Configure the minimum length required of all passwords','3434bd77-4e50-4b10-926a-8401f798d929'),('security.passwordRequiresDigit','true','Configure whether passwords must contain at least one digit','23836c10-1543-4176-9ae6-46a64e0ae68c'),('security.passwordRequiresNonDigit','true','Configure whether passwords must contain at least one non-digit','43508128-4645-4145-8c32-9c61ab039988'),('security.passwordRequiresUpperAndLowerCase','true','Configure whether passwords must contain both upper and lower case characters','94b635d8-c954-402a-ae15-f9c8bd260941'),('user.headerAttributeTypes','','A comma delimited list of PersonAttributeType names that will be shown on the user dashboard. (not used in v1.5)','8e9c7d72-a89e-46e6-9646-a55b99734de1'),('user.listingAttributeTypes','','A comma delimited list of PersonAttributeType names that should be displayed for users in _lists_','e69cb3bf-eda5-445e-9e3f-bfc78e64fe4d'),('user.viewingAttributeTypes','','A comma delimited list of PersonAttributeType names that should be displayed for users when _viewing individually_','84e287a1-e50c-4b89-9ffa-73af93a6c714'),('use_patient_attribute.healthCenter','false','Indicates whether or not the \'health center\' attribute is shown when viewing/searching for patients','d62b64d5-53c3-4a94-b9b7-0fd20d6c41fd'),('use_patient_attribute.mothersName','false','Indicates whether or not mother\'s name is able to be added/viewed for a patient','4a42beba-9f4c-4b39-81e4-35e5980ef322');
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` mediumtext NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `message_state` int(1) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `hl7_in_archive_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_archive`
--

LOCK TABLES `hl7_in_archive` WRITE;
/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` mediumtext NOT NULL,
  `error` varchar(255) NOT NULL DEFAULT '',
  `error_details` text,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `hl7_in_error_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_error`
--

LOCK TABLES `hl7_in_error` WRITE;
/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` mediumtext NOT NULL,
  `message_state` int(1) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `hl7_in_queue_uuid_index` (`uuid`),
  KEY `hl7_source` (`hl7_source`),
  CONSTRAINT `hl7_source` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_queue`
--

LOCK TABLES `hl7_in_queue` WRITE;
/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `hl7_source_uuid_index` (`uuid`),
  KEY `creator` (`creator`),
  CONSTRAINT `creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_source`
--

LOCK TABLES `hl7_source` WRITE;
/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
INSERT INTO `hl7_source` VALUES (1,'LOCAL','',1,'2006-09-01 00:00:00','8d6b8bb6-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `MD5SUM` varchar(32) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangelog`
--

LOCK TABLES `liquibasechangelog` WRITE;
/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` VALUES ('0','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:20','112fa925e7ce223f9dfc1c841176b4c','Custom Change','Run the old sqldiff file to get database up to the 1.4.0.20 version if needed. (Requires \'mysql\' to be on the PATH)',NULL,'1.9.4'),('02232009-1141','nribeka','liquibase-update-to-latest.xml','2012-05-28 11:59:42','aa7af8d8a609c61fd504e6121b8feda','Modify Column','Modify the password column to fit the output of SHA-512 function',NULL,'1.9.4'),('1','upul','liquibase-update-to-latest.xml','2012-05-28 11:59:20','aeb2c081fe662e3375a02ea34696492','Add Column','Add the column to person_attribute type to connect each type to a privilege',NULL,'1.9.4'),('1226348923233-12','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:17','1ef82a3a056d8fe77c51789ee3e270','Insert Row (x11)','',NULL,'1.9.4'),('1226348923233-13','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:17','1fbe86152e13998b4e9dfa64f8f99e1','Insert Row (x2)','',NULL,'1.9.4'),('1226348923233-14','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:17','37d7a09a3680241c2cd870bf875f7679','Insert Row (x4)','',NULL,'1.9.4'),('1226348923233-15','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','6f5fdf6fe4573d335b764e8c3f6dec9','Insert Row (x15)','',NULL,'1.9.4'),('1226348923233-16','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','e3fb7531421d36297f9b551aa14eed3','Insert Row','',NULL,'1.9.4'),('1226348923233-17','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','2c3a40aea75302fa5eda34e68f0b5a8','Insert Row (x2)','',NULL,'1.9.4'),('1226348923233-18','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','a077f3e88c77b1bcfd024568ce97a57','Insert Row (x2)','',NULL,'1.9.4'),('1226348923233-2','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:14','17915c6b808f125502a8832f191896a','Insert Row (x5)','',NULL,'1.9.4'),('1226348923233-20','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','74d4c95919a87ad385f4678c05befeb','Insert Row','',NULL,'1.9.4'),('1226348923233-21','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:18','cad8f9efce142229ad5030139ae2ee62','Insert Row','',NULL,'1.9.4'),('1226348923233-22','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:19','98e8afcf7f83f1f2fe6ae566ae71b','Insert Row','',NULL,'1.9.4'),('1226348923233-23','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:19','877ae775e48051291b94467caebdbf9','Insert Row','',NULL,'1.9.4'),('1226348923233-5','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:15','e69c9cbc8e906c10b7b19ce95c6fbb','Insert Row','',NULL,'1.9.4'),('1226348923233-6','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:16','afbc17f0c1c778754be371db868719f','Insert Row (x14)','',NULL,'1.9.4'),('1226348923233-8','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:16','52afbf2cc39cde1fed9c97b8886ef','Insert Row (x7)','',NULL,'1.9.4'),('1226348923233-9','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:17','f8de838176dd923fe06ff3346fd2e9c7','Insert Row (x4)','',NULL,'1.9.4'),('1226412230538-9a','ben (generated)','liquibase-core-data.xml','2012-05-28 11:59:19','d19735782014e65d28267d83a681fac','Insert Row (x4)','',NULL,'1.9.4'),('1227303685425-1','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:49','4b1d6f6458503aad8cf53c8583648d1','Create Table','',NULL,'1.9.4'),('1227303685425-10','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:52','1ca890687d9198679930117b437bdcb8','Create Table','',NULL,'1.9.4'),('1227303685425-100','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:17','c4f0efe639c65a0ca719a7672c9ae99','Create Index','',NULL,'1.9.4'),('1227303685425-101','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:17','ec489290e24b9bc8e7cefa4cb193a5','Create Index','',NULL,'1.9.4'),('1227303685425-102','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:17','3fffc270441f9846be7f6f15b9186fe','Create Index','',NULL,'1.9.4'),('1227303685425-103','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:17','5bca419b6ce805277a7f1e853492965','Create Index','',NULL,'1.9.4'),('1227303685425-104','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:17','f5921bfce0567fad9dbebf4a464b7b8','Create Index','',NULL,'1.9.4'),('1227303685425-105','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:18','a8e830de2d9b5b30b5cee4f96e3d4f','Create Index','',NULL,'1.9.4'),('1227303685425-106','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:18','7e434b23ab45109451cc494fc7b66831','Create Index','',NULL,'1.9.4'),('1227303685425-107','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:18','347132fbd16c8712058e1f95765ce26','Create Index','',NULL,'1.9.4'),('1227303685425-108','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:19','5b4184878459e4fc9341a43b4be64ef','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-109','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:19','c2bfb4e612aa1973f1c365ad7118f342','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-11','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:52','fa7989647192649dc172d64046eb90','Create Table','',NULL,'1.9.4'),('1227303685425-110','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:20','d6659d52c5bcac8b59fb8ba1a37f86','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-111','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:20','f995cd7d34245c41d575977cf271ccc6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-112','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:20','83c9df4fa7c9a7d84cdd930ff59776','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-113','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:21','581e495dd2e0605b389c1d497388786f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-114','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:21','833048d0b4aae48cec412ca39b7b742','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-115','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:21','a08b4c2b2cced32d89b1d4b31b97458','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-116','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:22','eeec2cd3e6dddfebf775011fb81bd94','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-117','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:22','9f80b1cfa564da653099bec7178a435','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-118','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:22','1e5f598cefabaaa8ef2b1bec0b95597','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-119','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:23','698c2d5e06fb51de417d1ed586129','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-12','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:52','9375592183aa2b5d4ad11a937595d9','Create Table','',NULL,'1.9.4'),('1227303685425-120','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:24','d05ee670738deebde0131d30112ec4ae','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-121','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:25','b248338c8498759a3ea4de4e3b667793','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-122','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:26','f2636dd6c2704c55fb9747b3b8a2a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-123','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:26','307598cfdfdae399ad1ce3e7c4a8467','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-124','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:27','ce9674c37a991460aed032ad5cb7d89','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-125','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:27','dface46a9bf5a1250d143e868208865','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-126','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:28','de1299f5403e3360e1c2c53390a8b29c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-127','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:28','5e7f8e3b6bf0fc792f3f302d7cb2b3','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-128','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:28','2d81a031cf75efab818d6e71fd344c24','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-129','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:29','ad7b4d0e76518df21fff420664ea52','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-13','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:53','8a81103ce3bf6f96ae9a3cd5ea11da4','Create Table','',NULL,'1.9.4'),('1227303685425-130','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:29','ca1a1a1be5462940b223815c43d43ee','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-131','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:29','1e994b0469d1759c69824fa79bb47e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-132','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:29','71079c961b9b64fc0642ed69b944bef','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-133','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:30','b7f75569bbf9932631edb2ded9a412','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-134','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:30','bfdf173f27999984c8fef82bb496c880','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-135','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:30','fceb5cc5466c89f54fab47951181ead','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-136','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:31','05f6a40bc30fe272b4bd740ad7709f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-137','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:31','e4d42fbfe1248f205c9221b884c8e71','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-138','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:31','9ebf8d9bb9541ceba5a7ed25d55978','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-139','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:31','4ab8e4364cdb9f61f512845b537a5e33','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-14','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:53','2b11cd2e016b3967d4806872727ec7','Create Table','',NULL,'1.9.4'),('1227303685425-140','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:32','48d01547623e48d3b4d11d547c28c28','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-141','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:32','1f2917f6f1523ca240c9dfd44ccdfa66','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-142','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:32','d826371493865456e85a06649e83a9d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-143','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:32','669e47429cecc0ebe20c9e4724ad1b','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-144','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:33','fc622179fac4171f122cdbb217a5332','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-145','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:33','3ab7a04513262a248a1584ea9eb6342','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-146','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:33','9c9b88b77c842272ab95b913d2c45f1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-147','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:34','6d2f3c8fd1a6fd222cd9e64626ec2414','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-148','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:34','7f99bbffa5152188ccd74e889cc69344','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-149','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:34','2971495b795edfbc771618d9d178179','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-15','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:53','2b1462a7269e8d188326f9439ec1a0','Create Table','',NULL,'1.9.4'),('1227303685425-150','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:35','7453c6b2dc234075444921641f038cf','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-151','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:35','62bfd65133eb8649823b76e28f749ae4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-152','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:35','41f97398c21bcc4f3bbfa57ac36167','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-153','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:35','34a3388e508254798882f090113b91e9','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-154','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:36','cd1c528d9bbd8cd521f55f51507f2448','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-155','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:36','59169212323db3843f2d240afaab688','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-156','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:37','cb904d9071798e490aaf1a894777b','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-157','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:37','ec5e335c2d6ef840ba839d2d7cab26bf','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-158','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:37','edba928f8f3af2b720d1ae52c3da29','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-159','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:37','1d631d1b5585f307b5bba3e94104897','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-16','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:54','4a97582b5459ea8f1d718cc7044517b','Create Table','',NULL,'1.9.4'),('1227303685425-160','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:39','5af7bfc7acbef7db5684ff3e662d7b1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-161','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:39','d65716f46e431b417677fb5754f631cf','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-162','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:39','a823cf39649373bf762fc2ddc9a3b4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-163','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:40','8efed95ebdac55227fd711cb18c652a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-164','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:40','f7cb86e864d7b259bb63c73cb4cf1e8','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-165','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:40','5da4fd35f568ae85de6274f6fb179dd','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-166','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:41','d6a910cfe97bc6aed5e54ec1cadd89b','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-167','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:41','adf31a2b3145f38cfc94632966dc0cf','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-168','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:41','d3984f9f372ff0df21db96aeae982cab','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-169','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:41','296119308b945663ddbd5b4b719e53','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-17','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:54','88a9a422647683aedba68c299823683d','Create Table','',NULL,'1.9.4'),('1227303685425-170','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:42','be7a3bc89baac1b0b2e0fe51991bd015','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-171','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:42','ca59f633dbae6e045d58b4cca6cc7c5','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-172','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:42','6325d6535f7cf928fa84a37a72605dfb','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-173','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:42','351518f028727083f95bc8d54c295c2a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-174','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:43','3e888947a28e23f88510af9514767590','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-175','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:43','5fef7a2498f6d631e1228efc2bdef6c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-176','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:43','2bd625c243b7583c86a9bffd3215a741','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-177','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:43','426c4bccb537fb3f4c3d3e26fff73018','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-178','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:44','fc3d34e4c7f55660abad9d79fa9f19','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-179','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:44','41071cc7cfeec957e73ede6cec85063','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-18','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:54','44be2c894ba65ba6dff11859325ee1e7','Create Table','',NULL,'1.9.4'),('1227303685425-180','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:44','17f13d77392855ff797b2ee5938150b','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-181','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:44','1e87e405f78834da8449c3dd538ea69','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-182','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:44','7e5895b2826c9b539643c2a52db136bd','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-183','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:45','1ed87f73bb22c85a678e7486ce316e4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-184','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:45','dd523eb3c0d47022fd3ccde778a7b21','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-185','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:45','bf22dffeb46511b2c54caa2edde81cf','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-186','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:45','bcd25ca2c2592b19d299b434d4e2b855','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-187','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:45','c552885fe12d78ad9d9e902e85c2e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-188','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:46','1be8a7c821c27ac5f24f37ea72dde4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-189','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:46','5ebe66c9ad8928b9dd571fbf2e684342','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-19','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:54','8fea50c3c68aa5e3caa8a29ac1ed2bc2','Create Table','',NULL,'1.9.4'),('1227303685425-190','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:46','765abd819360e17b449b349e3c6fb4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-191','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:46','eefbf72ce449dfa6d87903b9d48fc14','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-192','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:47','c49e3e3ef4748a6d227822ba9d9db75','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-193','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:47','8734c3bf33d23c5167926fde1c2497b1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-194','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:47','acf63f4166b9efbeec94a33b9873b6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-195','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:47','a6893ed94b1c673064e64f31e76922e3','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-196','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:47','4d10fc7df1588142908dfe1ecab77983','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-197','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:48','77df8c771bcafcdc69e0f036fa297e56','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-198','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:48','37bb62897883da1e2833a1ab2088edb','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-199','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:48','4dc522cef2d9e8f6679f1ad05d5e971e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-2','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:49','484d95d2ffed12fa0ee8aee8974b567','Create Table','',NULL,'1.9.4'),('1227303685425-20','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:55','7faf5302b18d5ce205b723bca1542c','Create Table','',NULL,'1.9.4'),('1227303685425-200','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:48','939ac86f57297fc01f80b129247630f5','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-201','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:49','9bf8c421b14fa2c8e5784f89c3d8d65','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-202','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:49','309ecd6871c152c8c2f87a80f520a68a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-203','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:49','c8ac825ea236dd980f088849eb6e974','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-204','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:49','3094b038b0f828dbe7d0296b28eb3f73','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-205','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:49','5a12d2856974981835ba499d73ac1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-206','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:50','c1abccf6ee7c67d4471cc292fa878aa','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-207','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:50','ef6b7d9cb53938c0e8682daeb5af97e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-208','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:51','a8a7f2b6ac8fa17b814ab859b4532fd','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-209','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:51','137480e6ed47c390e98547b0551d39f4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-21','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:55','ea3ef386b2dfb64cb9df5c1fbc6378','Create Table','',NULL,'1.9.4'),('1227303685425-210','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:52','fa37aa2bf95f6b24806ad4fab3b16e26','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-211','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:52','e3cfdbbc639a13bb42471dbecdc2d88','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-212','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:52','6eee35721da53ff117ababbae33bd5','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-213','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:53','c591a16e2a8fcc25ef4aa858692dfef','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-214','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:53','56c3ba4cfa55218d3aa0238ec2275f0','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-215','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:53','48563ec0b8762dce6bf94e068b27cb5','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-216','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','396121d768871a53120935cf19420d7','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-217','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','ebfbd07cd866453255b3532893163562','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-218','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','1530c85467d1b6d6980c794dbfd33f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-219','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','5061bae5afea383d93b6f8b118253d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-22','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:55','4b9fbcceb5de1c20b8338e96328198','Create Table','',NULL,'1.9.4'),('1227303685425-220','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','e4ccb7132533b42c47f77abf5ef26','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-221','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:54','ff49796922743ca6aec19ec3a4ee2d8','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-222','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:55','b6a54d3e4d64fd39ef72efb98dfc936','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-223','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:55','a4de4db8a76fd815c83b53fd5f67fee1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-224','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:55','22ea56d2224297e8252864e90466c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-225','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:55','dfccc3b975a9f5b8ec5b27164c2d6d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-226','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:56','e34f2fe84f1222d6aa5eb652f8d17f44','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-227','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:56','6bf6811bac713b4761afbba7756e1a61','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-228','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:56','4732be71b8c8fbf39bc1df446af78751','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-229','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:56','73d11a5ae7bf33aa516119311cbc16f6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-23','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:56','88e233ad3125c41ed528a721cfe2345f','Create Table','',NULL,'1.9.4'),('1227303685425-230','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:57','ee2e35bc91b5e1b01f2048c987caf6c4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-231','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:57','63bbb76e789fcad6b69bd4c64f5950','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-232','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:57','76be79df3e103cc45f4ee148555e4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-233','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:57','e7b3a215c88f4d892fa76882e5159f64','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-234','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:57','8c28fb289889fdd53acda37d11112ce2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-235','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:58','6cdeded260bdceb9e1826d4ffbf5a375','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-236','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:58','28e4b2fa85d59877ad9fa54c6d2b031','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-237','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:58','a1ffd0638df4322f16f8726f98b4f2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-238','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:58','41aa312b273ec9ebf460faaa6e6b299c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-239','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:58','20d4b6e95fcfb79a613a24cf75e86c6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-24','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:56','b2efc086868b3c3274b7d68014b6ea93','Create Table','',NULL,'1.9.4'),('1227303685425-240','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:59','589dcc4157bfcf62a427f2ce7e4e1c29','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-241','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:59','52bde811efcc8b60f64bc0317ee6045','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-242','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:59','c58692cfa01f856a60b98215ba62e5a7','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-243','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:59','6d44d317d139438e24ff60424ea7df8d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-244','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:00','e6e61db0f6b2f486a52797219e8545f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-245','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:00','f5403a8a515082dd136af948e6bf4c97','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-246','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:00','fa4d4b30d92fa994ee2977a353a726f1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-247','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:01','67b39f2b2132f427ff2a6fcf4a79bdeb','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-248','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:01','e67632f4fa63536017f3bcecb073de71','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-249','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:01','4c81272b8d3d7e4bd95a8cf8e9a91e6a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-25','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:56','add581f3645d35c6ef17892ea196362','Create Table','',NULL,'1.9.4'),('1227303685425-250','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:01','54fb2e3a25332da06e38a9d2b43badfd','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-251','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:02','fb1a29f3188a43c1501e142ba09fd778','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-252','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:02','e5c417adb79757dd942b194ad59cd2e3','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-253','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:02','412115fd6d7bedbba0d3439617328693','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-254','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:02','e76b81d6b51f58983432c296f319e48','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-255','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:02','80703c6fd0656cf832f32f75ad64f3','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-256','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:03','88b295bfc4d05f928c8d7cbf36c84d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-257','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:03','853fb4af8c20137ecf9d858713cff6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-258','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:04','c33b2874e3d38ddef784a0ccb03e3f74','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-259','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:04','bb18dfa78fe1322413ff4f0871712a','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-26','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:56','d11eef4b608b5de1be8c24f4cef73a1','Create Table','',NULL,'1.9.4'),('1227303685425-260','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:04','f0953d50abcef615f855b6d6ef0bbd3','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-261','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:05','2e24f8fdf2b3dfb9abb02ccaeee87f4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-262','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:05','28d3165b5789d4ccb62ac271c8d86bdd','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-263','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:05','7f93b659cc1a2a66c8666f7ab5793b','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-264','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:05','c51f76c76ca7945eeb2423b56fd754ff','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-265','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:05','46b310f19ea8c0da3afd50c7f2717f2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-266','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:06','aa7981765d72e6c22281f91c71602ce2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-267','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:06','b2bc8373ebb491233bea3b6403e2fea','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-268','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:06','f4882dfee1f2ffac3be37258a8ec4c43','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-269','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:06','4c9212f9fa9f24ef868c7fd5851b7e8f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-27','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:57','98d1653ea222665c66abb33ccd18853f','Create Table','',NULL,'1.9.4'),('1227303685425-270','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:07','aaf31e19b19f9e4b840d08ea730d1','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-271','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:07','47c543135499fdcd7f1ea1a4a71e495d','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-272','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:07','7df76774c3f25483e4b9612eee98d8','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-273','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:07','6cbef8ca7253e9b6941625756e3ead12','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-274','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:07','99c026624d5987f4a39b124c473da2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-275','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:08','bab45b77299235943c469ca9e0396cff','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-276','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:08','c50376c85bff6bdf26a4ca97e2bfe','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-277','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:08','e7e8229acc4533fd3fca7534e531063','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-278','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:08','aed02dbce85e293159b787d270e57d63','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-279','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:08','93ce9101c3bc7214721f3163b11c33','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-28','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:59','a185fd8a442e66a329161f429e8c10f5','Create Table','',NULL,'1.9.4'),('1227303685425-280','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:09','cef4a9e68e71659662adddd67c976','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-281','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:09','929d293722d1d652834da0ceefa9c841','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-282','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:09','7a2834f44349838fcfbcb61648bc8a0','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-283','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:09','dd19eeb1b52497428e644a84f0653c8e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-284','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:09','8bc32e874e45a6cdd60184e9c92d6c4','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-285','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:10','66af85da9d747cf7b13b19c358fd93c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-286','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:10','14ac9a98a545c5b172c021486d1d36','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-287','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:10','7c4e227cf011839ef78fb4a83ed59d6','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-288','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:10','ab73c07b88fcfd7fffcd2bd41e05ec8','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-289','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:10','ffb7495ff05d83cf97d9986f895efe0','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-29','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:59','3524a06b47e415769fd22f9bd6442d6','Create Table','',NULL,'1.9.4'),('1227303685425-290','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:11','fd25f4e5377a68bc11f6927ec4ba1dc','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-291','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:11','fbdd163ca23861baa2f84dce077b6c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-292','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:11','d0eebd47c26dc07764741ee4b1ac72','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-293','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:11','28b8cd9a32fb115c9c746712afa223','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-294','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:11','ada81a1d3e575780a54bbe79643db8fc','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-295','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:12','93e944816ec2dc7b31984a9e4932f3bb','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-296','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:12','54d71bd27cb66b9eb12716bdce3c7c','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-297','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:12','a9429cc74fb131d5d50899a402b21f','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-298','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:12','e38bd6437d3ce8274e16d02e73e976a8','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-299','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:12','2dcda62270603cbfa1581d1339b0a18e','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-3','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:50','1eeb9f4467c832c61b2cadf8da592ba9','Create Table','',NULL,'1.9.4'),('1227303685425-30','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:59','b9cbeed525ae08c4f696bda851227be','Create Table','',NULL,'1.9.4'),('1227303685425-300','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:13','c861c2e3e1fcbae170b5fe8c161ba7c9','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-301','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:13','0444230b26f283b1b4b4c3583ca6a2','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-302','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:13','3ae36b982c1a4dc32b623ed7eab649','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-303','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:59:13','dabab8dcefdde7eefee9d8cc177725','Add Foreign Key Constraint','',NULL,'1.9.4'),('1227303685425-31','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:00','3242cd7de7211c9d3331dfb854afdabf','Create Table','',NULL,'1.9.4'),('1227303685425-32','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:00','8149ef2df786f5e2f7965547ac66d1','Create Table','',NULL,'1.9.4'),('1227303685425-33','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:00','59b63eeddd85b6e75834d5ce529622','Create Table','',NULL,'1.9.4'),('1227303685425-34','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:00','7363eda0ec9d3d747381124a9984be0','Create Table','',NULL,'1.9.4'),('1227303685425-35','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:00','88c2f1f647e779f89929826a776fddc6','Create Table','',NULL,'1.9.4'),('1227303685425-36','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:01','a822d3f8bdcdb8ba93d164244d681f19','Create Table','',NULL,'1.9.4'),('1227303685425-37','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:01','ad9c5348bed3c5416789fe87923b60','Create Table','',NULL,'1.9.4'),('1227303685425-38','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:01','25c5c2d1727636891151ad31d1e70cd','Create Table','',NULL,'1.9.4'),('1227303685425-39','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:01','67727fb610365d2da6efb233d77f5ada','Create Table','',NULL,'1.9.4'),('1227303685425-4','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:50','9046b645b2dff85ac97ddf1ad6f3074','Create Table','',NULL,'1.9.4'),('1227303685425-40','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:01','c136d2cb06570483dcf5f585ff754f','Create Table','',NULL,'1.9.4'),('1227303685425-41','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:02','f0f7a7a4bf316add1449b49698647ef1','Create Table','',NULL,'1.9.4'),('1227303685425-42','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:02','9678d659e5e8b86b3645dfb5e1cddea0','Create Table','',NULL,'1.9.4'),('1227303685425-43','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:02','40d07fbd79ec3ef39901dc110b4fd75','Create Table','',NULL,'1.9.4'),('1227303685425-44','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:02','637177ae6888cf72e917824068f9a3be','Create Table','',NULL,'1.9.4'),('1227303685425-45','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:02','f32f6038a35c9261a179c3f1dd96bc','Create Table','',NULL,'1.9.4'),('1227303685425-46','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:03','a7b96f4406744ac11bb6a878868e04d','Create Table','',NULL,'1.9.4'),('1227303685425-47','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:03','f5221be8e26cd0f59670598766464641','Create Table','',NULL,'1.9.4'),('1227303685425-48','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:03','11aa9575b3c9f149db94168be6fd324','Create Table','',NULL,'1.9.4'),('1227303685425-49','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:03','13665b264c197c7b30604f0a8a564e4','Create Table','',NULL,'1.9.4'),('1227303685425-5','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:50','38c61d5d99b0ab3c444fe36d95181e1','Create Table','',NULL,'1.9.4'),('1227303685425-50','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:03','98ee82b9722f705320cabb8fc8d9d284','Create Table','',NULL,'1.9.4'),('1227303685425-51','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:04','fe724c66d29e156281396c9d1b29d227','Create Table','',NULL,'1.9.4'),('1227303685425-52','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:04','3654e6f75973aa49246dbd741c726743','Create Table','',NULL,'1.9.4'),('1227303685425-53','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:04','eb398720a35d58159d92e721e66ae6d','Create Table','',NULL,'1.9.4'),('1227303685425-54','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:04','c9ed5a341cef1cbe862b1523b7ce2a5','Create Table','',NULL,'1.9.4'),('1227303685425-55','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:04','d441e31ef661e4402141d14ac5734c1','Create Table','',NULL,'1.9.4'),('1227303685425-56','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:05','aaaef34153e53d2adcc71d90a0955','Create Table','',NULL,'1.9.4'),('1227303685425-57','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:05','d3acd4c3442938508976801dddfee866','Create Table','',NULL,'1.9.4'),('1227303685425-58','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:05','b0c0fd9674f39661e6bff6c78e65fcd3','Create Table','',NULL,'1.9.4'),('1227303685425-59','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:05','6f7e652ad837a378845fa9eb9757b99','Create Table','',NULL,'1.9.4'),('1227303685425-6','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:51','7f540998f53dc2bb2d19de05a14f2','Create Table','',NULL,'1.9.4'),('1227303685425-60','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:05','622543a591c2bab1f089cac341d9ce2','Create Table','',NULL,'1.9.4'),('1227303685425-61','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:06','fe5acec38c81bfb3277e193dd0dcc7','Create Table','',NULL,'1.9.4'),('1227303685425-62','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:06','c4b0da30561adf7d40fcd7da77c574','Create Table','',NULL,'1.9.4'),('1227303685425-63','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:06','45fd4df9a91aaaea2f515dbb8bbaae0','Create Table','',NULL,'1.9.4'),('1227303685425-64','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:06','99138560e6e73c3bf6f54fb792552cf','Create Table','',NULL,'1.9.4'),('1227303685425-65','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:06','4e33e6a7cf3bd773f126612bf0b9','Create Table','',NULL,'1.9.4'),('1227303685425-66','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','c223439be520db74976e1c6399b591b0','Create Table','',NULL,'1.9.4'),('1227303685425-67','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','6a136f60cfeb7ed87b27fd71825a8','Create Table','',NULL,'1.9.4'),('1227303685425-68','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','6744cea65ee820c9addf59d78b446ce8','Create Table','',NULL,'1.9.4'),('1227303685425-69','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','c1ee0d08f2c8238f17125d4a58263','Create Table','',NULL,'1.9.4'),('1227303685425-7','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:51','b816bb1dbeecf547611bcd37d29ccd27','Create Table','',NULL,'1.9.4'),('1227303685425-70','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','88c072335290bda8394acf5344b5be','Create Table','',NULL,'1.9.4'),('1227303685425-71','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','5887deaf859b231a28fca6cd8f53985f','Create Table','',NULL,'1.9.4'),('1227303685425-72','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:07','6e889f9922853419f736de152bab863','Create Table','',NULL,'1.9.4'),('1227303685425-73','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:08','db75ceff7fabd137f5ffde95c02ab814','Add Primary Key','',NULL,'1.9.4'),('1227303685425-74','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:08','d7d5d089c54468ac2cfd638f66fcb4','Add Primary Key','',NULL,'1.9.4'),('1227303685425-75','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:08','39dd463941e952d670a5c44194bfe578','Add Primary Key','',NULL,'1.9.4'),('1227303685425-76','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:09','dc6155351d7db68e99ff6e95bbc87be','Add Primary Key','',NULL,'1.9.4'),('1227303685425-77','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:09','4fee106cf921289c298f9c67fc87c7c5','Add Primary Key','',NULL,'1.9.4'),('1227303685425-78','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:09','3a3de23a22ae9c344b47a4d939e6ff70','Add Primary Key','',NULL,'1.9.4'),('1227303685425-79','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:10','88ab4066e17d3a326dc54e5837c09f41','Add Primary Key','',NULL,'1.9.4'),('1227303685425-8','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:51','e55f3abe82ce4b674bcdc1b4996b8b9','Create Table','',NULL,'1.9.4'),('1227303685425-80','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:11','940c1a878d7788f304e14cf4c3394c7','Add Primary Key','',NULL,'1.9.4'),('1227303685425-81','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:11','219f4f94772b86a6785a1168655d630','Add Primary Key','',NULL,'1.9.4'),('1227303685425-82','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:12','4e2676797833eba977cbcae8806c05f','Add Primary Key','',NULL,'1.9.4'),('1227303685425-83','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:12','587abb7e972b9dbae4711c9da4e55b','Add Primary Key','',NULL,'1.9.4'),('1227303685425-84','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:13','9435c219edb4e839af13de48a94f765c','Add Primary Key','',NULL,'1.9.4'),('1227303685425-85','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:13','1bf11ad88f6aeb16115e53aec0aa1fc9','Create Index','',NULL,'1.9.4'),('1227303685425-86','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:13','1e8c4a47a221a275929253c81814e3','Create Index','',NULL,'1.9.4'),('1227303685425-87','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:13','d7aa9fb9b259691ef965935112690c6','Create Index','',NULL,'1.9.4'),('1227303685425-88','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:14','8637a8777e63c352c513c78c60a435fb','Create Index','',NULL,'1.9.4'),('1227303685425-89','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:14','8124613e1c06fe7dbdd82ec7d77b513','Create Index','',NULL,'1.9.4'),('1227303685425-9','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:57:52','ee733a5ef91bcfc5b5a366e4d672c6d4','Create Table','',NULL,'1.9.4'),('1227303685425-90','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:14','ce32a6b73bddd39523fd702837d5e0ac','Create Index','',NULL,'1.9.4'),('1227303685425-91','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:14','8b88d2f395eb2b5c7a48a2691527335a','Create Index','',NULL,'1.9.4'),('1227303685425-92','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:15','9935e165ac0c994c840f0b6ad7e6ea9','Create Index','',NULL,'1.9.4'),('1227303685425-93','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:15','1d54748d2664161ec2a4ec4761dfcbe','Create Index','',NULL,'1.9.4'),('1227303685425-94','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:15','e4cbe444f931f7892fe1ff2cc8ef9','Create Index','',NULL,'1.9.4'),('1227303685425-95','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:15','8e83cb5c20116c3bafc2afcec67fbbcd','Create Index','',NULL,'1.9.4'),('1227303685425-96','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:16','844a9c8a5e4772bb4383d22c1b7c4f','Create Index','',NULL,'1.9.4'),('1227303685425-97','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:16','50c460b4b15dbe1c357c9637d29fba2e','Create Index','',NULL,'1.9.4'),('1227303685425-98','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:16','ebc8c01af6a50d966426a572a317d1','Create Index','',NULL,'1.9.4'),('1227303685425-99','ben (generated)','liquibase-schema-only.xml','2012-05-28 11:58:16','82c523688fbc57714736dfa7aafb48','Create Index','',NULL,'1.9.4'),('2','upul','liquibase-update-to-latest.xml','2012-05-28 11:59:25','271913afcc5e1fc2a96a6b12705e60a4','Add Foreign Key Constraint','Create the foreign key from the privilege required for to edit\n			a person attribute type and the privilege.privilege column',NULL,'1.9.4'),('200805281223','bmckown','liquibase-update-to-latest.xml','2012-05-28 11:59:28','ca38d15c388fd3987ee8e997f48bcb43','Create Table, Add Foreign Key Constraint','Create the concept_complex table',NULL,'1.9.4'),('200805281224','bmckown','liquibase-update-to-latest.xml','2012-05-28 11:59:28','ca898c6096d952b57e28c5edc2a957','Add Column','Adding the value_complex column to obs.  This may take a long time if you have a large number of observations.',NULL,'1.9.4'),('200805281225','bmckown','liquibase-update-to-latest.xml','2012-05-28 11:59:28','c951352b0c976e84b83acf3cfcbb9e','Insert Row','Adding a \'complex\' Concept Datatype',NULL,'1.9.4'),('200805281226','bmckown','liquibase-update-to-latest.xml','2012-05-28 11:59:31','b8b85f33a0d9fde9f478d77b1b868c80','Drop Table (x2)','Dropping the mimetype and complex_obs tables as they aren\'t needed in the new complex obs setup',NULL,'1.9.4'),('200809191226','smbugua','liquibase-update-to-latest.xml','2012-05-28 11:59:32','99ca2b5ae282ba5ff1df9c48f5f2e97','Add Column','Adding the hl7 archive message_state column so that archives can be tracked\n			\n			(preCondition database_version check in place because this change was in the old format in trunk for a while)',NULL,'1.9.4'),('200809191927','smbugua','liquibase-update-to-latest.xml','2012-05-28 11:59:32','8acc3bbd9bb21da496f4dbcaacfe16','Rename Column, Modify Column','Adding the hl7 archive message_state column so that archives can be tracked',NULL,'1.9.4'),('200811261102','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:25','7ce199737ad5ea72959eb52ece15ab8','Update Data','Fix field property for new Tribe person attribute',NULL,'1.9.4'),('200901101524','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 11:59:32','8b599959a0ae994041db885337fd94e','Modify Column','Changing datatype of drug.retire_reason from DATETIME to varchar(255)',NULL,'1.9.4'),('200901130950','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:32','add260b86fbdfe8ddfd15480f7c12530','Delete Data (x2)','Remove Manage Tribes and View Tribes privileges from all roles',NULL,'1.9.4'),('200901130951','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:32','51eaa74d22ee244cc0cbde5ef4758e1c','Delete Data (x2)','Remove Manage Mime Types, View Mime Types, and Purge Mime Types privilege',NULL,'1.9.4'),('200901161126','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:32','478dceabf15112ad9eccee255df8b','Delete Data','Removed the database_version global property',NULL,'1.9.4'),('20090121-0949','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:33','a38a30d48634ab7268204167761db86c','Custom SQL','Switched the default xslt to use PV1-19 instead of PV1-1',NULL,'1.9.4'),('20090122-0853','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:33','5ef0554257579cb649fe4414efd233e0','Custom SQL, Add Lookup Table, Drop Foreign Key Constraint, Delete Data (x2), Drop Table','Remove duplicate concept name tags',NULL,'1.9.4'),('20090123-0305','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:34','fc5153a938b4ce0aa455ca9fea7ad9','Add Unique Constraint','Add unique constraint to the tags table',NULL,'1.9.4'),('20090214-2246','isherman','liquibase-update-to-latest.xml','2012-05-28 11:59:42','6c77a79fc9913830755829adaa983227','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (mysql specific)',NULL,'1.9.4'),('20090214-2247','isherman','liquibase-update-to-latest.xml','2012-05-28 11:59:42','664dee9bed7b178ea62e8de7a8824045','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (using standard sql)',NULL,'1.9.4'),('20090214-2248','isherman','liquibase-update-to-latest.xml','2012-05-28 11:59:42','489fc62a7b3196ba3887b8a2ddc8d93c','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (mssql specific)',NULL,'1.9.4'),('200902142212','ewolodzko','liquibase-update-to-latest.xml','2012-05-28 12:00:54','ca3341c589781757f7b5f3e73a2b8f5','Add Column','Add a sortWeight field to PersonAttributeType',NULL,'1.9.4'),('200902142213','ewolodzko','liquibase-update-to-latest.xml','2012-05-28 12:00:54','918476ca54d9c1e77076be12012841','Update Data','Add default sortWeights to all current PersonAttributeTypes',NULL,'1.9.4'),('20090224-1229','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:37','2112b4bd53e438fc2ac4dc2e60213440','Create Table, Add Foreign Key Constraint (x2)','Add location tags table',NULL,'1.9.4'),('20090224-1250','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:40','ae593490311f38ee69962330e3788938','Create Table, Add Foreign Key Constraint (x2), Add Primary Key','Add location tag map table',NULL,'1.9.4'),('20090224-1256','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:41','27add85e296c1f22deb2fa17d77a542f','Add Column, Add Foreign Key Constraint','Add parent_location column to location table',NULL,'1.9.4'),('20090225-1551','dthomas','liquibase-update-to-latest.xml','2012-05-28 11:59:41','c490c377e78a9740a765e19aacf076','Rename Column (x2)','Change location_tag.name to location_tag.tag and location_tag.retired_reason to location_tag.retire_reason',NULL,'1.9.4'),('20090301-1259','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:42','88d88f5cc99c93c264e6976feef8eecc','Update Data (x2)','Fixes the description for name layout global property',NULL,'1.9.4'),('20090316-1008','vanand','liquibase-update-to-latest.xml','2012-05-28 11:59:52','fcdde237e04473db1e6fd16f56bf80e9','Modify Column (x7), Update Data, Modify Column (x18), Update Data, Modify Column (x11)','Change column types of all boolean columns to smallint. The columns used to be either tinyint(4) or MySQL\'s BIT.\n			(This may take a while on large patient or obs tables)',NULL,'1.9.4'),('200903210905','mseaton','liquibase-update-to-latest.xml','2012-05-28 11:59:55','a13f5939f4ce2a6a9a21c1847d3ab6d','Create Table, Add Foreign Key Constraint (x3)','Add a table to enable generic storage of serialized objects',NULL,'1.9.4'),('20090402-1515-38-cohort','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:56','e5d01ebcda1a2b4ef993a3c859933947','Add Column','Adding \"uuid\" column to cohort table',NULL,'1.9.4'),('20090402-1515-38-concept','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:56','575aaf2321f320331ba877f49a44b8','Add Column','Adding \"uuid\" column to concept table',NULL,'1.9.4'),('20090402-1515-38-concept_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:56','57377447c4be5152c5bb18fdceec2312','Add Column','Adding \"uuid\" column to concept_answer table',NULL,'1.9.4'),('20090402-1515-38-concept_class','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:56','4510924e4fc34a5b4f4786af54a6e9d6','Add Column','Adding \"uuid\" column to concept_class table',NULL,'1.9.4'),('20090402-1515-38-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:57','ffa6230eb5d1021556b2c106176b081','Add Column','Adding \"uuid\" column to concept_datatype table',NULL,'1.9.4'),('20090402-1515-38-concept_description','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:57','a864b52fe66664a95bb25d08ca0fae4','Add Column','Adding \"uuid\" column to concept_description table',NULL,'1.9.4'),('20090402-1515-38-concept_map','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:57','70db4397c48f719f6b6db9b228a5940','Add Column','Adding \"uuid\" column to concept_map table',NULL,'1.9.4'),('20090402-1515-38-concept_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:57','6a5bf2fb43b89825adbab42e32f8c95','Add Column','Adding \"uuid\" column to concept_name table',NULL,'1.9.4'),('20090402-1515-38-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:58','e5175d7effbbe1f327f6765c8563de','Add Column','Adding \"uuid\" column to concept_name_tag table',NULL,'1.9.4'),('20090402-1515-38-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:58','d812c01d4487ee3afd8408d322ae6e9','Add Column','Adding \"uuid\" column to concept_proposal table',NULL,'1.9.4'),('20090402-1515-38-concept_set','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:58','a76a7ad772591c707d1470bfb8e96ebe','Add Column','Adding \"uuid\" column to concept_set table',NULL,'1.9.4'),('20090402-1515-38-concept_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:59','82f9e9817631b23dd768d92c451a4b','Add Column','Adding \"uuid\" column to concept_source table',NULL,'1.9.4'),('20090402-1515-38-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:59','da7523634d5355b5bb2dc7ba3b544682','Add Column','Adding \"uuid\" column to concept_state_conversion table',NULL,'1.9.4'),('20090402-1515-38-drug','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:59','867c42ea0b5a864beccff584fa963ff','Add Column','Adding \"uuid\" column to drug table',NULL,'1.9.4'),('20090402-1515-38-encounter','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:00','53d8465949124bc6247b28a4a58121','Add Column','Adding \"uuid\" column to encounter table',NULL,'1.9.4'),('20090402-1515-38-encounter_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:00','ee9b948fa08ad55c3ecd75c32df82d5','Add Column','Adding \"uuid\" column to encounter_type table',NULL,'1.9.4'),('20090402-1515-38-field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:00','e24dae16c5a010a575c9c1ac84d8eb','Add Column','Adding \"uuid\" column to field table',NULL,'1.9.4'),('20090402-1515-38-field_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:01','7bbeeb1abdc5389f5a7488ee35498b','Add Column','Adding \"uuid\" column to field_answer table',NULL,'1.9.4'),('20090402-1515-38-field_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:01','6271df216ece46cecde2c5f642e84a','Add Column','Adding \"uuid\" column to field_type table',NULL,'1.9.4'),('20090402-1515-38-form','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:01','2569936cbd22e8029253d4e6034f738','Add Column','Adding \"uuid\" column to form table',NULL,'1.9.4'),('20090402-1515-38-form_field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:02','e237246d492a5d9046edba679c2ef7b4','Add Column','Adding \"uuid\" column to form_field table',NULL,'1.9.4'),('20090402-1515-38-global_property','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:02','77d9d563a6b488dde8856cd8e44e74','Add Column','Adding \"uuid\" column to global_property table',NULL,'1.9.4'),('20090402-1515-38-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:02','cc8aa360f98aedcc8399a46edb48ca7e','Add Column','Adding \"uuid\" column to hl7_in_archive table',NULL,'1.9.4'),('20090402-1515-38-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:02','4857a237f2d29901dc2721861b13aa1','Add Column','Adding \"uuid\" column to hl7_in_error table',NULL,'1.9.4'),('20090402-1515-38-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:03','3e0bedc6f28626d1ed8feba9b12744','Add Column','Adding \"uuid\" column to hl7_in_queue table',NULL,'1.9.4'),('20090402-1515-38-hl7_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:03','0c1637fe4ec912bdf75f4ec338f42','Add Column','Adding \"uuid\" column to hl7_source table',NULL,'1.9.4'),('20090402-1515-38-location','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:03','2fc3aaf750476ed2df71b6689d941546','Add Column','Adding \"uuid\" column to location table',NULL,'1.9.4'),('20090402-1515-38-location_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:03','b8c3ac793659918dfb140d94207d5d','Add Column','Adding \"uuid\" column to location_tag table',NULL,'1.9.4'),('20090402-1515-38-note','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:04','c4722e59a9be1c47d0569216e92ad63','Add Column','Adding \"uuid\" column to note table',NULL,'1.9.4'),('20090402-1515-38-notification_alert','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:04','7a66a648529a78d215e17023cdf5d5','Add Column','Adding \"uuid\" column to notification_alert table',NULL,'1.9.4'),('20090402-1515-38-notification_template','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:04','739a3826ba3226875d8f944140e1c188','Add Column','Adding \"uuid\" column to notification_template table',NULL,'1.9.4'),('20090402-1515-38-obs','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:04','75c1752f21de4b95569c7ac66e826e2f','Add Column','Adding \"uuid\" column to obs table',NULL,'1.9.4'),('20090402-1515-38-orders','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:05','f19f5e991569bc1341e9dd31a412da43','Add Column','Adding \"uuid\" column to orders table',NULL,'1.9.4'),('20090402-1515-38-order_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:05','f2c93b646d83d969bf8ba09d11d36edd','Add Column','Adding \"uuid\" column to order_type table',NULL,'1.9.4'),('20090402-1515-38-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:05','dd97565c4ff6c410838a5feb41975d0','Add Column','Adding \"uuid\" column to patient_identifier table',NULL,'1.9.4'),('20090402-1515-38-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:05','613f3c8d0226c305678d461a89db238','Add Column','Adding \"uuid\" column to patient_identifier_type table',NULL,'1.9.4'),('20090402-1515-38-patient_program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:05','a2c23c3ef77d8ea9a2406c428e207244','Add Column','Adding \"uuid\" column to patient_program table',NULL,'1.9.4'),('20090402-1515-38-patient_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:06','57563194b5fa551f129a9cce1b38e8e7','Add Column','Adding \"uuid\" column to patient_state table',NULL,'1.9.4'),('20090402-1515-38-person','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:06','e8a138182c0ba1053131888f8cf8b4','Add Column','Adding \"uuid\" column to person table',NULL,'1.9.4'),('20090402-1515-38-person_address','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:06','2617c04da91ecda5fd2b45237f5ddd','Add Column','Adding \"uuid\" column to person_address table',NULL,'1.9.4'),('20090402-1515-38-person_attribute','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:06','ae559b7cc39a175062126e4815d762','Add Column','Adding \"uuid\" column to person_attribute table',NULL,'1.9.4'),('20090402-1515-38-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:07','68f914b55c3b3fb7dc2a77fd8d933d2','Add Column','Adding \"uuid\" column to person_attribute_type table',NULL,'1.9.4'),('20090402-1515-38-person_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:07','1b8be5c78ca558b45a25d5eaefbbed7','Add Column','Adding \"uuid\" column to person_name table',NULL,'1.9.4'),('20090402-1515-38-privilege','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:07','13d0d85bf5609b955b128fd6f6bc5c6d','Add Column','Adding \"uuid\" column to privilege table',NULL,'1.9.4'),('20090402-1515-38-program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:07','39a4f7c8c86791b166d280d9b22ae','Add Column','Adding \"uuid\" column to program table',NULL,'1.9.4'),('20090402-1515-38-program_workflow','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:07','70877f3fdcfd50bea8d8d0c19fb115ac','Add Column','Adding \"uuid\" column to program_workflow table',NULL,'1.9.4'),('20090402-1515-38-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:08','116efa4fd75f61e034c33a2d4e4c75e2','Add Column','Adding \"uuid\" column to program_workflow_state table',NULL,'1.9.4'),('20090402-1515-38-relationship','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:08','945c9c8a51c2ddfd75195df74b01c37','Add Column','Adding \"uuid\" column to relationship table',NULL,'1.9.4'),('20090402-1515-38-relationship_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:08','09c5c28357a6999636569c43bf1d4a','Add Column','Adding \"uuid\" column to relationship_type table',NULL,'1.9.4'),('20090402-1515-38-report_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:08','4bf73bf794f3b6ec1b5dff44e23679','Add Column','Adding \"uuid\" column to report_object table',NULL,'1.9.4'),('20090402-1515-38-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','2b7354fdbf3a45a725ad7392f73c1d2c','Add Column','Adding \"uuid\" column to report_schema_xml table',NULL,'1.9.4'),('20090402-1515-38-role','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','2955291013b5657ffa9eeeb526d5563','Add Column','Adding \"uuid\" column to role table',NULL,'1.9.4'),('20090402-1515-38-serialized_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','bbb72e88cde2dd2f44f72c175a75f10','Add Column','Adding \"uuid\" column to serialized_object table',NULL,'1.9.4'),('20090402-1516-cohort','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','c916ab788583392ea698441818ca8b','Update Data','Generating UUIDs for all rows in cohort table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','5cd0f78948d656fbe03411c3872b8d3d','Update Data','Generating UUIDs for all rows in concept table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','76742a2d89cdf9216b23ff1cc43f7e2b','Update Data','Generating UUIDs for all rows in concept_answer table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_class','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','b036159e7e6a62be355ab2da84dc6d6','Update Data','Generating UUIDs for all rows in concept_class table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','ffd8b9d259bb98779a6a444a3c597','Update Data','Generating UUIDs for all rows in concept_datatype table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_description','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','471858eb414dd416787873d59ce92d','Update Data','Generating UUIDs for all rows in concept_description table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_map','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','fd1e26504b7b5e227de9a6265cdfaf6a','Update Data','Generating UUIDs for all rows in concept_map table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:09','af235654349acd661ecadde2b2c9d29','Update Data','Generating UUIDs for all rows in concept_name table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','bddb56793bee7cbb59a749557e601b','Update Data','Generating UUIDs for all rows in concept_name_tag table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','d35f42aea2acad9d3eb98a0aa68d','Update Data','Generating UUIDs for all rows in concept_proposal table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_set','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','131a6e5d0c39e32443f72d07f14f86','Update Data','Generating UUIDs for all rows in concept_set table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','3376f58bc68455beaeca7723e8dfdc','Update Data','Generating UUIDs for all rows in concept_source table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','2daca61a968dc1d71dd012c2a770a9a5','Update Data','Generating UUIDs for all rows in concept_state_conversion table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-drug','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','60428b7567bee56397d3ad9c3c74da2','Update Data','Generating UUIDs for all rows in drug table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-encounter','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','855a3866a99360f46dcb54965341a8e','Update Data','Generating UUIDs for all rows in encounter table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-encounter_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','2694d23adc4fec35aabf472b737fc36e','Update Data','Generating UUIDs for all rows in encounter_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','5e406b6bd57710696766bc498b9dc0','Update Data','Generating UUIDs for all rows in field table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-field_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','1b547411666d85b4ee383c2feef3ce','Update Data','Generating UUIDs for all rows in field_answer table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-field_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','b5cd4a815ecfcae3e7a0e16539c469b1','Update Data','Generating UUIDs for all rows in field_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-form','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','867b94d343b1f0347371ec9fa8e3e','Update Data','Generating UUIDs for all rows in form table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-form_field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','ea6c2b047b7c59190cd637547dbd3dd','Update Data','Generating UUIDs for all rows in form_field table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-global_property','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','c743637b2a65526c09996236e9967b2','Update Data','Generating UUIDs for all rows in global_property table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','b1df4ba911718e7987ad3ff8f36fa2b','Update Data','Generating UUIDs for all rows in hl7_in_archive table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','a5fbc93dd5decad5f1c254acabd0fa47','Update Data','Generating UUIDs for all rows in hl7_in_error table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','9319f535948f73e3fa77872421e21c28','Update Data','Generating UUIDs for all rows in hl7_in_queue table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-hl7_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','de74537c46e71afe35c4e3da63da98c','Update Data','Generating UUIDs for all rows in hl7_source table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-location','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','ba24775d1c4e3a5224a88d4f9fd53a1','Update Data','Generating UUIDs for all rows in location table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-location_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','19627ee1543bc0b639f935921a5ef2a','Update Data','Generating UUIDs for all rows in location_tag table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-note','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','dc91bee3824a094b728628b5d74aa7','Update Data','Generating UUIDs for all rows in note table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-notification_alert','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:10','d9fccf1943822a79503c7f15837316','Update Data','Generating UUIDs for all rows in notification_alert table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-notification_template','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','ff8dd4c09bcb33e9a6b1cba9275646b','Update Data','Generating UUIDs for all rows in notification_template table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-obs','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','77f2862ce7ca7192a4043a35c06673','Update Data','Generating UUIDs for all rows in obs table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-orders','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','967a61314dfd1114c81afbe4dd52ae67','Update Data','Generating UUIDs for all rows in orders table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-order_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','f460eb4ea5f07d87cce18e84ba65e12','Update Data','Generating UUIDs for all rows in order_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','7539b5d6c2a704d95dc5f56e6e12d73','Update Data','Generating UUIDs for all rows in patient_identifier table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','79f11da93475eb7467b9297dfbd7c79','Update Data','Generating UUIDs for all rows in patient_identifier_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-patient_program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','1e53eb71d25b1d1eda33fe22d66133','Update Data','Generating UUIDs for all rows in patient_program table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-patient_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','a0ebd331c38f5296e92c72b96b801d4c','Update Data','Generating UUIDs for all rows in patient_state table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-person','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','cf951b6a27951e66a9a0889eb4fd6f15','Update Data','Generating UUIDs for all rows in person table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-person_address','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:11','c630f59a4c330969255165c34377d1d','Update Data','Generating UUIDs for all rows in person_address table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-person_attribute','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','608a4c703f42a7269e5d7c39a1d86de','Update Data','Generating UUIDs for all rows in person_attribute table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','d04f6cc7bfd235bca17e6d1d10505c3','Update Data','Generating UUIDs for all rows in person_attribute_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-person_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','e22e8f89ef24732458581cc697d55f','Update Data','Generating UUIDs for all rows in person_name table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-privilege','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','e3eed777bb7727aa1c80e55e5b307c','Update Data','Generating UUIDs for all rows in privilege table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','7af9569b516c59b71147a7c8bea93d63','Update Data','Generating UUIDs for all rows in program table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-program_workflow','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','56214fa359f3e3bc39104d37fc996538','Update Data','Generating UUIDs for all rows in program_workflow table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','4fc3046f6f1a9eee5da901fdaacae34','Update Data','Generating UUIDs for all rows in program_workflow_state table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-relationship','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','76db1fe2b15c4e35c0cc6accb385ca','Update Data','Generating UUIDs for all rows in relationship table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-relationship_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','716f58764be9b098e3af891951c','Update Data','Generating UUIDs for all rows in relationship_type table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-report_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','acf4b4d7f2f06953fae294bfad74e5b9','Update Data','Generating UUIDs for all rows in report_object table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','9be2c79cdb24345c90a55ecf9786d1','Update Data','Generating UUIDs for all rows in report_schema_xml table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-role','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','7516c06f5ac23efd21394154e4f157d2','Update Data','Generating UUIDs for all rows in role table via built in uuid function.',NULL,'1.9.4'),('20090402-1516-serialized_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','e872c1f23acaea7d2953ab948d3a4b81','Update Data','Generating UUIDs for all rows in serialized_object table via built in uuid function.',NULL,'1.9.4'),('20090402-1517','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:12','89cc7a14b0582f157ea2dbb9de092fd','Custom Change','Adding UUIDs to all rows in all columns via a java class. (This will take a long time on large databases)',NULL,'1.9.4'),('20090402-1518','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:26','dfaf705d7776613e619dedf3e06d7640','Add Not-Null Constraint (x52)','Now that UUID generation is done, set the uuid columns to not \"NOT NULL\"',NULL,'1.9.4'),('20090402-1519-cohort','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','24d3119128e95cb2e5a1a76bfdc54','Create Index','Creating unique index on cohort.uuid column',NULL,'1.9.4'),('20090402-1519-concept','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','52b46db1629e2ba9581d2ff5569238f','Create Index','Creating unique index on concept.uuid column',NULL,'1.9.4'),('20090402-1519-concept_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','fda1ed7f30fa23da5a9013529bbf1c3b','Create Index','Creating unique index on concept_answer.uuid column',NULL,'1.9.4'),('20090402-1519-concept_class','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','1451a7423139d4a59245f5754cd63dac','Create Index','Creating unique index on concept_class.uuid column',NULL,'1.9.4'),('20090402-1519-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','7d6afd51a3308f3d7619676eb55e4be6','Create Index','Creating unique index on concept_datatype.uuid column',NULL,'1.9.4'),('20090402-1519-concept_description','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:27','2546c2e71f8999d46d31c112507ebf87','Create Index','Creating unique index on concept_description.uuid column',NULL,'1.9.4'),('20090402-1519-concept_map','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:28','61c1fac89a8e525494df82743285432','Create Index','Creating unique index on concept_map.uuid column',NULL,'1.9.4'),('20090402-1519-concept_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:28','3be74640f8f2d5993afb193b3fe3075','Create Index','Creating unique index on concept_name.uuid column',NULL,'1.9.4'),('20090402-1519-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:28','f58b6b51d744b015862e9835369c14f6','Create Index','Creating unique index on concept_name_tag.uuid column',NULL,'1.9.4'),('20090402-1519-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:28','b7c251ed66288c2486d39b2e8e5056','Create Index','Creating unique index on concept_proposal.uuid column',NULL,'1.9.4'),('20090402-1519-concept_set','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:29','c99542d48ce96e6f351cc158a814ed0','Create Index','Creating unique index on concept_set.uuid column',NULL,'1.9.4'),('20090402-1519-concept_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:29','7ca56bc86099e23ed197af71e423b44b','Create Index','Creating unique index on concept_source.uuid column',NULL,'1.9.4'),('20090402-1519-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:29','311f46b442c5740393c13b924cf4d2','Create Index','Creating unique index on concept_state_conversion.uuid column',NULL,'1.9.4'),('20090402-1519-drug','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:29','b4867846580078e85629b9554c9845','Create Index','Creating unique index on drug.uuid column',NULL,'1.9.4'),('20090402-1519-encounter','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:30','b0a5fc73f82532e4f2b392e95a9d1e9d','Create Index','Creating unique index on encounter.uuid column',NULL,'1.9.4'),('20090402-1519-encounter_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:30','5ed4dbb39ded5667d9897849eb609162','Create Index','Creating unique index on encounter_type.uuid column',NULL,'1.9.4'),('20090402-1519-field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:31','f1bb647f7e95324ccdf6a8f644a36d47','Create Index','Creating unique index on field.uuid column',NULL,'1.9.4'),('20090402-1519-field_answer','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:32','d3dde65374ee7222c83b6487f936a4f','Create Index','Creating unique index on field_answer.uuid column',NULL,'1.9.4'),('20090402-1519-field_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:32','559a6a362f1de933a495f7c281bd28','Create Index','Creating unique index on field_type.uuid column',NULL,'1.9.4'),('20090402-1519-form','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:32','854ea11fedf3e622cec570e54de222','Create Index','Creating unique index on form.uuid column',NULL,'1.9.4'),('20090402-1519-form_field','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:33','243c552b3a5c3011b214d261bd32c5e','Create Index','Creating unique index on form_field.uuid column',NULL,'1.9.4'),('20090402-1519-global_property','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:33','edf3a71ce9d58b7b5c86889cdee84e','Create Index','Creating unique index on global_property.uuid column',NULL,'1.9.4'),('20090402-1519-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:33','e3e811242f2c8ef055756866aafaed70','Create Index','Creating unique index on hl7_in_archive.uuid column',NULL,'1.9.4'),('20090402-1519-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:34','d4b3b34289fe9a4b7c609f495cdf20','Create Index','Creating unique index on hl7_in_error.uuid column',NULL,'1.9.4'),('20090402-1519-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:34','21b688a853a9f43c5ad24a53df7fd8c','Create Index','Creating unique index on hl7_in_queue.uuid column',NULL,'1.9.4'),('20090402-1519-hl7_source','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:35','b5457643d13df39dac482d34fc884','Create Index','Creating unique index on hl7_source.uuid column',NULL,'1.9.4'),('20090402-1519-location','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:35','a6c5a18e65815abaa42ee07e792f1a','Create Index','Creating unique index on location.uuid column',NULL,'1.9.4'),('20090402-1519-location_tag','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:35','abf99b851bdc38952843b2635104cfc','Create Index','Creating unique index on location_tag.uuid column',NULL,'1.9.4'),('20090402-1519-note','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:35','526b32a1d8d77223bd45a722746d246','Create Index','Creating unique index on note.uuid column',NULL,'1.9.4'),('20090402-1519-notification_alert','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:35','f87f2b6d5f5074c33245321cfbb5878','Create Index','Creating unique index on notification_alert.uuid column',NULL,'1.9.4'),('20090402-1519-notification_template','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:36','add9db68c554fbc2b4360e69438d3a8','Create Index','Creating unique index on notification_template.uuid column',NULL,'1.9.4'),('20090402-1519-obs','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:36','7a584580843bfd1a170c061c65413c1','Create Index','Creating unique index on obs.uuid column',NULL,'1.9.4'),('20090402-1519-orders','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:36','8ffafd6886f4a5fc1515783eabec738','Create Index','Creating unique index on orders.uuid column',NULL,'1.9.4'),('20090402-1519-order_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:36','ae9ea28f147e50c959610dafa5ec25c','Create Index','Creating unique index on order_type.uuid column',NULL,'1.9.4'),('20090402-1519-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:37','4b5861f5669e0f29087d617d27513f1','Create Index','Creating unique index on patient_identifier.uuid column',NULL,'1.9.4'),('20090402-1519-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:37','73da1d5f87d0397bb396a9b3b2ee4ea','Create Index','Creating unique index on patient_identifier_type.uuid column',NULL,'1.9.4'),('20090402-1519-patient_program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:37','34b7b01f4a362b637b239209f2a4820','Create Index','Creating unique index on patient_program.uuid column',NULL,'1.9.4'),('20090402-1519-patient_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:37','efc7e9ba6fc3626ad4afe9c9c41fc0','Create Index','Creating unique index on patient_state.uuid column',NULL,'1.9.4'),('20090402-1519-person','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:37','2a77bcf4862d901d292c5877dfce4f58','Create Index','Creating unique index on person.uuid column',NULL,'1.9.4'),('20090402-1519-person_address','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','3672c61c62cd26ef3a726613517f6234','Create Index','Creating unique index on person_address.uuid column',NULL,'1.9.4'),('20090402-1519-person_attribute','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','d77b26d4596f149a38d65f2be9fa6b51','Create Index','Creating unique index on person_attribute.uuid column',NULL,'1.9.4'),('20090402-1519-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','7affacc59b57fabf36578609cbc481c','Create Index','Creating unique index on person_attribute_type.uuid column',NULL,'1.9.4'),('20090402-1519-person_name','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','f98a895de49abac9dc5483f4de705adf','Create Index','Creating unique index on person_name.uuid column',NULL,'1.9.4'),('20090402-1519-privilege','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','e9406113927e90f14d8ea3aee7b265e1','Create Index','Creating unique index on privilege.uuid column',NULL,'1.9.4'),('20090402-1519-program','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:38','f34ba0c98814f03cff165d4b1c391312','Create Index','Creating unique index on program.uuid column',NULL,'1.9.4'),('20090402-1519-program_workflow','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:39','d537382486f2a3a870983bc2a7e72a4c','Create Index','Creating unique index on program_workflow.uuid column',NULL,'1.9.4'),('20090402-1519-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:39','8020f25b8e995b846d1c3c11e4232399','Create Index','Creating unique index on program_workflow_state.uuid column',NULL,'1.9.4'),('20090402-1519-relationship','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:39','e56ca578a8411decdfee74a91184d4f','Create Index','Creating unique index on relationship.uuid column',NULL,'1.9.4'),('20090402-1519-relationship_type','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:39','179c86d0bf953e67eac2c7cd235a11c','Create Index','Creating unique index on relationship_type.uuid column',NULL,'1.9.4'),('20090402-1519-report_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:39','7f15947ec522a8fe38517251fdcb4f27','Create Index','Creating unique index on report_object.uuid column',NULL,'1.9.4'),('20090402-1519-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:40','f1f2922dead3177b121670e26e2be414','Create Index','Creating unique index on report_schema_xml.uuid column',NULL,'1.9.4'),('20090402-1519-role','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:40','48679931cd75ae76824f0a194d011b8','Create Index','Creating unique index on role.uuid column',NULL,'1.9.4'),('20090402-1519-serialized_object','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:40','3457ded29450bcb294aea6848e244a1','Create Index','Creating unique index on serialized_object.uuid column',NULL,'1.9.4'),('20090408-1298','Cory McCarthy','liquibase-update-to-latest.xml','2012-05-28 11:59:55','a675aa3da8651979b233d4c4b8d7f1','Modify Column','Changed the datatype for encounter_type to \'text\' instead of just 50 chars',NULL,'1.9.4'),('200904091023','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:55','a1ee9e6f174e2d8e5ee076126135b7','Delete Data (x4)','Remove Manage Tribes and View Tribes privileges from the privilege table and role_privilege table.\n			The privileges will be recreated by the Tribe module if it is installed.',NULL,'1.9.4'),('20090414-0804','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:43','b5e187a86493a19ff33881d5c5adb61','Drop Foreign Key Constraint','Dropping foreign key on concept_set.concept_id table',NULL,'1.9.4'),('20090414-0805','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:44','afa3399786d9a6695173727b496ba2','Drop Primary Key','Dropping primary key on concept set table',NULL,'1.9.4'),('20090414-0806','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:44','3c192287a93261df2ef571d55d91a5e','Add Column','Adding new integer primary key to concept set table',NULL,'1.9.4'),('20090414-0807','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:44','548ba564f1cf1a5e4353bade7d0a71f','Create Index, Add Foreign Key Constraint','Adding index and foreign key to concept_set.concept_id column',NULL,'1.9.4'),('20090414-0808a','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:47','13cd2c97df1b7163cb18296c328110','Drop Foreign Key Constraint','Dropping foreign key on patient_identifier.patient_id column',NULL,'1.9.4'),('20090414-0808b','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:47','4a69eb4dc87ad51da7497646b55e09','Drop Primary Key','Dropping non-integer primary key on patient identifier table before adding a new integer primary key',NULL,'1.9.4'),('20090414-0809','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:47','912731dafcb26634d6737b05d1f428d','Add Column','Adding new integer primary key to patient identifier table',NULL,'1.9.4'),('20090414-0810','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:47','8ba5e84d1f85707b4a248a21cf7afe16','Create Index, Add Foreign Key Constraint','Adding index and foreign key on patient_identifier.patient_id column',NULL,'1.9.4'),('20090414-0811a','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:50','3b73a595618cc7d4279899c189aeab','Drop Foreign Key Constraint','Dropping foreign key on concept_word.concept_id column',NULL,'1.9.4'),('20090414-0811b','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:50','be823f8a9d48f3df0c83cbafaf803','Drop Primary Key','Dropping non-integer primary key on concept word table before adding new integer one',NULL,'1.9.4'),('20090414-0812','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:50','98a31beac32af7be584e5f35125ebe77','Add Column','Adding integer primary key to concept word table',NULL,'1.9.4'),('20090414-0812b','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:51','fa3df9294b026b6375cde2993bc936c','Add Foreign Key Constraint','Re-adding foreign key for concept_word.concept_name_id',NULL,'1.9.4'),('200904271042','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:53','1b8214c28c262ca31bb67549c2e29e3','Drop Column','Remove the now unused synonym column',NULL,'1.9.4'),('20090428-0811aa','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:50','8d1cd3bc4fbeb36c55125e68426804d','Drop Foreign Key Constraint','Removing concept_word.concept_name_id foreign key so that primary key can be changed to concept_word_id',NULL,'1.9.4'),('20090428-0854','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:53','9124601e6dc67a603d950617bd17cea','Add Foreign Key Constraint','Adding foreign key for concept_word.concept_id column',NULL,'1.9.4'),('200905071626','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:55','d2873b168b82edab25ab1080304772c9','Create Index','Add an index to the concept_word.concept_id column (This update may fail if it already exists)',NULL,'1.9.4'),('200905150814','bwolfe','liquibase-update-to-latest.xml','2012-05-28 11:59:55','52a64aaf6ac8af65b8023c0ea96162d','Delete Data','Deleting invalid concept words',NULL,'1.9.4'),('200905150821','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:53','d6dedef195a69f62fd1c73adcfd93146','Custom SQL','Deleting duplicate concept word keys',NULL,'1.9.4'),('200906301606','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:54','e0a8f2578ba4e6cbaf9a7f41465bd1b','Modify Column','Change person_attribute_type.sort_weight from an integer to a float',NULL,'1.9.4'),('200907161638-1','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:54','98edf5727177ea045dff438d7fca27','Modify Column','Change obs.value_numeric from a double(22,0) to a double',NULL,'1.9.4'),('200907161638-2','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:55','cd8d3abc418a18ff786b14f27798389','Modify Column','Change concept_numeric columns from a double(22,0) type to a double',NULL,'1.9.4'),('200907161638-3','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:55','8f30dc389272e5f94c34286683ba2c1','Modify Column','Change concept_set.sort_weight from a double(22,0) to a double',NULL,'1.9.4'),('200907161638-4','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:55','7875dcee562bcd9bb5ad49cddcd9241','Modify Column','Change concept_set_derived.sort_weight from a double(22,0) to a double',NULL,'1.9.4'),('200907161638-5','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:55','1b4a410e183ef30ba9d7b7ae965e2a1','Modify Column','Change drug table columns from a double(22,0) to a double',NULL,'1.9.4'),('200907161638-6','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:56','8e5c737f5d65e25f73354f4cd26523','Modify Column','Change drug_order.dose from a double(22,0) to a double',NULL,'1.9.4'),('200908291938-1','dthomas','liquibase-update-to-latest.xml','2012-05-28 12:01:01','5658a0964596d66e70804ddaa48bd77c','Modify Column','set hl7_code in ConceptSource to nullable column',NULL,'1.9.4'),('200908291938-2a','dthomas','liquibase-update-to-latest.xml','2012-05-28 12:01:01','4fff1cee1a3f13ccc2a13c5448f9b1c','Modify Column','set retired in ConceptSource to tinyint(1) not null',NULL,'1.9.4'),('20090831-1039-38-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:56','612afca3f7f1697d93248951bc8c7','Add Column','Adding \"uuid\" column to scheduler_task_config table',NULL,'1.9.4'),('20090831-1040-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:56','baf8889ac5cfe2670e6b9c4bb58a47a','Update Data','Generating UUIDs for all rows in scheduler_task_config table via built in uuid function.',NULL,'1.9.4'),('20090831-1041-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:57','b3e5e26774a54c2cb3397196bedee570','Custom Change','Adding UUIDs to all rows in scheduler_task_config table via a java class for non mysql/oracle/mssql databases.',NULL,'1.9.4'),('20090831-1042-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:57','11fe3a4afc8e8997caab8e71781e5b10','Add Not-Null Constraint','Now that UUID generation is done for scheduler_task_config, set the uuid column to not \"NOT NULL\"',NULL,'1.9.4'),('20090831-1043-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:00:57','b8165a4b9f7ea28a6084d74aadbb9432','Create Index','Creating unique index on scheduler_task_config.uuid column',NULL,'1.9.4'),('20090907-1','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 12:00:57','542a60e1a743881571dd1c86ed1c4','Rename Column','Rename the concept_source.date_voided column to date_retired',NULL,'1.9.4'),('20090907-2a','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 12:01:00','eba5ce8a7d9634e6f528627a82d6b1','Drop Foreign Key Constraint','Remove the concept_source.voided_by foreign key constraint',NULL,'1.9.4'),('20090907-2b','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 12:01:00','8412909f334c2221611ce07acfcb5a6','Rename Column, Add Foreign Key Constraint','Rename the concept_source.voided_by column to retired_by',NULL,'1.9.4'),('20090907-3','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 12:01:00','627e3e7cc7d9a2aece268fa93bf88','Rename Column','Rename the concept_source.voided column to retired',NULL,'1.9.4'),('20090907-4','Knoll_Frank','liquibase-update-to-latest.xml','2012-05-28 12:01:00','74ad3e52598dfc9af0785c753ba818ac','Rename Column','Rename the concept_source.void_reason column to retire_reason',NULL,'1.9.4'),('200909281005-1','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:03','6e728239bd76fa58671bdb4d03ec346','Create Table','Create logic token table to store all registered token',NULL,'1.9.4'),('200909281005-2','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:06','c516c1b552f2fdace76762d81bb3bae6','Create Table','Create logic token tag table to store all tag associated with a token',NULL,'1.9.4'),('200909281005-3','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:14','5a8f5825e1de3fcbc5ed48f0b8cd3e77','Add Foreign Key Constraint','Adding foreign key for primary key of logic_rule_token_tag',NULL,'1.9.4'),('200909281005-4a','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:16','c1bd29bc82b2d227f9eb47f6676f28d','Drop Foreign Key Constraint','Removing bad foreign key for logic_rule_token.creator',NULL,'1.9.4'),('200909281005-4aa','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:18','bbc452fd8fa3ff3eaab4c5fbb2ac2fe2','Drop Foreign Key Constraint','Removing bad foreign key for logic_rule_token.creator',NULL,'1.9.4'),('200909281005-4b','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:21','ee57b86d35016d4a26116a195908d4d','Add Foreign Key Constraint','Adding correct foreign key for logic_rule_token.creator',NULL,'1.9.4'),('200909281005-5a','nribeka','liquibase-update-to-latest.xml','2012-05-28 12:01:24','9d6119b183383447fe37c9494767927','Add Foreign Key Constraint','Adding foreign key for logic_rule_token.changed_by',NULL,'1.9.4'),('20091001-1023','rcrichton','liquibase-update-to-latest.xml','2012-05-28 12:01:35','6c5b675ed15654c61ad28b7794180c0','Add Column','add retired column to relationship_type table',NULL,'1.9.4'),('20091001-1024','rcrichton','liquibase-update-to-latest.xml','2012-05-28 12:01:35','cdee114b801e2fd29f1f906d3fa553c4','Add Column','add retired_by column to relationship_type table',NULL,'1.9.4'),('20091001-1025','rcrichton','liquibase-update-to-latest.xml','2012-05-28 12:01:38','ded86a7b7ba57a447fdb14ee12804','Add Foreign Key Constraint','Create the foreign key from the relationship.retired_by to users.user_id.',NULL,'1.9.4'),('20091001-1026','rcrichton','liquibase-update-to-latest.xml','2012-05-28 12:01:38','56da622349984de2d9d35dfe4f8c592b','Add Column','add date_retired column to relationship_type table',NULL,'1.9.4'),('20091001-1027','rcrichton','liquibase-update-to-latest.xml','2012-05-28 12:01:38','5c3441c4d4df1305e22a76a58b9e4','Add Column','add retire_reason column to relationship_type table',NULL,'1.9.4'),('200910271049-1','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:24','fe74f276e13dc72ddac24b3d5bfe7b73','Update Data (x5)','Setting core field types to have standard UUIDs',NULL,'1.9.4'),('200910271049-10','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','4990b358a988f5eb594e95f205e66','Update Data (x4)','Setting core roles to have standard UUIDs',NULL,'1.9.4'),('200910271049-2','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:24','537a62703f986d8a2db83317a3ac17bb','Update Data (x7)','Setting core person attribute types to have standard UUIDs',NULL,'1.9.4'),('200910271049-3','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:24','c2d6cd47499de2eaaad2bad5c11f9e1','Update Data (x4)','Setting core encounter types to have standard UUIDs',NULL,'1.9.4'),('200910271049-4','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','cbf2dfb5f6fec73a9efe9a591803a9c','Update Data (x12)','Setting core concept datatypes to have standard UUIDs',NULL,'1.9.4'),('200910271049-5','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','5c2629fbf1258fbb9bcd46e8327ee142','Update Data (x4)','Setting core relationship types to have standard UUIDs',NULL,'1.9.4'),('200910271049-6','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','c0dade1ffd2723e8441b6145f83346','Update Data (x15)','Setting core concept classes to have standard UUIDs',NULL,'1.9.4'),('200910271049-7','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','e768dab8025d6612bb581c86d95638a','Update Data (x2)','Setting core patient identifier types to have standard UUIDs',NULL,'1.9.4'),('200910271049-8','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','7d43ef855a73b2321b4fdb97190f7cb','Update Data','Setting core location to have standard UUIDs',NULL,'1.9.4'),('200910271049-9','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:25','9d61613fa6c3ad43f79f765d5a73e9','Update Data','Setting core hl7 source to have standard UUIDs',NULL,'1.9.4'),('200912031842','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:26','de4dd06c279ad749cb5f1de3ed45586','Drop Foreign Key Constraint, Add Foreign Key Constraint','Changing encounter.provider_id to reference person instead of users',NULL,'1.9.4'),('200912031846-1','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:29','3aff267520eec4d52e81ef7614b2da3','Add Column, Update Data','Adding person_id column to users table (if needed)',NULL,'1.9.4'),('200912031846-2','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:29','334f8c5891f058959155f2ed31da386b','Update Data, Add Not-Null Constraint','Populating users.person_id',NULL,'1.9.4'),('200912031846-3','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:32','f0ebbfbf2d223694de49da385ee203b','Add Foreign Key Constraint, Set Column as Auto-Increment','Restoring foreign key constraint on users.person_id',NULL,'1.9.4'),('200912071501-1','arthurs','liquibase-update-to-latest.xml','2012-05-28 12:01:25','38fc7314599265a8ac635daa063bc32','Update Data','Change name for patient.searchMaxResults global property to person.searchMaxResults',NULL,'1.9.4'),('200912091819','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:32','48846a9c134bd1da5b3234b4e1e041eb','Add Column, Add Foreign Key Constraint','Adding retired metadata columns to users table',NULL,'1.9.4'),('200912091820','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:33','3b8f7d29adb4b8ffdb9b4cd29877af1','Update Data','Migrating voided metadata to retired metadata for users table',NULL,'1.9.4'),('200912091821','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:33','fe9bd963d283aca8d01329a1b3595af1','Drop Foreign Key Constraint, Drop Column (x4)','Dropping voided metadata columns from users table',NULL,'1.9.4'),('200912140038','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:34','b2dc51da6fdb4a6d25763dccbd795dc0','Add Column','Adding \"uuid\" column to users table',NULL,'1.9.4'),('200912140039','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:34','28215abe10dd981bcd46c9d74e4cefe','Update Data','Generating UUIDs for all rows in users table via built in uuid function.',NULL,'1.9.4'),('200912140040','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:01:34','e45561523e219fe6c21194e37b9a9de6','Custom Change','Adding UUIDs to users table via a java class. (This will take a long time on large databases)',NULL,'1.9.4'),('200912141552','madanmohan','liquibase-update-to-latest.xml','2012-05-28 12:01:26','8e2978ddf67343ed80a18f7e92799bc','Add Column, Add Foreign Key Constraint','Add changed_by column to encounter table',NULL,'1.9.4'),('200912141553','madanmohan','liquibase-update-to-latest.xml','2012-05-28 12:01:26','c3f6cfc84f19785b1d7ecdd2ccf492','Add Column','Add date_changed column to encounter table',NULL,'1.9.4'),('20091215-0208','sunbiz','liquibase-update-to-latest.xml','2012-05-28 12:01:38','da9945f3554e8dd667c4790276eb5ad','Custom SQL','Prune concepts rows orphaned in concept_numeric tables',NULL,'1.9.4'),('20091215-0209','jmiranda','liquibase-update-to-latest.xml','2012-05-28 12:01:38','2feb74f1ca3fc1f8bb9b7986c321feed','Custom SQL','Prune concepts rows orphaned in concept_complex tables',NULL,'1.9.4'),('20091215-0210','jmiranda','liquibase-update-to-latest.xml','2012-05-28 12:01:38','15cd4ca5b736a89f932456fc17494293','Custom SQL','Prune concepts rows orphaned in concept_derived tables',NULL,'1.9.4'),('200912151032','n.nehete','liquibase-update-to-latest.xml','2012-05-28 12:01:34','fb31da7c25d166f7564bd77926dd286','Add Not-Null Constraint','Encounter Type should not be null when saving an Encounter',NULL,'1.9.4'),('201001072007','upul','liquibase-update-to-latest.xml','2012-05-28 12:01:34','afee6c716d0435895c0c98a98099e4','Add Column','Add last execution time column to scheduler_task_config table',NULL,'1.9.4'),('20100128-1','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:00:56','5bf382cc41fbfa92bb13abdadba3e15','Insert Row','Adding \'System Developer\' role again (see ticket #1499)',NULL,'1.9.4'),('20100128-2','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:00:56','b351df1ec993c3906d66ebe5db67d120','Update Data','Switching users back from \'Administrator\' to \'System Developer\' (see ticket #1499)',NULL,'1.9.4'),('20100128-3','djazayeri','liquibase-update-to-latest.xml','2012-05-28 12:00:56','6e35b6f3bf99975e6bc5ad988280ef','Delete Data','Deleting \'Administrator\' role (see ticket #1499)',NULL,'1.9.4'),('20100412-2217','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:38','6ccd335bb8f1e3dfe5c9b62d018fb27','Add Column','Adding \"uuid\" column to notification_alert_recipient table',NULL,'1.9.4'),('20100412-2218','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:39','b04eb51018a426202057341c4430d851','Update Data','Generating UUIDs for all rows in notification_alert_recipient table via built in uuid function.',NULL,'1.9.4'),('20100412-2219','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:39','13e8f84e2a3ac2eb060e68376dbc19','Custom Change','Adding UUIDs to notification_alert_recipient table via a java class (if needed).',NULL,'1.9.4'),('20100412-2220','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:39','4df07eb79086636f8498cac5a168be2','Add Not-Null Constraint','Now that UUID generation is done, set the notification_alert_recipient.uuid column to not \"NOT NULL\"',NULL,'1.9.4'),('201008021047','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:39','89abf79d12ba23f8388a78f1f12bf2','Create Index','Add an index to the person_name.family_name2 to speed up patient and person searches',NULL,'1.9.4'),('201102280948','bwolfe','liquibase-update-to-latest.xml','2012-05-28 12:01:29','7248f6f988e3a1b5fd864a433b61aae','Drop Foreign Key Constraint','Removing the foreign key from users.user_id to person.person_id if it still exists',NULL,'1.9.4'),('20111209-1400-deleting-non-existing-roles-from-role-role-table','raff','liquibase-update-to-latest.xml','2012-05-28 12:01:39','294cf622d5df41437c3da10bb18685f','Custom SQL','Deleting non-existing roles from the role_role table',NULL,'1.9.4'),('201118012301','lkellett','liquibase-update-to-latest.xml','2012-05-28 12:01:39','a34be5faac41fd7f870e2f47ee855c','Add Column','Adding the discontinued_reason_non_coded column to orders.',NULL,'1.9.4'),('disable-foreign-key-checks','ben','liquibase-core-data.xml','2012-05-28 11:59:14','a5f57b3b22b63b75f613458ff51746e2','Custom SQL','',NULL,'1.9.4');
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangeloglock`
--

LOCK TABLES `liquibasechangeloglock` WRITE;
/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city_village` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `county_district` varchar(50) DEFAULT NULL,
  `neighborhood_cell` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `subregion` varchar(50) DEFAULT NULL,
  `township_division` varchar(50) DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_uuid_index` (`uuid`),
  KEY `name_of_location` (`name`),
  KEY `retired_status` (`retired`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  KEY `parent_location` (`parent_location`),
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Unknown Location',NULL,'','','','','','',NULL,NULL,1,'2005-09-22 00:00:00',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'8d6c993e-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `location_tag_uuid_index` (`uuid`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag`
--

LOCK TABLES `location_tag` WRITE;
/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag_map`
--

LOCK TABLES `location_tag_map` WRITE;
/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_rule_definition`
--

DROP TABLE IF EXISTS `logic_rule_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_rule_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rule_content` varchar(2048) NOT NULL,
  `language` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `creator for rule_definition` (`creator`),
  KEY `changed_by for rule_definition` (`changed_by`),
  KEY `retired_by for rule_definition` (`retired_by`),
  CONSTRAINT `creator for rule_definition` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `changed_by for rule_definition` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_by for rule_definition` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_rule_definition`
--

LOCK TABLES `logic_rule_definition` WRITE;
/*!40000 ALTER TABLE `logic_rule_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_rule_token`
--

DROP TABLE IF EXISTS `logic_rule_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_rule_token` (
  `logic_rule_token_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) NOT NULL,
  `class_name` varchar(512) NOT NULL,
  `state` varchar(512) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`logic_rule_token_id`),
  UNIQUE KEY `logic_rule_token_uuid` (`uuid`),
  KEY `token_creator` (`creator`),
  KEY `token_changed_by` (`changed_by`),
  CONSTRAINT `token_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `person` (`person_id`),
  CONSTRAINT `token_creator` FOREIGN KEY (`creator`) REFERENCES `person` (`person_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_rule_token`
--

LOCK TABLES `logic_rule_token` WRITE;
/*!40000 ALTER TABLE `logic_rule_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_rule_token_tag`
--

DROP TABLE IF EXISTS `logic_rule_token_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_rule_token_tag` (
  `logic_rule_token_id` int(11) NOT NULL,
  `tag` varchar(512) NOT NULL,
  KEY `token_tag` (`logic_rule_token_id`),
  CONSTRAINT `token_tag` FOREIGN KEY (`logic_rule_token_id`) REFERENCES `logic_rule_token` (`logic_rule_token_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_rule_token_tag`
--

LOCK TABLES `logic_rule_token_tag` WRITE;
/*!40000 ALTER TABLE `logic_rule_token_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_token_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_token_registration`
--

DROP TABLE IF EXISTS `logic_token_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_token_registration` (
  `token_registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) NOT NULL,
  `provider_class_name` varchar(512) NOT NULL,
  `provider_token` varchar(512) NOT NULL,
  `configuration` varchar(2000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`token_registration_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `token_registration_creator` (`creator`),
  KEY `token_registration_changed_by` (`changed_by`),
  CONSTRAINT `token_registration_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `token_registration_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_token_registration`
--

LOCK TABLES `logic_token_registration` WRITE;
/*!40000 ALTER TABLE `logic_token_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_token_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_token_registration_tag`
--

DROP TABLE IF EXISTS `logic_token_registration_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logic_token_registration_tag` (
  `token_registration_id` int(11) NOT NULL,
  `tag` varchar(512) NOT NULL,
  KEY `token_registration_tag` (`token_registration_id`),
  CONSTRAINT `token_registration_tag` FOREIGN KEY (`token_registration_id`) REFERENCES `logic_token_registration` (`token_registration_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_token_registration_tag`
--

LOCK TABLES `logic_token_registration_tag` WRITE;
/*!40000 ALTER TABLE `logic_token_registration_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_token_registration_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `note_uuid_index` (`uuid`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  KEY `encounter_note` (`encounter_id`),
  KEY `obs_note` (`obs_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `patient_note` (`patient_id`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`),
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `text` varchar(512) NOT NULL,
  `satisfied_by_any` int(11) NOT NULL DEFAULT '0',
  `alert_read` int(11) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `notification_alert_uuid_index` (`uuid`),
  KEY `user_who_changed_alert` (`changed_by`),
  KEY `alert_creator` (`creator`),
  KEY `alert_assigned_to_user` (`user_id`),
  CONSTRAINT `alert_assigned_to_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert`
--

LOCK TABLES `notification_alert` WRITE;
/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` int(11) NOT NULL DEFAULT '0',
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert_recipient`
--

LOCK TABLES `notification_alert_recipient` WRITE;
/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `notification_template_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `location_id` int(11) NOT NULL DEFAULT '0',
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_boolean` tinyint(4) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text,
  `date_started` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `value_complex` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `obs_uuid_index` (`uuid`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_enterer` (`creator`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `answer_concept` (`value_coded`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `user_who_voided_obs` (`voided_by`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs`
--

LOCK TABLES `obs` WRITE;
/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `order_type_uuid_index` (`uuid`),
  KEY `retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type`
--

LOCK TABLES `order_type` WRITE;
/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `instructions` text,
  `start_date` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `discontinued` smallint(6) NOT NULL DEFAULT '0',
  `discontinued_date` datetime DEFAULT NULL,
  `discontinued_by` int(11) DEFAULT NULL,
  `discontinued_reason` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `discontinued_reason_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `orders_uuid_index` (`uuid`),
  KEY `order_creator` (`creator`),
  KEY `user_who_discontinued_order` (`discontinued_by`),
  KEY `discontinued_because` (`discontinued_reason`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `orderer_not_drug` (`orderer`),
  KEY `order_for_patient` (`patient_id`),
  KEY `user_who_voided_order` (`voided_by`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`discontinued_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `orderer_not_drug` FOREIGN KEY (`orderer`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `user_who_discontinued_order` FOREIGN KEY (`discontinued_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `tribe` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `belongs_to_tribe` (`tribe`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `belongs_to_tribe` FOREIGN KEY (`tribe`) REFERENCES `tribe` (`tribe_id`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` smallint(6) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `patient_identifier_uuid_index` (`uuid`),
  KEY `identifier_name` (`identifier`),
  KEY `identifier_creator` (`creator`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  KEY `identifier_voider` (`voided_by`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  CONSTRAINT `identifies_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier`
--

LOCK TABLES `patient_identifier` WRITE;
/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` varchar(50) DEFAULT NULL,
  `check_digit` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `required` smallint(6) NOT NULL DEFAULT '0',
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `patient_identifier_type_uuid_index` (`uuid`),
  KEY `retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier_type`
--

LOCK TABLES `patient_identifier_type` WRITE;
/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
INSERT INTO `patient_identifier_type` VALUES (1,'OpenMRS Identification Number','Unique number used in OpenMRS','',1,1,'2005-09-22 00:00:00',0,NULL,'org.openmrs.patient.impl.LuhnIdentifierValidator',0,NULL,NULL,NULL,'8d793bee-c2cc-11de-8d13-0010c6dffd0f'),(2,'Old Identification Number','Number given out prior to the OpenMRS system (No check digit)','',0,1,'2005-09-22 00:00:00',0,NULL,NULL,0,NULL,NULL,NULL,'8d79403a-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `patient_program_uuid_index` (`uuid`),
  KEY `user_who_changed` (`changed_by`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_in_program` (`patient_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program`
--

LOCK TABLES `patient_program` WRITE;
/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `patient_state_uuid_index` (`uuid`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `state_for_patient` (`state`),
  KEY `patient_state_voider` (`voided_by`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`),
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_state`
--

LOCK TABLES `patient_state` WRITE;
/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` smallint(6) NOT NULL DEFAULT '0',
  `dead` smallint(6) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `person_uuid_index` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'',NULL,0,0,NULL,NULL,1,'2005-01-01 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'eb34d52e-a8ab-11e1-bdf3-70f39542ef8f');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` smallint(6) NOT NULL DEFAULT '0',
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city_village` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(50) DEFAULT NULL,
  `neighborhood_cell` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `subregion` varchar(50) DEFAULT NULL,
  `township_division` varchar(50) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `person_address_uuid_index` (`uuid`),
  KEY `patient_address_creator` (`creator`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_void` (`voided_by`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `person_attribute_uuid_index` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  KEY `attribute_voider` (`voided_by`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`),
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute`
--

LOCK TABLES `person_attribute` WRITE;
/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `person_attribute_type_uuid_index` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` VALUES (1,'Race','Group of persons related by common descent or heredity','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d871386-c2cc-11de-8d13-0010c6dffd0f',6),(2,'Birthplace','Location of persons birth','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d8718c2-c2cc-11de-8d13-0010c6dffd0f',0),(3,'Citizenship','Country of which this person is a member','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d871afc-c2cc-11de-8d13-0010c6dffd0f',1),(4,'Mother\'s Name','First or last name of this person\'s mother','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d871d18-c2cc-11de-8d13-0010c6dffd0f',5),(5,'Civil Status','Marriage status of this person','org.openmrs.Concept',1054,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d871f2a-c2cc-11de-8d13-0010c6dffd0f',2),(6,'Health District','District/region in which this patient\' home health center resides','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d872150-c2cc-11de-8d13-0010c6dffd0f',4),(7,'Health Center','Specific Location of this person\'s home health center.','org.openmrs.Location',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,'8d87236c-c2cc-11de-8d13-0010c6dffd0f',3);
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` smallint(6) NOT NULL DEFAULT '0',
  `person_id` int(11) DEFAULT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `person_name_uuid_index` (`uuid`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `user_who_made_name` (`creator`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_voided_name` (`voided_by`),
  KEY `family_name2` (`family_name2`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_name`
--

LOCK TABLES `person_name` WRITE;
/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
INSERT INTO `person_name` VALUES (1,1,1,NULL,'Super','',NULL,'User',NULL,NULL,NULL,1,'2005-01-01 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'eb82d04b-a8ab-11e1-bdf3-70f39542ef8f');
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `privilege` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(250) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `privilege_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES ('Add Cohorts','Able to add a cohort to the system','eb8c774d-2b5f-469a-83c6-4a11136e38df'),('Add Concept Proposals','Able to add concept proposals to the system','e862f41c-9c0b-41f7-ad0a-6f07a0010726'),('Add Encounters','Able to add patient encounters','c7efb627-31f9-4961-9827-3cd8cfb2abc8'),('Add Observations','Able to add patient observations','7e023140-6ee0-4160-a97d-251e913e4ab5'),('Add Orders','Able to add orders','0aeb06bb-6c7c-47de-a45f-62d9f85c4bcd'),('Add Patient Identifiers','Able to add patient identifiers','70f90110-374b-487e-826d-e0b1902940df'),('Add Patient Programs','Able to add patients to programs','d3fd6de6-ec44-40ff-9e71-6acbaa42da23'),('Add Patients','Able to add patients','37b4fc07-22a5-423a-bbfe-d1f93e276324'),('Add People','Able to add person objects','f1a52add-f722-4f92-97c6-f3af2431f665'),('Add Relationships','Able to add relationships','183162f1-506b-4d41-a24e-045c19ad1b41'),('Add Report Objects','Able to add report objects','11aff616-bb84-40ff-97ea-e8dfb13c9584'),('Add Reports','Able to add reports','8dc27cb8-d4a1-45b8-a01e-dc30bd18090a'),('Add Users','Able to add users to OpenMRS','10c6dc0c-87cf-4a5e-98fa-d76b5264d7b9'),('Delete Cohorts','Able to add a cohort to the system','022c6995-5b14-4612-9b5b-8843507503dd'),('Delete Concept Proposals','Able to delete concept proposals from the system','f86c407e-980d-4336-b3f1-87f945a530c3'),('Delete Encounters','Able to delete patient encounters','98398bfa-1954-45b5-8266-b7d1f0605506'),('Delete Observations','Able to delete patient observations','b49c5b0f-6623-4d9d-8741-cc6bec31dd83'),('Delete Orders','Able to delete orders','b7875e9b-074a-4925-8128-3324993de9ba'),('Delete Patient Identifiers','Able to delete patient identifiers','412d0302-fbb1-4cb8-a717-f7df354c52a4'),('Delete Patient Programs','Able to delete patients from programs','f3e0f373-bf38-4628-96bb-aafe6f6f72ad'),('Delete Patients','Able to delete patients','c3254694-bd46-4724-8835-df61d9471553'),('Delete People','Able to delete objects','a964fc7c-6404-4d71-8acc-f0ef21786dcf'),('Delete Relationships','Able to delete relationships','befdd8ce-3449-4a3a-a3d9-0b7d2c21e997'),('Delete Report Objects','Able to delete report objects','20aad5ca-0565-4e6a-943e-5180c563dc2f'),('Delete Reports','Able to delete reports','0ac6d424-de37-43b8-ac2c-6105a77f1460'),('Delete Users','Able to delete users in OpenMRS','8f6b64e1-9279-423b-9b37-101eba84d839'),('Edit Cohorts','Able to add a cohort to the system','06116d5e-5b3a-4a77-81cc-92055ce0b534'),('Edit Concept Proposals','Able to edit concept proposals in the system','79b515ec-e34d-41ba-ac44-4fea23b0d6ac'),('Edit Encounters','Able to edit patient encounters','e11ab59e-bb8e-4ae2-9876-d392addda696'),('Edit Observations','Able to edit patient observations','ee42cf06-daff-4a8d-af49-e19893fe85a2'),('Edit Orders','Able to edit orders','92714128-da5a-45c9-a404-0a07a069232f'),('Edit Patient Identifiers','Able to edit patient identifiers','92565bc1-36e4-43d9-abfd-b59b763c11e9'),('Edit Patient Programs','Able to edit patients in programs','9588817e-b660-4bbb-b899-883f2a518b52'),('Edit Patients','Able to edit patients','cd85ce8f-20e9-4e87-a1c7-b065a5c1aea1'),('Edit People','Able to edit person objects','7d75083f-30b6-47fd-90d9-08374b4000ae'),('Edit Relationships','Able to edit relationships','5cf12c51-7366-4f50-8e6f-459018298fb7'),('Edit Report Objects','Able to edit report objects','63a9cd26-1780-4a6b-835e-d082e630acf1'),('Edit Reports','Able to edit reports','8efc5f48-329e-4b22-a9bf-9f7c314b88ce'),('Edit User Passwords','Able to change the passwords of users in OpenMRS','5b7e4d61-a89f-4d71-bb74-06ba4891aa80'),('Edit Users','Able to edit users in OpenMRS','5e3e8b4a-b9c7-481b-bdb8-cfba7194289c'),('Form Entry','Able to fill out forms','468c04c6-6ade-4c31-9f3d-c3239d8852a2'),('Manage Alerts','Able to add/edit/delete user alerts','9b60b370-a1f5-417a-8a2c-c3e2c2901832'),('Manage Concept Classes','Able to add/edit/retire concept classes','7e3e4815-6c39-4c42-8eef-45c6e9d423cd'),('Manage Concept Datatypes','Able to add/edit/retire concept datatypes','901bbd4c-91ef-4de5-97a2-7e2689068fad'),('Manage Concept Sources','Able to add/edit/delete concept sources','6c45fcf9-1968-4902-a4b2-1ee2899b34be'),('Manage Concepts','Able to add/edit/delete concept entries','28e753f0-bbac-4c0b-8fdf-01bb43831755'),('Manage Encounter Types','Able to add/edit/retire encounter types','7105f3da-ad99-4742-a767-5da5c0e96344'),('Manage Field Types','Able to add/edit/retire field types','92e2775f-8415-4d14-9a6b-88efa2495ebb'),('Manage Forms','Able to add/edit/delete forms','9b80e894-411f-4878-bcdb-71dbe78475ec'),('Manage Global Properties','Able to add/edit global properties','99cc6fc8-2cb9-4691-926c-e29c98aa9d5b'),('Manage Identifier Types','Able to add/edit/retire patient identifier types','1306dec1-09b4-49f5-b7ab-cc1e3bed366b'),('Manage Implementation Id','Able to view/add/edit the implementation id for the system','592da414-1cb5-48c9-af23-e79ee3bac6d2'),('Manage Location Tags','Able to add/edit/delete location tags','f419f529-ec39-4c0d-bf08-16b16307f8df'),('Manage Locations','Able to add/edit/delete locations','075d521a-b154-472f-9aa4-96c147680522'),('Manage Modules','Able to add/remove modules to the system','e09542d5-5290-464e-a467-fa90b2eb9d4b'),('Manage Order Types','Able to add/edit/retire order types','f1d529d4-6efb-421e-bf43-977f94107968'),('Manage Person Attribute Types','Able to add/edit/retire person attribute types','68c32995-4e76-468c-9520-c95eac1b412d'),('Manage Privileges','Able to add/edit/delete privileges','a417eb68-4f16-492e-8ddc-ebec5cae6aba'),('Manage Programs','Able to add/view/delete patient programs','590c9548-e15c-40bb-8e54-c1e7c4d56d3f'),('Manage Relationship Types','Able to add/edit/retire relationship types','de6d782a-f5a3-4648-9913-64292cfd13d1'),('Manage Relationships','Able to add/edit/delete relationships','5f93e025-f2a1-4e09-84d2-b12a72b67bd7'),('Manage Roles','Able to add/edit/delete user roles','2b7f4b5b-5658-47b7-840b-5fc894166260'),('Manage Rule Definitions','Allows creation and editing of user-defined rules','4b3d5ee5-bb63-4d11-9f53-727543b243c7'),('Manage Scheduler','Able to add/edit/remove scheduled tasks','ed3d1af8-70fb-4ed4-9f4f-5764d7b5a2fa'),('Manage Tokens','Allows registering and removal of tokens','3c2c15a7-e424-47ef-8203-3086fa1c0878'),('Patient Dashboard - View Demographics Section','Able to view the \'Demographics\' tab on the patient dashboard','77e19b22-1cb0-443b-bd49-9ab7e11de289'),('Patient Dashboard - View Encounters Section','Able to view the \'Encounters\' tab on the patient dashboard','74917317-8f55-4918-b342-a461788f4da9'),('Patient Dashboard - View Forms Section','Able to view the \'Forms\' tab on the patient dashboard','e566f609-fd4c-45dd-861f-1baf38ace799'),('Patient Dashboard - View Graphs Section','Able to view the \'Graphs\' tab on the patient dashboard','cabf3e58-07ab-4b51-bf9a-d19de93641b9'),('Patient Dashboard - View Overview Section','Able to view the \'Overview\' tab on the patient dashboard','5ba8e769-687a-458d-96d6-4a2adce72a06'),('Patient Dashboard - View Patient Summary','Able to view the \'Summary\' tab on the patient dashboard','05729def-54a1-447f-86fa-bbe1fe2e6b5a'),('Patient Dashboard - View Regimen Section','Able to view the \'Regimen\' tab on the patient dashboard','16030944-fe8a-4eeb-8c35-7e65664b838c'),('Purge Field Types','Able to purge field types','b4f34543-ac8a-4513-8328-53d75486141d'),('Run Reports','Able to run reports','165deb5a-df9d-466d-9083-3df3f6f70480'),('View Administration Functions','Able to view the \'Administration\' link in the navigation bar','ac1966f3-9d22-4b34-837d-b8b6c6f20167'),('View Concept Classes','Able to view concept classes','1e56120d-8c11-4028-9b5f-d01b809f0cca'),('View Concept Datatypes','Able to view concept datatypes','69f16aa4-2ed4-4056-9ba0-2da65ae8980d'),('View Concept Proposals','Able to view concept proposals to the system','1e794883-879f-4cd9-8136-e46f92051467'),('View Concept Sources','Able to view concept sources','2db8ee50-650b-484a-93c2-6ffb09ef20e6'),('View Concepts','Able to view concept entries','e1b7d923-bafd-4943-ab6c-e01427575e39'),('View Database Changes','Able to view database changes from the admin screen','3ed460fa-37fc-4c49-9df4-c8d46bb9d3e7'),('View Encounter Types','Able to view encounter types','060d3e09-fe57-4498-b1e6-e75dc61e33d5'),('View Encounters','Able to view patient encounters','ae3f6145-7053-4ca5-9ec3-7a8df51c4f45'),('View Field Types','Able to view field types','d1d19a68-26da-49b7-99f1-0d07f3e7a6c7'),('View Forms','Able to view forms','99c02ff5-63ca-48b8-bd10-e10e47e65163'),('View Global Properties','Able to view global properties on the administration screen','11609d46-bec9-4abc-bc95-463079e44af2'),('View Identifier Types','Able to view patient identifier types','523c4e2c-3cf3-4046-ba24-fc61b9cd9d3f'),('View Locations','Able to view locations','18ec183c-d692-4d8d-8a47-528a9a605c3a'),('View Navigation Menu','Able to view the navigation menu (Home, View Patients, Dictionary, Administration, My Profile)','be8fd3eb-0d64-44ba-90a6-33f7fc3a1863'),('View Observations','Able to view patient observations','2ea17d25-3d5e-4543-a3ac-8f6d49725536'),('View Order Types','Able to view order types','762155dc-1834-49e5-acca-2ff96418e465'),('View Orders','Able to view orders','7c283ac0-72b4-4fa4-b07d-d2a3f717108c'),('View Patient Cohorts','Able to view patient cohorts','d7938888-63bc-4fd9-9a7d-e0d2db642164'),('View Patient Identifiers','Able to view patient identifiers','addc4498-d216-4e86-928c-a143826d0b67'),('View Patient Programs','Able to see which programs that patients are in','7b950988-405f-4b9f-863f-3c8214b6ca95'),('View Patients','Able to view patients','8619ceec-e2f1-49f6-bed9-221d89242f75'),('View People','Able to view person objects','d09835d3-5c72-4d0e-a48f-10ef7ec74268'),('View Person Attribute Types','Able to view person attribute types','32acf46d-903d-4587-a4b5-48171057096b'),('View Privileges','Able to view user privileges','68620469-0544-4430-be3d-7eba07abfb4b'),('View Programs','Able to view patient programs','fbe64a9d-5b02-41f5-be03-1b4e1366b973'),('View Relationship Types','Able to view relationship types','809b971e-32d8-4458-8a9a-d6960161fef9'),('View Relationships','Able to view relationships','14d59212-46a8-4230-b786-f34addefe6ca'),('View Report Objects','Able to view report objects','75440a86-ea66-4f5b-8e01-eac5ed2631de'),('View Reports','Able to view reports','ce54f097-ef12-4f89-8e04-d42d74657543'),('View Roles','Able to view user roles','37e02672-4d0b-45a2-811e-90c7af4a335b'),('View Rule Definitions','Allows viewing of user-defined rules. (This privilege is not necessary to run rules under normal usage.)','c9ae6e18-9421-4a2c-925d-bdd405b6eab7'),('View Unpublished Forms','Able to view and fill out unpublished forms','16700b27-ca9d-4114-a34a-b1a263a2b8b6'),('View Users','Able to view users in OpenMRS','9ae5f77d-b489-4a8e-b5d9-85ab5d8acc66');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `program_uuid_index` (`uuid`),
  KEY `user_who_changed_program` (`changed_by`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `program_workflow_uuid_index` (`uuid`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  KEY `program_for_workflow` (`program_id`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow`
--

LOCK TABLES `program_workflow` WRITE;
/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` smallint(6) NOT NULL DEFAULT '0',
  `terminal` smallint(6) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `program_workflow_state_uuid_index` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow_state`
--

LOCK TABLES `program_workflow_state` WRITE;
/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `relationship_uuid_index` (`uuid`),
  KEY `relation_creator` (`creator`),
  KEY `person_a` (`person_a`),
  KEY `person_b` (`person_b`),
  KEY `relationship_type_id` (`relationship`),
  KEY `relation_voider` (`voided_by`),
  CONSTRAINT `person_a` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `person_b` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`),
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) NOT NULL,
  `b_is_to_a` varchar(50) NOT NULL,
  `preferred` int(11) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `relationship_type_uuid_index` (`uuid`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'Doctor','Patient',0,0,'Relationship from a primary care provider to the patient',1,'2007-05-04 00:00:00','8d919b58-c2cc-11de-8d13-0010c6dffd0f',0,NULL,NULL,NULL),(2,'Sibling','Sibling',0,0,'Relationship between brother/sister, brother/brother, and sister/sister',1,'2007-05-04 00:00:00','8d91a01c-c2cc-11de-8d13-0010c6dffd0f',0,NULL,NULL,NULL),(3,'Parent','Child',0,0,'Relationship from a mother/father to the child',1,'2007-05-04 00:00:00','8d91a210-c2cc-11de-8d13-0010c6dffd0f',0,NULL,NULL,NULL),(4,'Aunt/Uncle','Niece/Nephew',0,0,'',1,'2007-05-04 00:00:00','8d91a3dc-c2cc-11de-8d13-0010c6dffd0f',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` smallint(6) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `report_object_uuid_index` (`uuid`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `xml_data` mediumtext NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `report_schema_xml_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_schema_xml`
--

LOCK TABLES `report_schema_xml` WRITE;
/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `role_uuid_index` (`uuid`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('Anonymous','Privileges for non-authenticated users.','4d4dc2e8-c94e-46ea-a341-e553c292d562'),('Authenticated','Privileges gained once authentication has been established.','b4a2b648-25b8-4e02-9ea3-4532c69bbac3'),('Provider','All users with the \'Provider\' role will appear as options in the default Infopath ','8d94f280-c2cc-11de-8d13-0010c6dffd0f'),('System Developer','Developers of the OpenMRS .. have additional access to change fundamental structure of the database model.','8d94f852-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`privilege`,`role`),
  KEY `role_privilege` (`role`),
  CONSTRAINT `role_privilege` FOREIGN KEY (`role`) REFERENCES `role` (`role`),
  CONSTRAINT `privilege_definitons` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES ('Authenticated','View Concept Classes'),('Authenticated','View Concept Datatypes'),('Authenticated','View Encounter Types'),('Authenticated','View Field Types'),('Authenticated','View Global Properties'),('Authenticated','View Identifier Types'),('Authenticated','View Locations'),('Authenticated','View Order Types'),('Authenticated','View Person Attribute Types'),('Authenticated','View Privileges'),('Authenticated','View Relationship Types'),('Authenticated','View Relationships'),('Authenticated','View Roles');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_role`
--

LOCK TABLES `role_role` WRITE;
/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` int(11) NOT NULL DEFAULT '0',
  `started` int(11) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT '2005-01-01 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `scheduler_task_config_uuid_index` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config`
--

LOCK TABLES `scheduler_task_config` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
INSERT INTO `scheduler_task_config` VALUES (1,'Initialize Logic Rule Providers',NULL,'org.openmrs.logic.task.InitializeLogicRuleProvidersTask','2012-05-28 12:02:33',NULL,1999999999,0,1,NULL,'2012-05-28 12:02:33',NULL,'2012-05-28 12:02:33','03aab6bd-52eb-4f36-b029-047163ea2910','2012-05-28 12:02:33');
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config_property`
--

LOCK TABLES `scheduler_task_config_property` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `subtype` varchar(255) NOT NULL,
  `serialization_class` varchar(255) NOT NULL,
  `serialized_data` text NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `serialized_object_uuid_index` (`uuid`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialized_object`
--

LOCK TABLES `serialized_object` WRITE;
/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tribe`
--

DROP TABLE IF EXISTS `tribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tribe` (
  `tribe_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`tribe_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tribe`
--

LOCK TABLES `tribe` WRITE;
/*!40000 ALTER TABLE `tribe` DISABLE KEYS */;
/*!40000 ALTER TABLE `tribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_property`
--

LOCK TABLES `user_property` WRITE;
/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
INSERT INTO `user_property` VALUES (1,'loginAttempts','0');
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`role`,`user_id`),
  KEY `user_role` (`user_id`),
  CONSTRAINT `user_role` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`)
) DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'Provider'),(1,'System Developer');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_creator` (`creator`),
  KEY `person_id_for_user` (`person_id`),
  KEY `user_who_retired_this_user` (`retired_by`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','','b9bd2eef9ed29f70f5222354750edecdce1f2c5b4deef85111bd4a80cacfaa1c73b90c8a1ef7c9129ec900c1f5b378a6d7ef28d9769fcb1c55ff496b522d7ad8','035c407b94349c1e2f4a8660ff1666c70a29d0cac8f4796ae99be383d7be3a4277f4c2f72014092d14f8daf8e08261a0458478b344db5863d6b3fbaf79a6e146',NULL,NULL,1,'2005-01-01 00:00:00',1,'2012-05-28 12:02:03',1,0,NULL,NULL,NULL,'1c6382fd-a8ac-11e1-bdf3-70f39542ef8f');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-28 12:06:32
