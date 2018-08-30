-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: dbs_bftest
-- ------------------------------------------------------
-- Server version	5.5.16

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `ID` int(8) NOT NULL,
  `NAME` varchar(32) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `AGE` varchar(32) NOT NULL,
  `GESCHLECHT` varchar(10) NOT NULL,
  `LAND` varchar(16) NOT NULL,
  `SERIAL` varchar(32) NOT NULL,
  `IP` varchar(32) NOT NULL,
  `REGISTER_DATUM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ADMINLEVEL` int(1) NOT NULL DEFAULT '0',
  `HANDYNUMMER` int(20) NOT NULL DEFAULT '0',
  `BANK_GELD` int(15) NOT NULL DEFAULT '0',
  `HAND_GELD` int(15) NOT NULL DEFAULT '2500',
  `STATUS` varchar(32) NOT NULL DEFAULT 'Default-status',
  `SPIELZEIT` varchar(6) NOT NULL DEFAULT '00:00',
  `FRAKTION` int(1) NOT NULL DEFAULT '0',
  `FRAKTIONSRANG` int(1) NOT NULL DEFAULT '0',
  `SKIN` int(3) NOT NULL,
  `TODE` int(10) NOT NULL DEFAULT '0',
  `MORDE` int(10) NOT NULL DEFAULT '0',
  `WANTEDS` int(1) NOT NULL DEFAULT '0',
  `STVO` int(2) NOT NULL DEFAULT '0',
  `JAIL` int(1) NOT NULL DEFAULT '0',
  `JAILTIME` int(2) NOT NULL DEFAULT '0',
  `BLAGERFEUER` int(10) NOT NULL DEFAULT '0',
  `BGRILL` int(10) NOT NULL DEFAULT '0',
  `BFACKEL` int(10) NOT NULL DEFAULT '0',
  `BLIEGE` int(10) NOT NULL DEFAULT '0',
  `OFFLINEMSG` text NOT NULL,
  `PERSO` int(1) NOT NULL DEFAULT '0',
  `SPAWN` int(8) NOT NULL DEFAULT '0',
  `X` varchar(8) NOT NULL DEFAULT '0',
  `Y` varchar(8) NOT NULL DEFAULT '0',
  `Z` varchar(8) NOT NULL DEFAULT '0',
  `WAFFEN` varchar(250) NOT NULL DEFAULT '0',
  PRIMARY KEY (`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `Name` text NOT NULL,
  `Admin` text NOT NULL,
  `Grund` text NOT NULL,
  `Datum` text NOT NULL,
  `IP` varchar(50) NOT NULL DEFAULT '0',
  `Serial` varchar(50) NOT NULL,
  `Eintragedatum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban`
--

LOCK TABLES `ban` WRITE;
/*!40000 ALTER TABLE `ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank` (
  `SPIELER` varchar(32) NOT NULL,
  `PIN` int(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `betakeys`
--

DROP TABLE IF EXISTS `betakeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `betakeys` (
  `KEYG` text NOT NULL,
  `SERIAL` varchar(250) NOT NULL DEFAULT '0',
  `NAME` varchar(32) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betakeys`
--

LOCK TABLES `betakeys` WRITE;
/*!40000 ALTER TABLE `betakeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `betakeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datenbank`
--

DROP TABLE IF EXISTS `datenbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datenbank` (
  `SPIELER` varchar(32) NOT NULL,
  `TEXT` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datenbank`
--

LOCK TABLES `datenbank` WRITE;
/*!40000 ALTER TABLE `datenbank` DISABLE KEYS */;
INSERT INTO `datenbank` VALUES ('MuLTi','======================\nDatenbank von Spieler MuLTi:\nScripter, Bla bla,\nhat immer ein Auge offen,\ndies ist eine Test-Datenbanktext\num zu Sehen, wieviele Zeichen es abspeichert\ndaran kann man nichts tuen.\n\n=====================\n\n\nZuletzt bearbeitet von: MuLTi am 29.1.2012 um 16:45');
/*!40000 ALTER TABLE `datenbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugs` (
  `YAKUZA` varchar(32) NOT NULL DEFAULT '|0|0|',
  `REDBROTHERS` varchar(32) NOT NULL DEFAULT '|0|0|'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drugs`
--

LOCK TABLES `drugs` WRITE;
/*!40000 ALTER TABLE `drugs` DISABLE KEYS */;
INSERT INTO `drugs` VALUES ('|1260|1202|','|1260|860|');
/*!40000 ALTER TABLE `drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firmen`
--

DROP TABLE IF EXISTS `firmen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firmen` (
  `ID` int(64) NOT NULL AUTO_INCREMENT,
  `NAME` text NOT NULL,
  `BESITZER` text NOT NULL,
  `ANGESTELLTE` text NOT NULL,
  `BESCHREIBUNG` text NOT NULL,
  `LOHN` int(11) NOT NULL DEFAULT '20',
  `X` varchar(10) NOT NULL,
  `Y` varchar(10) NOT NULL,
  `Z` varchar(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firmen`
--

LOCK TABLES `firmen` WRITE;
/*!40000 ALTER TABLE `firmen` DISABLE KEYS */;
/*!40000 ALTER TABLE `firmen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fraktionen`
--

DROP TABLE IF EXISTS `fraktionen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fraktionen` (
  `ID` int(2) NOT NULL,
  `F_Name` varchar(25) NOT NULL,
  `F_Mitglieder` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fraktionen`
--

LOCK TABLES `fraktionen` WRITE;
/*!40000 ALTER TABLE `fraktionen` DISABLE KEYS */;
/*!40000 ALTER TABLE `fraktionen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `haus`
--

DROP TABLE IF EXISTS `haus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `haus` (
  `ID` int(8) NOT NULL AUTO_INCREMENT,
  `BESITZER` varchar(64) NOT NULL DEFAULT 'staat',
  `PREIS` int(32) NOT NULL DEFAULT '2500',
  `MIETER` varchar(1000) NOT NULL DEFAULT '|-|-|-|-|-|',
  `X` varchar(6) NOT NULL DEFAULT '0',
  `Y` varchar(6) NOT NULL DEFAULT '0',
  `Z` varchar(6) NOT NULL DEFAULT '0',
  `INTERIOR` int(32) NOT NULL DEFAULT '0',
  `INTX` int(32) NOT NULL DEFAULT '0',
  `INTY` int(32) NOT NULL DEFAULT '0',
  `INTZ` int(32) NOT NULL DEFAULT '0',
  `TYP` int(32) NOT NULL DEFAULT '2',
  `LOCKED` int(32) NOT NULL DEFAULT '0',
  `KASSE` int(64) NOT NULL DEFAULT '0',
  `VERMIETEN` int(32) NOT NULL DEFAULT '0',
  `MIETPREIS` int(10) NOT NULL DEFAULT '25',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `haus`
--

LOCK TABLES `haus` WRITE;
/*!40000 ALTER TABLE `haus` DISABLE KEYS */;
INSERT INTO `haus` VALUES (63,'staat',75500,'|-|-|-|-|-|','343','63','4',5,2234,-1115,1051,0,0,0,0,25),(10,'staat',125000,'|-|-|-|-|-|','-808','-843','149',5,1299,-797,1084,1,0,0,0,25),(62,'staat',175000,'|-|-|-|-|-|','2363','116','28',9,83,1322,1084,1,0,0,0,25),(8,'staat',10000,'|-|-|-|-|-|','-807','-848','149',18,1727,-1638,20,2,1,0,1,25),(12,'staat',100000,'|-|-|-|-|-|','795','-507','18',15,-284,1471,1084,1,0,0,0,25),(81,'staat',100500,'|-|-|-|-|-|','743.24','-509.3','18.012',9,2318,-1027,1050,1,0,0,0,25),(14,'staat',60000,'|-|-|-|-|-|','745','-591','18',4,-261,1457,1084,1,0,0,0,25),(16,'staat',65000,'|-|-|-|-|-|','2260','89','31',6,2333,-1077,1049,1,0,0,0,25),(17,'staat',70000,'|-|-|-|-|-|','2261','97','31',5,2234,-1115,1051,1,0,0,0,25),(18,'staat',125000,'|-|-|-|-|-|','2205','62','28',8,2365,-1135,1051,1,0,0,0,25),(19,'staat',130000,'|-|-|-|-|-|','2204','106','28',8,2365,-1135,1051,1,0,0,0,25),(49,'staat',155000,'|-|-|-|-|-|','2236','168','28',6,2197,-1204,1049,1,0,0,0,25),(21,'staat',66000,'|-|-|-|-|-|','2258','168','28',11,2283,-1140,1051,1,0,0,0,25),(22,'staat',66000,'|-|-|-|-|-|','2266','168','28',11,2283,-1140,1051,1,0,0,0,25),(23,'staat',66000,'|-|-|-|-|-|','2286','162','28',11,2283,-1140,1051,1,0,0,0,25),(29,'staat',100000,'|-|-|-|-|-|','2254','-2','28',10,2270,-1210,1048,1,0,0,0,25),(28,'staat',100000,'|-|-|-|-|-|','2245','-2','28',10,2270,-1210,1048,1,0,0,0,25),(27,'staat',225000,'|-|-|-|-|-|','2270','-8','28',6,2197,-1204,1049,1,0,0,0,25),(30,'staat',265000,'|-|-|-|-|-|','2200','-37','28',2,2238,-1082,1049,1,0,0,0,25),(31,'staat',245000,'|-|-|-|-|-|','2197','-61','28',9,2318,-1027,1050,1,0,0,0,25),(32,'staat',310000,'|-|-|-|-|-|','2203','-89','28',9,83,1322,1084,1,0,0,0,25),(33,'staat',345000,'|-|-|-|-|-|','2245','-122','28',5,140,1367,1084,2,0,0,0,25),(34,'staat',220000,'|-|-|-|-|-|','2272','-119','28',8,2365,-1135,1051,1,0,0,0,25),(35,'staat',235000,'|-|-|-|-|-|','2294','-125','28',2,2238,-1082,1049,1,0,0,0,25),(36,'staat',55000,'|-|-|-|-|-|','1461','342','19',8,-43,1406,1084,0,0,0,0,25),(37,'staat',66000,'|-|-|-|-|-|','1466','365','19',6,-69,1352,1080,0,0,0,0,25),(38,'staat',65000,'|-|-|-|-|-|','1448','362','19',6,-69,1352,1080,0,0,0,0,25),(39,'staat',75000,'|-|-|-|-|-|','1435','335','19',8,-43,1406,1084,0,0,0,0,25),(40,'staat',50000,'|-|-|-|-|-|','1416','325','19',5,2234,-1115,1051,0,0,0,0,25),(41,'staat',45000,'|-|-|-|-|-|','1403','334','19',11,2283,-1140,1051,0,0,0,0,25),(42,'staat',75600,'|-|-|-|-|-|','1295','175','21',6,2309,-1213,1049,0,0,0,0,25),(43,'staat',63500,'|-|-|-|-|-|','1294','158','20',11,2283,-1140,1051,0,0,0,0,25),(44,'staat',25000,'|-|-|-|-|-|','1316','180','21',6,2309,-1213,1049,0,0,0,0,25),(45,'staat',35000,'|-|-|-|-|-|','1312','170','21',11,2283,-1140,1051,0,0,0,0,25),(46,'staat',46500,'|-|-|-|-|-|','1299','140','21',6,2309,-1213,1049,0,0,0,0,25),(47,'staat',55000,'|-|-|-|-|-|','1283','158','21',1,223,1287,1082,0,0,0,0,25),(48,'staat',48500,'|-|-|-|-|-|','1304','186','21',6,2333,-1077,1049,0,0,0,0,25),(50,'staat',225000,'|-|-|-|-|-|','1191','293','20',6,2197,-1204,1049,1,0,0,0,25),(51,'staat',195000,'|-|-|-|-|-|','1190','280','20',6,2197,-1204,1049,1,0,0,0,25),(52,'staat',125000,'|-|-|-|-|-|','1187','324','23',8,2365,-1135,1051,1,0,0,0,25),(61,'staat',45000,'|-|-|-|-|-|','-145','-50','3',1,2218,-1076,1050,0,0,0,0,25),(54,'staat',75000,'|-|-|-|-|-|','1425','293','20',1,223,1287,1082,0,0,0,0,25),(55,'staat',145000,'|-|-|-|-|-|','1440','315','20',9,83,1322,1084,1,0,0,0,25),(56,'staat',165000,'|-|-|-|-|-|','1459','323','20',8,2365,-1135,1051,1,0,0,0,25),(57,'staat',160000,'|-|-|-|-|-|','1478','335','19',2,2238,-1082,1049,1,0,0,0,25),(58,'staat',144000,'|-|-|-|-|-|','1493','341','19',6,2197,-1204,1049,1,0,0,0,25),(59,'staat',60000,'|-|-|-|-|-|','1513','348','20',1,223,1287,1082,0,0,0,0,25),(60,'staat',71000,'|-|-|-|-|-|','1532','355','20',4,261,1285,1080,0,0,0,0,25),(64,'staat',77000,'|-|-|-|-|-|','317.74','54.612','3.375',5,2234,-1115,1051,0,0,0,0,25),(65,'staat',78500,'|-|-|-|-|-|','309.26','44.173','3.0879',5,2234,-1115,1051,0,0,0,0,25),(66,'staat',79500,'|-|-|-|-|-|','285.96','41.100','2.5484',11,2283,-1140,1051,0,0,0,0,25),(67,'staat',125000,'|-|-|-|-|-|','316.46','18.232','4.5156',6,2197,-1204,1049,1,0,0,0,25),(68,'staat',110000,'|-|-|-|-|-|','340.08','33.577','6.4073',10,2270,-1210,1048,1,0,0,0,25),(69,'staat',825000,'|-|-|-|-|-|','202.24','-35.48','2.5703',15,2215,-1151,1026,2,0,0,0,25),(70,'staat',165000,'|-|-|-|-|-|','271.64','-48.75','2.7772',15,-284,1471,1084,1,0,0,0,25),(71,'staat',170000,'|-|-|-|-|-|','295.10','-54.54','2.7772',15,-284,1471,1084,1,0,0,0,25),(72,'staat',220000,'|-|-|-|-|-|','252.88','-92.39','3.5353',6,2197,-1204,1049,1,0,0,0,25),(73,'staat',235000,'|-|-|-|-|-|','252.88','-121.3','3.5353',10,2270,-1210,1048,1,0,0,0,25),(74,'staat',75000,'|-|-|-|-|-|','344.62','-71.12','2.4308',11,2283,-1140,1051,0,0,0,0,25),(75,'staat',253500,'|-|-|-|-|-|','312.72','-92.32','3.5353',6,2197,-1204,1049,1,0,0,0,25),(76,'staat',243500,'|-|-|-|-|-|','312.72','-121.2','3.5353',10,2270,-1210,1048,1,0,0,0,25),(77,'staat',99000,'|-|-|-|-|-|','870.49','-24.96','63.978',1,223,1287,1082,1,0,0,1,1),(78,'staat',45000,'|-|-|-|-|-|','691.16','-506.2','16.335',4,261,1285,1080,0,0,0,0,25),(79,'staat',156000,'|-|-|-|-|-|','818.20','-509.3','18.012',8,2365,-1135,1051,1,0,0,0,25),(80,'staat',178000,'|-|-|-|-|-|','766.66','-556.7','18.012',2,2238,-1082,1049,1,1,0,0,25),(83,'staat',31000,'|-|-|-|-|-|','-347.9','-1046.','59.812',9,83,1322,1084,1,0,0,0,25),(84,'staat',85000,'|-|-|-|-|-|','1566.5','23.275','24.164',1,223,1287,1082,1,0,0,0,25),(85,'staat',45900,'|-|-|-|-|-|','1546.6','32.306','24.140',8,-43,1406,1084,0,1,0,1,500),(86,'staat',44000,'|-|-|-|-|-|','672.06','-627.8','16.335',5,2234,-1115,1051,0,0,0,0,25),(87,'staat',20000,'|-|-|-|-|-|','691.36','-640.5','16.322',5,2234,-1115,1051,0,0,0,0,25),(88,'staat',20000,'|-|-|-|-|-|','691.35','-614.0','16.335',5,2234,-1115,1051,0,0,0,0,25),(89,'staat',22000,'|-|-|-|-|-|','672.06','-646.7','16.335',5,2234,-1115,1051,0,0,0,0,25),(90,'staat',750000,'|-|-|-|-|-|','300.24','-1154.','81.390',5,140,1367,1084,2,0,0,0,25),(91,'staat',565000,'|-|-|-|-|-|','251.40','-1220.','76.102',5,140,1367,1084,2,0,0,0,25),(92,'staat',450000,'|-|-|-|-|-|','253.15','-1270.','74.430',5,140,1367,1084,2,1,0,0,25),(93,'staat',755000,'|-|-|-|-|-|','298.82','-1338.','53.441',5,140,1367,1084,2,0,0,1,25),(94,'staat',450000,'|-|-|-|-|-|','1203.5','340.54','19.614',5,140,1367,1084,1,0,0,0,25),(97,'staat',225000,'|-|-|-|-|-|','2443.3','61.579','28.441',1,223,1287,1082,1,0,0,0,25),(95,'staat',175000,'|-|-|-|-|-|','2488.2','58.862','27.683',4,-261,1457,1084,1,0,0,0,25),(96,'staat',450000,'|-|-|-|-|-|','2413.5','61.627','28.441',9,83,1322,1084,1,1,0,1,300);
/*!40000 ALTER TABLE `haus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `SPIELER` int(10) NOT NULL DEFAULT '10',
  `FAHRZEUGE` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventar`
--

DROP TABLE IF EXISTS `inventar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventar` (
  `NAME` varchar(32) NOT NULL,
  `WUERFEL` int(1) NOT NULL DEFAULT '0',
  `ZIGARETTEN` int(5) NOT NULL DEFAULT '0',
  `BIERE` int(5) NOT NULL DEFAULT '0',
  `ZEITUNG` int(1) NOT NULL DEFAULT '0',
  `GEKAUFT` int(2) NOT NULL DEFAULT '0',
  `KISTEN` int(64) NOT NULL DEFAULT '0',
  `BRETTER` int(64) NOT NULL DEFAULT '0',
  `COMPUTER` int(64) NOT NULL DEFAULT '0',
  `FEUER` int(64) NOT NULL DEFAULT '0',
  `MISC` varchar(100) NOT NULL DEFAULT '|0|0|',
  `SINV` varchar(100) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|0|0|',
  `ANGEL` int(5) NOT NULL DEFAULT '0',
  `KOEDER` varchar(50) NOT NULL DEFAULT '|0|0|',
  `FISCHE` varchar(100) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|',
  `ERSTEHILFE` int(64) NOT NULL DEFAULT '0',
  `KANISTER` int(64) NOT NULL DEFAULT '0',
  `FERNSEHER` varchar(64) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventar`
--

LOCK TABLES `inventar` WRITE;
/*!40000 ALTER TABLE `inventar` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `NAME` varchar(64) NOT NULL,
  `CURJOB` int(8) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kassen`
--

DROP TABLE IF EXISTS `kassen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kassen` (
  `JACKPOT` int(64) NOT NULL DEFAULT '0',
  `YAKUZA` int(32) NOT NULL DEFAULT '0',
  `YAKUZAWAFFEN` int(32) NOT NULL DEFAULT '0',
  `TERRORIST` int(32) NOT NULL DEFAULT '0',
  `TERRORISTWAFFEN` int(32) NOT NULL DEFAULT '0',
  `FAHRSCHULE` int(32) NOT NULL DEFAULT '0',
  `FAHRSCHULEWAFFEN` int(32) NOT NULL DEFAULT '0',
  `RCPD` int(32) NOT NULL DEFAULT '0',
  `RCPDWAFFEN` int(32) NOT NULL DEFAULT '0',
  `RCNR` int(32) NOT NULL DEFAULT '0',
  `RCNRWAFFEN` int(32) NOT NULL DEFAULT '0',
  `REDBROTHERS` int(64) NOT NULL DEFAULT '0',
  `REDBROTHERSWAFFEN` int(64) NOT NULL DEFAULT '0',
  `FBI` int(32) NOT NULL DEFAULT '0',
  `FBIWAFFEN` int(32) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kassen`
--

LOCK TABLES `kassen` WRITE;
/*!40000 ALTER TABLE `kassen` DISABLE KEYS */;
INSERT INTO `kassen` VALUES (25000,616106,9999322,404534,684,500000,499301,30000,99966902,240,0,11066,0,0,0);
/*!40000 ALTER TABLE `kassen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestige`
--

DROP TABLE IF EXISTS `prestige`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prestige` (
  `ID` int(8) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(32) NOT NULL,
  `PREIS` int(12) NOT NULL DEFAULT '0',
  `X` int(32) NOT NULL DEFAULT '0',
  `Y` int(32) NOT NULL DEFAULT '0',
  `Z` int(32) NOT NULL DEFAULT '0',
  `BESITZER` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestige`
--

LOCK TABLES `prestige` WRITE;
/*!40000 ALTER TABLE `prestige` DISABLE KEYS */;
INSERT INTO `prestige` VALUES (1,'SPRUNKFABRIK',75000,176,-154,1,''),(2,'FLEISCHBERGFABRIK',250000,-189,-315,2,''),(3,'ALTE_TANKE',45000,213,-247,2,''),(4,'SOLARIN',125000,842,-574,16,''),(5,'XOOMER',75000,217,15,3,''),(6,'KRANKENHAUS',375000,1247,332,20,''),(7,'INSIDE_TRACK',55000,1290,269,20,''),(8,'SPRUNKFABRIK2',350000,1327,291,20,''),(9,'SILOS',50000,-55,122,3,''),(10,'Autohaus',500000,129,-254,2,'');
/*!40000 ALTER TABLE `prestige` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheine`
--

DROP TABLE IF EXISTS `scheine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheine` (
  `NAME` varchar(32) NOT NULL,
  `FSCHEIN` int(1) NOT NULL DEFAULT '0',
  `LKWSCHEIN` int(1) NOT NULL DEFAULT '0',
  `HELISCHEIN` int(1) NOT NULL DEFAULT '0',
  `FLUGSCHEIN` int(11) NOT NULL DEFAULT '0',
  `BOOTSSCHEIN` int(1) NOT NULL DEFAULT '0',
  `ANGELSCHEIN` int(1) NOT NULL DEFAULT '0',
  `MOTORRADSCHEIN` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheine`
--

LOCK TABLES `scheine` WRITE;
/*!40000 ALTER TABLE `scheine` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheinpreise`
--

DROP TABLE IF EXISTS `scheinpreise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheinpreise` (
  `FSCHEIN` int(10) NOT NULL DEFAULT '1500',
  `LKWSCHEIN` int(10) NOT NULL DEFAULT '1000',
  `HELISCHEIN` int(10) NOT NULL DEFAULT '1500',
  `FLUGSCHEIN` int(10) NOT NULL DEFAULT '500',
  `BOOTSSCHEIN` int(10) NOT NULL DEFAULT '250',
  `ANGELSCHEIN` int(10) NOT NULL DEFAULT '50',
  `MOTORRADSCHEIN` int(10) NOT NULL DEFAULT '1250'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheinpreise`
--

LOCK TABLES `scheinpreise` WRITE;
/*!40000 ALTER TABLE `scheinpreise` DISABLE KEYS */;
INSERT INTO `scheinpreise` VALUES (2000,250000000,15000,20000,3500,4500,1250);
/*!40000 ALTER TABLE `scheinpreise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sonstiges`
--

DROP TABLE IF EXISTS `sonstiges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sonstiges` (
  `BRETT` varchar(34) NOT NULL,
  `INHALT` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sonstiges`
--

LOCK TABLES `sonstiges` WRITE;
/*!40000 ALTER TABLE `sonstiges` DISABLE KEYS */;
INSERT INTO `sonstiges` VALUES ('Blueberry','=============================================================================================\n\n                                                                              Schwarzes Brett von der Stadt: Blueberry\n\n=============================================================================================\n\n\n:D\n\n\n\n\n\n\n\n\n\n\n\n\n\n'),('Montgomery','=============================================================================================\n\n                                                                              Schwarzes Brett von der Stadt: Montgomery\n\n=============================================================================================\n\n\n\n'),('Dillimore','=============================================================================================\n\n                                                                              Schwarzes Brett von der Stadt: Dillmore\n\n=============================================================================================\n\n----------Warnung-----------\nEin tollwuetiger Cop namens FamouZZ macht zur Zeit die Stadt unsicher!\nWir bitten sie vorsichtig zu sein und nur bewaffnet aus dem Haus zu gehen!\n----------------------------------\n\n');
/*!40000 ALTER TABLE `sonstiges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `BESITZER` varchar(32) NOT NULL,
  `NAME` varchar(32) NOT NULL,
  `SPAWNX` int(8) NOT NULL,
  `SPAWNY` int(8) NOT NULL,
  `SPAWNZ` int(8) NOT NULL,
  `ROTX` int(8) NOT NULL,
  `ROTY` int(8) NOT NULL,
  `ROTZ` int(8) NOT NULL,
  `CARSLOT` int(1) NOT NULL,
  `FARBE` varchar(32) NOT NULL DEFAULT '255|255|255|0|0|0|0|0|0|0|0|0',
  `TUNINGS` varchar(250) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|',
  `LICHTFARBE` varchar(32) NOT NULL DEFAULT '255|255|255',
  `FUEL` int(10) NOT NULL DEFAULT '100',
  `SCHROTT` int(5) NOT NULL DEFAULT '0',
  `SPECIAL` varchar(32) DEFAULT '|0|0|0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES ('MuLTi','Sultan',238,-28,1,360,355,358,5,'255|255|0|0|0|0|0|0|0|0|0|0|0','|0|0|1139|1031|0|0|0|1033|1010|1087|0|0|1079|1029|1169|1141|0|','0|0|255',46,0,'|1|1|0|'),('[XP]Viperbrawl','Jester',287,-1157,81,360,360,223,5,'112|255|43|0|0|0|0|0|0|0|0|0|1','|0|0|1158|1069|0|0|0|1067|1010|0|0|0|1085|1065|1160|1159|0|','0|255|0',93,0,'|0|'),('[XP]FamouZZ','Jester',2190,-80,27,360,360,269,5,'255|255|255|0|0|0|0|0|0|0|0|0','|0|0|1158|1071|0|0|0|1067|1010|0|0|0|1080|0|0|0|0|','255|255|255',60,0,'|0|'),('Euda','Huntley',289,-252,1,359,360,359,5,'255|255|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|1010|1087|0|0|1073|0|0|0|0|','255|255|255',1,0,'|0|'),('BigSmoke','Bullet',744,-517,16,351,0,182,4,'255|0|0|0|0|255|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','0|0|255',68,1,'|0|'),('[XP]InTrOBaSs','Infernus',1205,349,19,1,3,294,5,'0|0|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|1010|0|0|0|1085|0|0|0|0|','255|0|0',83,0,'|0|'),('[XP]Viperbrawl','NRG-500',284,-1145,80,360,0,222,4,'0|0|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','0|255|0',1,0,'|0|'),('[XP]Viperbrawl','Vortex',275,-1161,80,360,360,227,3,'255|255|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',100,0,'|0|'),('[J]ohnny','Vortex',1323,208,19,0,0,338,5,'255|255|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',99,0,'|0|'),('[XP]Viperbrawl','Sandking',283,-1161,81,1,360,220,2,'0|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|1010|1087|0|0|0|0|0|0|0|','0|0|255',1,0,'|0|'),('BigSmoke','Cheetah',752,-495,17,0,0,178,5,'0|255|0|0|0|0|0|0|0|0|0|0','|0|0|1023|1017|0|0|0|0|0|0|0|0|1082|1018|0|0|0|','0|255|0',48,1,'|0|'),('BigSmoke','Hustler',747,-486,17,0,360,178,3,'0|255|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','0|255|255',93,0,'|0|'),('[XP]InTrOBaSs','NRG-500',1207,340,19,354,359,325,4,'0|0|255|0|255|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|0|0',90,0,'|0|'),('FatDieter','Infernus',2281,59,26,0,0,88,5,'247|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|1010|1087|0|0|1096|0|0|0|0|','66|255|0',86,0,'|0|'),('Jackss~','Elegy',665,-581,16,360,360,198,5,'255|255|255|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',90,0,'|0|'),('Euda','Elegy',1067,-288,74,360,360,182,2,'255|255|255|0|0|0|0|0|0|0|0|0','|0|0|1146|1041|0|0|0|1038|1010|0|0|0|1096|1037|1171|1148|0|','255|255|255',0,0,'|0|'),('[XP]SlowMo','NRG-500',1520,21,24,359,0,322,4,'255|255|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',1,0,'|0|'),('[XP]MopToddel','Jester',301,-1331,53,360,360,40,4,'0|255|0|0|0|0|0|0|0|0|0|0|1','|0|0|1158|1072|0|0|0|1068|1010|1087|0|0|1097|1066|1160|1159|0|','0|255|0',76,0,'|0|'),('[XP]SlowMo','Infernus',1541,19,24,0,0,254,5,'255|255|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',79,0,'|0|'),('[J]ohnny','Infernus',869,-30,63,360,360,247,4,'255|255|255|0|0|0|0|0|0|0|0|0|0','|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|','255|255|255',90,0,'|0|');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffenbox`
--

DROP TABLE IF EXISTS `waffenbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffenbox` (
  `NAME` varchar(32) NOT NULL,
  `SLOT1WAFFE` int(2) NOT NULL DEFAULT '0',
  `SLOT1AMMU` int(64) NOT NULL DEFAULT '0',
  `SLOT2WAFFE` int(2) NOT NULL DEFAULT '0',
  `SLOT2AMMU` int(64) NOT NULL DEFAULT '0',
  `SLOT3WAFFE` int(2) NOT NULL DEFAULT '0',
  `SLOT3AMMU` int(64) NOT NULL DEFAULT '0',
  `SLOT4WAFFE` int(2) NOT NULL DEFAULT '0',
  `SLOT4AMMU` int(64) NOT NULL DEFAULT '0',
  `SLOT5WAFFE` int(2) NOT NULL DEFAULT '0',
  `SLOT5AMMU` int(64) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffenbox`
--

LOCK TABLES `waffenbox` WRITE;
/*!40000 ALTER TABLE `waffenbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffenbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zeitung`
--

DROP TABLE IF EXISTS `zeitung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zeitung` (
  `NAME` varchar(32) NOT NULL,
  `TEXT` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zeitung`
--

LOCK TABLES `zeitung` WRITE;
/*!40000 ALTER TABLE `zeitung` DISABLE KEYS */;
INSERT INTO `zeitung` VALUES ('RCNR','Zeitungsblatt der RCNR:\n================================\nHallo :D\n\nxD\n\nZuletzt Bearbeitet von MuLTi am KA um 17.22, glaube\n5. Februar 2012 oder so.\n===============================\n');
/*!40000 ALTER TABLE `zeitung` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-10 16:18:24
