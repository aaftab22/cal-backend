-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: caliber
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `project_attachments`
--

DROP TABLE IF EXISTS `project_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_attachments` (
  `ATTACHMENT_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int DEFAULT NULL,
  `Attachment_Name` varchar(64) DEFAULT NULL,
  `Attachment_Type` enum('Document','Video','Image','Other') DEFAULT NULL,
  `File_Format` varchar(16) DEFAULT NULL,
  `File_Path` varchar(256) DEFAULT NULL,
  `Upload_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ATTACHMENT_ID`),
  KEY `Project_ID` (`Project_ID`),
  CONSTRAINT `project_attachments_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_attachments`
--

LOCK TABLES `project_attachments` WRITE;
/*!40000 ALTER TABLE `project_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_subtasklist`
--

DROP TABLE IF EXISTS `project_subtasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_subtasklist` (
  `PROJECT_SUBTASK_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int DEFAULT NULL,
  `Subtask_ID` int DEFAULT NULL,
  PRIMARY KEY (`PROJECT_SUBTASK_ID`),
  KEY `Project_ID` (`Project_ID`),
  KEY `Subtask_ID` (`Subtask_ID`),
  CONSTRAINT `project_subtasklist_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`PROJECT_ID`),
  CONSTRAINT `project_subtasklist_ibfk_2` FOREIGN KEY (`Subtask_ID`) REFERENCES `subtasklist` (`SUBTASK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_subtasklist`
--

LOCK TABLES `project_subtasklist` WRITE;
/*!40000 ALTER TABLE `project_subtasklist` DISABLE KEYS */;
INSERT INTO `project_subtasklist` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,25),(6,2,26),(7,2,27),(8,3,12),(9,3,13),(10,4,1),(11,4,3),(12,4,7),(13,4,2),(14,4,4),(15,4,5),(16,4,8),(17,4,10),(18,4,12),(19,4,6),(20,4,9),(21,4,11),(22,5,4),(23,5,5),(24,5,7),(25,5,9),(26,5,11),(27,5,13),(28,5,10),(29,5,12),(30,5,14),(31,5,6),(32,5,8),(33,5,15),(34,6,3),(35,6,4),(36,6,5),(37,6,6),(38,6,8),(39,6,10),(40,6,11),(41,6,13),(42,6,14),(43,6,15),(44,6,16),(45,6,17),(46,6,7),(47,6,12),(48,6,19),(49,7,3),(50,8,2),(51,8,5),(52,8,6),(53,8,7),(54,8,8),(55,8,11),(56,8,13),(57,9,14),(58,9,16),(59,9,10),(60,9,12),(61,9,18),(62,10,3),(63,10,9),(64,11,2),(65,11,3),(66,11,4),(67,11,5),(68,11,6),(69,11,7),(70,11,8),(71,11,9),(72,11,10),(73,11,11),(74,11,12),(75,11,13),(76,11,14),(77,11,15),(78,11,16);
/*!40000 ALTER TABLE `project_subtasklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tasklist`
--

DROP TABLE IF EXISTS `project_tasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_tasklist` (
  `PROJECT_TASK_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int DEFAULT NULL,
  `Task_ID` int DEFAULT NULL,
  PRIMARY KEY (`PROJECT_TASK_ID`),
  KEY `Project_ID` (`Project_ID`),
  KEY `Task_ID` (`Task_ID`),
  CONSTRAINT `project_tasklist_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`PROJECT_ID`),
  CONSTRAINT `project_tasklist_ibfk_2` FOREIGN KEY (`Task_ID`) REFERENCES `tasklist` (`TASK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tasklist`
--

LOCK TABLES `project_tasklist` WRITE;
/*!40000 ALTER TABLE `project_tasklist` DISABLE KEYS */;
INSERT INTO `project_tasklist` VALUES (1,1,1),(2,1,2),(3,2,8),(4,3,3),(5,4,1),(6,4,2),(7,4,3),(8,4,4),(9,5,2),(10,5,5),(11,5,6),(12,5,3),(13,6,1),(14,6,4),(15,6,7),(16,6,9),(17,6,3),(18,7,2),(19,8,1),(20,8,3),(21,9,6),(22,9,8),(23,10,4),(24,11,1),(25,11,2),(26,11,3),(27,11,4),(28,11,5);
/*!40000 ALTER TABLE `project_tasklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `PROJECT_ID` int NOT NULL AUTO_INCREMENT,
  `Project_Description` varchar(256) DEFAULT NULL,
  `Address` varchar(256) DEFAULT NULL,
  `Post_Code` varchar(10) DEFAULT NULL,
  `Contact_Phone` varchar(16) DEFAULT NULL,
  `Contact_Email` varchar(64) DEFAULT NULL,
  `Created_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Created_By` int DEFAULT NULL,
  `Updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` enum('Pending','In Progress','Completed') DEFAULT 'Pending',
  PRIMARY KEY (`PROJECT_ID`),
  KEY `Created_By` (`Created_By`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`Created_By`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Hi','123 Queen St, Toronto','L4R 7T6','123-456-7890','daniel@example.com','2024-11-19 17:17:33',1,'2024-11-19 17:17:33','Pending'),(2,'Development of a recreational park with a children’s play area and a walking track.','753 Cherry Ave, City 10','P8Q 9R1','519-890-1234','user10@example.com','2024-11-19 18:14:47',9,'2024-11-19 18:14:47','Pending'),(3,'Renovation of a residential house to include new flooring and updated lighting fixtures.','123 Maple St, City 3','B2C 3D4','613-123-4567','user3@example.com','2024-11-19 18:17:54',2,'2024-11-19 18:17:54','Pending'),(4,'High-Rise Building Construction','102 Sky Avenue, Downtown','A1B 2C3','123-456-7890','manager@highrisebuilders.com','2024-11-19 18:21:37',1,'2024-11-19 18:21:37','Pending'),(5,'Renovation of Maple Community Centre, including interior redesign, electrical upgrades, and landscaping to enhance functionality and aesthetics.','75 Maplewood Avenue, Toronto, ON','M4Y 1A7','416-789-1234','admin@maplerenovations.ca','2024-11-19 18:27:31',1,'2024-11-19 18:27:31','Pending'),(6,'Development of the Oakwood Public Library, focusing on structural improvements, modern technology installations, and accessibility enhancements for better community use.','123 Oakwood Drive, Ottawa, ON','K1Y 4E4','613-456-7890','info@oakwoodlibrary.ca','2024-11-19 18:29:29',1,'2024-11-19 18:29:29','Pending'),(7,'Renovation of a community hall focusing on lighting and seating arrangements for better events.','245 Maple Avenue, Toronto, ON','M4C 1J9','416-567-8901','hall_renovation@community.ca','2024-11-19 18:37:15',1,'2024-11-19 18:37:15','Pending'),(8,'Construction of a residential complex with multiple buildings, underground parking, and green spaces for community use.','987 Greenfield Crescent, Mississauga, ON','L5A 4C7','905-345-7890','residential_project@build.ca','2024-11-19 18:37:29',1,'2024-11-19 18:37:29','Pending'),(9,'Revamping of a heritage site, including structural repairs and setting up a visitor\'s center.','102 Heritage Lane, Kingston, ON','K7L 3N6','613-765-4321','heritage_update@historica.ca','2024-11-19 18:37:41',1,'2024-11-19 18:37:41','Pending'),(10,'Upgrade of electrical wiring and installation of energy-efficient lighting in a public school.','310 School Street, Hamilton, ON','L8N 1A1','905-789-1234','school_upgrade@edu.ca','2024-11-19 18:37:51',1,'2024-11-19 18:37:51','Pending'),(11,'Development of a multi-functional community center, including sports facilities, conference rooms, and a recreational park.','789 Community Drive, Ottawa, ON','K1A 0B1','613-456-7890','community_center@cityprojects.ca','2024-11-19 18:40:00',1,'2024-11-19 18:40:00','Pending');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_attachments`
--

DROP TABLE IF EXISTS `service_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_attachments` (
  `ATTACHMENT_ID` int NOT NULL AUTO_INCREMENT,
  `Service_Call_ID` int DEFAULT NULL,
  `Attachment_Name` varchar(64) DEFAULT NULL,
  `Attachment_Type` enum('Document','Video','Image','Other') DEFAULT NULL,
  `File_Format` varchar(16) DEFAULT NULL,
  `File_Path` varchar(256) DEFAULT NULL,
  `Upload_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ATTACHMENT_ID`),
  KEY `Service_Call_ID` (`Service_Call_ID`),
  CONSTRAINT `service_attachments_ibfk_1` FOREIGN KEY (`Service_Call_ID`) REFERENCES `service_calls` (`SERVICE_CALL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_attachments`
--

LOCK TABLES `service_attachments` WRITE;
/*!40000 ALTER TABLE `service_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_calls`
--

DROP TABLE IF EXISTS `service_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_calls` (
  `SERVICE_CALL_ID` int NOT NULL AUTO_INCREMENT,
  `Service_Call_Description` varchar(256) DEFAULT NULL,
  `Address` varchar(256) DEFAULT NULL,
  `Post_Code` varchar(10) DEFAULT NULL,
  `Contact_Phone` varchar(16) DEFAULT NULL,
  `Contact_Email` varchar(64) DEFAULT NULL,
  `Site_Status` enum('OnSite','OffSite') DEFAULT NULL,
  `Created_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Created_By` int DEFAULT NULL,
  `Updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` enum('Pending','In Progress','Completed') DEFAULT 'Pending',
  PRIMARY KEY (`SERVICE_CALL_ID`),
  KEY `Created_By` (`Created_By`),
  CONSTRAINT `service_calls_ibfk_1` FOREIGN KEY (`Created_By`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_calls`
--

LOCK TABLES `service_calls` WRITE;
/*!40000 ALTER TABLE `service_calls` DISABLE KEYS */;
INSERT INTO `service_calls` VALUES (1,'Perform routine HVAC maintenance and check for air filter replacements in the downtown office.','123 Maple Avenue, Toronto, ON','M4C 1L5','416-555-1234','maintenance@downtownoffice.com','OnSite','2024-11-19 18:44:32',1,'2024-11-19 18:44:32','Pending'),(2,'Inspect and repair electrical wiring in the living room and install new lighting fixtures.','123 Bayview Avenue, Toronto, ON','M5J 2R8','416-555-1234','electrical@fixpro.ca','','2024-11-19 19:00:20',3,'2024-11-19 19:00:20',''),(3,'Inspect and repair HVAC system in the residential complex.','250 Wellington Street West, Toronto, ON','M5V 3P6','416-555-8790','hvac.repairs@servicefix.ca','OnSite','2024-11-19 20:21:44',2,'2024-11-19 20:21:44','Pending'),(4,'Install new security cameras and configure the system.','40 Bay Street, Toronto, ON','M5J 2X2','647-555-1234','security@techinstall.ca','OnSite','2024-11-19 20:25:00',3,'2024-11-19 20:25:00','Pending'),(5,'Repair and calibrate heating system in the main office.','123 Queen Street West, Toronto, ON','M5H 2M9','416-555-6789','heating@repairservices.ca','OffSite','2024-11-19 20:26:46',5,'2024-11-19 20:26:46','Pending'),(6,'Install new security cameras at the warehouse.','75 Wellington Street West, Toronto, ON','M5K 1H1','416-555-9090','security@installations.ca','OffSite','2024-11-19 20:35:05',3,'2024-11-19 20:35:05','Pending'),(7,'Upgrade electrical wiring for office lighting.','200 University Avenue, Waterloo, ON','N2L 3G1','519-555-5555','electric@upgrades.ca','OffSite','2024-11-19 20:35:17',6,'2024-11-19 20:35:17','Pending'),(8,'Inspect plumbing systems for leaks and repair faulty pipes.','60 Bay Street, Hamilton, ON','L8P 4Z5','905-555-2323','plumbing@inspection.ca','OffSite','2024-11-19 20:35:25',2,'2024-11-19 20:35:25','Pending'),(9,'Repair HVAC system in the community center.','123 King Street West, Mississauga, ON','L5B 1C4','905-555-7890','hvac@repairs.ca','OffSite','2024-11-19 20:37:07',5,'2024-11-19 20:37:07','Pending'),(10,'Install new fire alarm system in the library.','89 Queen Street East, Brampton, ON','L6V 1A1','905-555-1234','firealarms@install.ca','OffSite','2024-11-19 20:37:17',4,'2024-11-19 20:37:17','Pending'),(11,'Upgrade network cabling for high-speed internet.','45 Front Street North, Orillia, ON','L3V 4S1','705-555-6789','network@upgrade.ca','OffSite','2024-11-19 20:39:05',3,'2024-11-19 20:39:05','Pending');
/*!40000 ALTER TABLE `service_calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_subtasks`
--

DROP TABLE IF EXISTS `service_subtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_subtasks` (
  `SERVICE_SUBTASK_ID` int NOT NULL AUTO_INCREMENT,
  `Service_Call_ID` int DEFAULT NULL,
  `Subtask_ID` int DEFAULT NULL,
  PRIMARY KEY (`SERVICE_SUBTASK_ID`),
  KEY `Service_Call_ID` (`Service_Call_ID`),
  KEY `Subtask_ID` (`Subtask_ID`),
  CONSTRAINT `service_subtasks_ibfk_1` FOREIGN KEY (`Service_Call_ID`) REFERENCES `service_calls` (`SERVICE_CALL_ID`),
  CONSTRAINT `service_subtasks_ibfk_2` FOREIGN KEY (`Subtask_ID`) REFERENCES `subtasklist` (`SUBTASK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_subtasks`
--

LOCK TABLES `service_subtasks` WRITE;
/*!40000 ALTER TABLE `service_subtasks` DISABLE KEYS */;
INSERT INTO `service_subtasks` VALUES (1,1,15),(2,1,12),(3,2,25),(4,2,27),(5,3,22),(6,3,24),(7,4,36),(8,4,39),(9,5,22),(10,5,19),(11,6,30),(12,6,32),(13,7,18),(14,7,15),(15,8,25),(16,8,28),(17,9,35),(18,9,37),(19,10,20),(20,10,23),(21,11,12),(22,11,14);
/*!40000 ALTER TABLE `service_subtasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_task_assignments`
--

DROP TABLE IF EXISTS `service_task_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_task_assignments` (
  `SERVICE_TASK_ID` int NOT NULL AUTO_INCREMENT,
  `Service_Call_ID` int DEFAULT NULL,
  `Task_ID` int DEFAULT NULL,
  `Employee_Assigned` int DEFAULT NULL,
  `Time_Start` datetime DEFAULT NULL,
  `Time_Finish` datetime DEFAULT NULL,
  PRIMARY KEY (`SERVICE_TASK_ID`),
  KEY `Service_Call_ID` (`Service_Call_ID`),
  KEY `Task_ID` (`Task_ID`),
  KEY `Employee_Assigned` (`Employee_Assigned`),
  CONSTRAINT `service_task_assignments_ibfk_1` FOREIGN KEY (`Service_Call_ID`) REFERENCES `service_calls` (`SERVICE_CALL_ID`),
  CONSTRAINT `service_task_assignments_ibfk_2` FOREIGN KEY (`Task_ID`) REFERENCES `tasklist` (`TASK_ID`),
  CONSTRAINT `service_task_assignments_ibfk_3` FOREIGN KEY (`Employee_Assigned`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_task_assignments`
--

LOCK TABLES `service_task_assignments` WRITE;
/*!40000 ALTER TABLE `service_task_assignments` DISABLE KEYS */;
INSERT INTO `service_task_assignments` VALUES (1,1,3,4,'2024-11-15 09:00:00','2024-11-15 12:00:00'),(2,1,3,7,'2024-11-15 13:00:00','2024-11-15 17:00:00'),(3,2,9,6,'2024-11-20 09:00:00','2024-11-20 13:00:00'),(4,2,9,11,'2024-11-20 13:30:00','2024-11-20 17:00:00'),(5,3,5,7,'2024-11-21 09:00:00','2024-11-21 15:00:00'),(6,3,5,9,'2024-11-21 09:00:00','2024-11-21 12:30:00'),(7,4,8,4,'2024-11-22 10:00:00','2024-11-22 14:30:00'),(8,4,8,11,'2024-11-22 10:30:00','2024-11-22 15:00:00'),(9,5,5,7,'2024-11-24 09:00:00','2024-11-24 13:30:00'),(10,5,5,10,'2024-11-24 10:00:00','2024-11-24 14:00:00'),(11,6,8,4,'2024-11-25 08:00:00','2024-11-25 12:00:00'),(12,6,8,9,'2024-11-25 13:00:00','2024-11-25 17:00:00'),(13,7,3,5,'2024-11-26 09:00:00','2024-11-26 15:00:00'),(14,7,3,8,'2024-11-26 10:00:00','2024-11-26 16:00:00'),(15,8,6,10,'2024-11-27 13:00:00','2024-11-27 17:00:00'),(16,8,6,3,'2024-11-27 07:30:00','2024-11-27 12:30:00'),(17,9,7,6,'2024-11-28 09:00:00','2024-11-28 12:00:00'),(18,9,7,11,'2024-11-28 13:00:00','2024-11-28 17:00:00'),(19,10,4,2,'2024-11-29 08:00:00','2024-11-29 12:00:00'),(20,10,4,7,'2024-11-29 13:00:00','2024-11-29 16:00:00'),(21,11,2,8,'2024-12-01 07:00:00','2024-12-01 12:00:00'),(22,11,2,10,'2024-12-01 13:00:00','2024-12-01 17:00:00');
/*!40000 ALTER TABLE `service_task_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subtasklist`
--

DROP TABLE IF EXISTS `subtasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subtasklist` (
  `SUBTASK_ID` int NOT NULL AUTO_INCREMENT,
  `Subtask_Name` varchar(64) DEFAULT NULL,
  `Related_Task` int DEFAULT NULL,
  PRIMARY KEY (`SUBTASK_ID`),
  UNIQUE KEY `Subtask_Name` (`Subtask_Name`),
  KEY `Related_Task` (`Related_Task`),
  CONSTRAINT `subtasklist_ibfk_1` FOREIGN KEY (`Related_Task`) REFERENCES `tasklist` (`TASK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subtasklist`
--

LOCK TABLES `subtasklist` WRITE;
/*!40000 ALTER TABLE `subtasklist` DISABLE KEYS */;
INSERT INTO `subtasklist` VALUES (1,'Framing',1),(2,'Steel supports for benches',1),(3,'Interior finish carpentry',1),(4,'Deck',1),(5,'Fence',1),(6,'Structural steel install',1),(7,'Bricklaying',1),(8,'Cement',1),(9,'Demolition',2),(10,'Excavation',2),(11,'Underpinning',2),(12,'Electrical',3),(13,'Soffit lighting',3),(14,'Panel upgrade',3),(15,'Fixture install',3),(16,'Heated floor',3),(17,'Central Vacuum',3),(18,'Cat5 wiring and install',3),(19,'Speaker wiring and speaker install',3),(20,'Camera wiring and camera install',3),(21,'Security wiring rough in',3),(22,'Thermography',3),(23,'Drywall',4),(24,'Drywall patching',4),(25,'Aria vent installation',4),(26,'Fan installation',4),(27,'Vanity installs',4),(28,'Trim install',4),(29,'Material deliveries',5),(30,'Deliveries',5),(31,'Accessories install',6),(32,'Artwork',6),(33,'Shelf installs',6),(34,'Sauna',6),(35,'Machine operator',6),(36,'Scaffold foreman',6),(37,'Scaffold building',6),(38,'Painting',7),(39,'Caulking',7),(40,'Caulking/Silicone',7),(41,'Patching/plastering',7),(42,'Self-levelling',7),(43,'Floor repair with injections',7),(44,'Patching plastering',7),(45,'Skilled site labour',8),(46,'Site labour',8),(47,'Appliance install',9),(48,'Trims & Doors',10);
/*!40000 ALTER TABLE `subtasklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_assignments`
--

DROP TABLE IF EXISTS `task_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_assignments` (
  `ASSIGNMENT_ID` int NOT NULL AUTO_INCREMENT,
  `Employee_Assigned` int DEFAULT NULL,
  `Project_ID` int DEFAULT NULL,
  `Task_Assigned` int DEFAULT NULL,
  `Time_Start` datetime DEFAULT NULL,
  `Time_Finish` datetime DEFAULT NULL,
  PRIMARY KEY (`ASSIGNMENT_ID`),
  KEY `Employee_Assigned` (`Employee_Assigned`),
  KEY `Project_ID` (`Project_ID`),
  KEY `Task_Assigned` (`Task_Assigned`),
  CONSTRAINT `task_assignments_ibfk_1` FOREIGN KEY (`Employee_Assigned`) REFERENCES `users` (`ID`),
  CONSTRAINT `task_assignments_ibfk_2` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`PROJECT_ID`),
  CONSTRAINT `task_assignments_ibfk_3` FOREIGN KEY (`Task_Assigned`) REFERENCES `tasklist` (`TASK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_assignments`
--

LOCK TABLES `task_assignments` WRITE;
/*!40000 ALTER TABLE `task_assignments` DISABLE KEYS */;
INSERT INTO `task_assignments` VALUES (2,5,1,1,'2024-01-10 08:00:00','2024-01-10 17:00:00'),(3,6,1,1,'2024-01-11 08:00:00','2024-01-11 17:00:00'),(4,7,1,2,'2024-01-12 08:00:00','2024-01-12 17:00:00'),(5,8,1,2,'2024-01-13 08:00:00','2024-01-13 17:00:00'),(7,7,3,3,'2024-11-20 09:00:00','2024-11-25 17:00:00'),(8,8,3,3,'2024-11-20 09:00:00','2024-11-25 17:00:00'),(9,2,4,1,'2024-11-04 09:00:00','2024-11-06 17:00:00'),(10,5,4,1,'2024-11-04 09:00:00','2024-11-06 17:00:00'),(11,3,4,2,'2024-11-07 08:00:00','2024-11-09 16:00:00'),(12,6,4,2,'2024-11-07 08:00:00','2024-11-09 16:00:00'),(13,8,4,3,'2024-11-10 10:00:00','2024-11-12 18:00:00'),(14,10,4,3,'2024-11-10 10:00:00','2024-11-12 18:00:00'),(15,4,4,4,'2024-11-13 09:00:00','2024-11-15 17:00:00'),(16,7,4,4,'2024-11-13 09:00:00','2024-11-15 17:00:00'),(17,3,5,2,'2024-11-05 08:00:00','2024-11-07 17:00:00'),(18,9,5,2,'2024-11-05 08:00:00','2024-11-07 17:00:00'),(19,4,5,5,'2024-11-08 09:00:00','2024-11-10 16:00:00'),(20,8,5,5,'2024-11-08 09:00:00','2024-11-10 16:00:00'),(21,2,5,6,'2024-11-11 07:30:00','2024-11-13 18:00:00'),(22,5,5,6,'2024-11-11 07:30:00','2024-11-13 18:00:00'),(23,6,5,3,'2024-11-14 08:00:00','2024-11-16 17:00:00'),(24,10,5,3,'2024-11-14 08:00:00','2024-11-16 17:00:00'),(25,2,6,1,'2024-11-06 09:00:00','2024-11-08 17:00:00'),(26,7,6,1,'2024-11-06 09:00:00','2024-11-08 17:00:00'),(27,3,6,4,'2024-11-09 08:30:00','2024-11-11 16:30:00'),(28,9,6,4,'2024-11-09 08:30:00','2024-11-11 16:30:00'),(29,6,6,7,'2024-11-12 07:00:00','2024-11-15 18:00:00'),(30,8,6,7,'2024-11-12 07:00:00','2024-11-15 18:00:00'),(31,4,6,9,'2024-11-16 09:00:00','2024-11-18 17:00:00'),(32,10,6,9,'2024-11-16 09:00:00','2024-11-18 17:00:00'),(33,5,6,3,'2024-11-19 08:00:00','2024-11-21 17:00:00'),(34,11,6,3,'2024-11-19 08:00:00','2024-11-21 17:00:00'),(35,5,7,2,'2024-11-10 09:00:00','2024-11-11 17:00:00'),(36,2,8,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(37,4,8,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(38,6,8,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(39,7,8,3,'2024-11-11 08:30:00','2024-11-13 17:30:00'),(40,9,8,3,'2024-11-11 08:30:00','2024-11-13 17:30:00'),(41,3,9,6,'2024-11-08 09:00:00','2024-11-10 17:00:00'),(42,8,9,8,'2024-11-11 07:00:00','2024-11-15 19:00:00'),(43,11,9,8,'2024-11-11 07:00:00','2024-11-15 19:00:00'),(44,5,10,4,'2024-11-20 08:00:00','2024-11-22 16:00:00'),(45,10,10,4,'2024-11-20 08:00:00','2024-11-22 16:00:00'),(46,2,11,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(47,3,11,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(48,4,11,1,'2024-11-05 08:00:00','2024-11-10 18:00:00'),(49,5,11,2,'2024-11-08 08:30:00','2024-11-12 17:30:00'),(50,6,11,2,'2024-11-08 08:30:00','2024-11-12 17:30:00'),(51,7,11,2,'2024-11-08 08:30:00','2024-11-12 17:30:00'),(52,8,11,3,'2024-11-10 09:00:00','2024-11-15 17:00:00'),(53,9,11,3,'2024-11-10 09:00:00','2024-11-15 17:00:00'),(54,10,11,3,'2024-11-10 09:00:00','2024-11-15 17:00:00'),(55,11,11,4,'2024-11-18 08:00:00','2024-11-20 16:00:00'),(56,2,11,5,'2024-11-22 07:00:00','2024-11-25 19:00:00'),(57,5,11,5,'2024-11-22 07:00:00','2024-11-25 19:00:00'),(58,8,11,5,'2024-11-22 07:00:00','2024-11-25 19:00:00'),(59,10,11,5,'2024-11-22 07:00:00','2024-11-25 19:00:00');
/*!40000 ALTER TABLE `task_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasklist`
--

DROP TABLE IF EXISTS `tasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasklist` (
  `TASK_ID` int NOT NULL AUTO_INCREMENT,
  `Task_Name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`TASK_ID`),
  UNIQUE KEY `Task_Name` (`Task_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasklist`
--

LOCK TABLES `tasklist` WRITE;
/*!40000 ALTER TABLE `tasklist` DISABLE KEYS */;
INSERT INTO `tasklist` VALUES (1,'Construction and Carpentry'),(2,'Demolition and Excavation'),(3,'Electrical Work'),(4,'Interior Construction'),(5,'Material Handling'),(6,'Miscellaneous'),(7,'Painting and Finishing'),(8,'Skilled Labor'),(9,'Systems Installation'),(10,'Trim and Finish');
/*!40000 ALTER TABLE `tasklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_specialties`
--

DROP TABLE IF EXISTS `user_specialties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_specialties` (
  `Task_ID` int DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  KEY `Task_ID` (`Task_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `user_specialties_ibfk_1` FOREIGN KEY (`Task_ID`) REFERENCES `tasklist` (`TASK_ID`),
  CONSTRAINT `user_specialties_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_specialties`
--

LOCK TABLES `user_specialties` WRITE;
/*!40000 ALTER TABLE `user_specialties` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_specialties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(64) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `First_Name` varchar(24) DEFAULT NULL,
  `Last_Name` varchar(24) DEFAULT NULL,
  `Phone_Number` varchar(16) DEFAULT NULL,
  `Address` varchar(128) DEFAULT NULL,
  `Birth_Date` date DEFAULT NULL,
  `Job_Title` enum('Admin','Employee') DEFAULT NULL,
  `Emergency_Contact_First_Name` varchar(24) DEFAULT NULL,
  `Emergency_Contact_Last_Name` varchar(24) DEFAULT NULL,
  `Emergency_Contact_Phone_Number` varchar(16) DEFAULT NULL,
  `Emergency_Contact_Relation` varchar(24) DEFAULT NULL,
  `Picture_File_Name` varchar(64) DEFAULT NULL,
  `Picture_File_Path` varchar(256) DEFAULT NULL,
  `Created_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'a@a.com','$2b$10$QPLN9qIECodBrl9IiZseY.8zFfGv7zzj1IjnP7DOi3rM0bSF/LxTG','Aaftab','Aaftab ','226-899-6843','2460 Eng Ave, Toronto','2000-04-22','Admin','Rajan','Raj','981-765-4321','Brother','Default_PFP','Default_PFP_Path','2024-11-19 06:37:00','2024-11-19 06:37:00'),(2,'daniel@example.com','password1','Daniel','Smith','123-456-7890','123 Maple Street','1990-01-01','Employee','John','Doe','098-765-4321','Brother','profile1.png','/profile_pictures/profile1.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(3,'pedro@example.com','password2','Pedro','Johnson','123-456-7891','456 Oak Avenue','1989-02-02','Employee','Jane','Doe','098-765-4322','Sister','profile2.png','/profile_pictures/profile2.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(4,'alessandro@example.com','password3','Alessandro','Martinez','123-456-7892','789 Pine Road','1991-03-03','Employee','Bob','Smith','098-765-4323','Friend','profile3.png','/profile_pictures/profile3.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(5,'miguel@example.com','password4','Miguel','Garcia','123-456-7893','321 Birch Lane','1992-04-04','Employee','Alice','Brown','098-765-4324','Cousin','profile4.png','/profile_pictures/profile4.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(6,'stephen@example.com','password5','Stephen','Williams','123-456-7894','654 Cedar Blvd','1988-05-05','Employee','Eve','Green','098-765-4325','Neighbor','profile5.png','/profile_pictures/profile5.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(7,'micael@example.com','password6','Micael','Jones','123-456-7895','987 Spruce Street','1993-06-06','Employee','Tom','White','098-765-4326','Uncle','profile6.png','/profile_pictures/profile6.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(8,'juanpablo@example.com','password7','Juan Pablo','Garcia','123-456-7896','159 Walnut Avenue','1991-07-07','Employee','Michael','Martinez','098-765-4327','Brother','profile7.png','/profile_pictures/profile7.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(9,'camilo@example.com','password8','Camilo','Hernandez','123-456-7897','753 Cherry Blvd','1992-08-08','Employee','Anna','Rodriguez','098-765-4328','Cousin','profile8.png','/profile_pictures/profile8.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(10,'antonio@example.com','password9','Antonio','Torres','123-456-7898','852 Poplar Road','1993-09-09','Employee','David','Perez','098-765-4329','Friend','profile9.png','/profile_pictures/profile9.png','2024-11-19 07:03:32','2024-11-19 07:03:32'),(11,'jose@example.com','password10','Jose','Teixeira','123-456-7899','951 Aspen Lane','1994-10-10','Employee','Laura','Gonzalez','098-765-4330','Uncle','profile10.png','/profile_pictures/profile10.png','2024-11-19 07:03:32','2024-11-19 07:03:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'caliber'
--
/*!50003 DROP PROCEDURE IF EXISTS `AssignTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AssignTask`(IN Employee_ID INT, IN Project_ID INT, IN Task_Assigned INT, IN Time_Start DATETIME, IN Time_Finish DATETIME)
BEGIN
	INSERT INTO TASK_ASSIGNMENTS (Employee_Assigned, Project_ID, Task_Assigned, Time_Start, Time_Finish )
    VALUES 
    (
    Employee_ID,
    Project_ID,
    Task_Assigned,
    Time_Start,
    Time_Finish
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateAttachment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateAttachment`(
    IN projectID INT,
    IN attachmentName VARCHAR(64),
    IN attachmentType ENUM('Document', 'Video', 'Image', 'Other'),
    IN fileFormat VARCHAR(16),
    IN filePath VARCHAR(256)
)
BEGIN
    INSERT INTO PROJECT_ATTACHMENTS (Project_ID, Attachment_Name, Attachment_Type, File_Format, File_Path)
    VALUES (projectID, attachmentName, attachmentType, fileFormat, filePath);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateDatabaseTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateDatabaseTables`()
BEGIN
    CREATE TABLE IF NOT EXISTS USERS (
        ID INT AUTO_INCREMENT PRIMARY KEY,
        Email VARCHAR(64) NOT NULL,
        Password VARCHAR(64) NOT NULL,
        First_Name VARCHAR(24),
        Last_Name VARCHAR(24),
        Phone_Number VARCHAR(16),
        Address VARCHAR(128),
        Birth_Date DATE,
        Job_Title ENUM('Admin','Employee'),
        Emergency_Contact_First_Name VARCHAR(24),
        Emergency_Contact_Last_Name VARCHAR(24),
        Emergency_Contact_Phone_Number VARCHAR(16),
        Emergency_Contact_Relation VARCHAR(24),
        Picture_File_Name VARCHAR(64),
        Picture_File_Path VARCHAR(256),
        Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE (Email)
    );

    CREATE TABLE IF NOT EXISTS TASKLIST (
        TASK_ID INT AUTO_INCREMENT PRIMARY KEY,
        Task_Name VARCHAR(64),
        UNIQUE (Task_Name)
    );

    CREATE TABLE IF NOT EXISTS SUBTASKLIST (
        SUBTASK_ID INT AUTO_INCREMENT PRIMARY KEY,
        Subtask_Name VARCHAR(64),
        Related_Task INT,
        FOREIGN KEY (Related_Task) REFERENCES TASKLIST(TASK_ID),
        UNIQUE (Subtask_Name)
    );
    
    CREATE TABLE IF NOT EXISTS USER_SPECIALTIES ( 
		Task_ID INT, 
        User_ID INT, 
        FOREIGN KEY (Task_ID) REFERENCES TASKLIST(TASK_ID),
        FOREIGN KEY (User_ID) REFERENCES USERS(ID)
    );

    CREATE TABLE IF NOT EXISTS PROJECTS (
        PROJECT_ID INT AUTO_INCREMENT PRIMARY KEY,
        Project_Description VARCHAR(256),
        Address VARCHAR(256),
        Post_Code VARCHAR(10),
        Contact_Phone VARCHAR(16),
        Contact_Email VARCHAR(64),
        Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Created_By INT,
        Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        Status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
        FOREIGN KEY (Created_By) REFERENCES USERS(ID)
    );

    CREATE TABLE IF NOT EXISTS PROJECT_TASKLIST (
        PROJECT_TASK_ID INT AUTO_INCREMENT PRIMARY KEY,
        Project_ID INT,
        Task_ID INT,
        FOREIGN KEY (Project_ID) REFERENCES PROJECTS(PROJECT_ID),
        FOREIGN KEY (Task_ID) REFERENCES TASKLIST(TASK_ID)
    );

    CREATE TABLE IF NOT EXISTS PROJECT_SUBTASKLIST (
        PROJECT_SUBTASK_ID INT AUTO_INCREMENT PRIMARY KEY,
        Project_ID INT,
        Subtask_ID INT,
        FOREIGN KEY (Project_ID) REFERENCES PROJECTS(PROJECT_ID),
        FOREIGN KEY (Subtask_ID) REFERENCES SUBTASKLIST(SUBTASK_ID)
    );

    CREATE TABLE IF NOT EXISTS PROJECT_ATTACHMENTS (
        ATTACHMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
        Project_ID INT,
        Attachment_Name VARCHAR(64),
        Attachment_Type ENUM('Document', 'Video', 'Image', 'Other'),
        File_Format VARCHAR(16),
        File_Path VARCHAR(256),
        Upload_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (Project_ID) REFERENCES PROJECTS(PROJECT_ID)
    );

    CREATE TABLE IF NOT EXISTS TASK_ASSIGNMENTS (
        ASSIGNMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
        Employee_Assigned INT,
        Project_ID INT,
        Task_Assigned INT,
        Time_Start DATETIME,
        Time_Finish DATETIME,
        FOREIGN KEY (Employee_Assigned) REFERENCES USERS(ID),
        FOREIGN KEY (Project_ID) REFERENCES PROJECTS(PROJECT_ID),
        FOREIGN KEY (Task_Assigned) REFERENCES TASKLIST(TASK_ID)
    );
    
    CREATE TABLE IF NOT EXISTS SERVICE_CALLS (
        SERVICE_CALL_ID INT AUTO_INCREMENT PRIMARY KEY, 
        Service_Call_Description VARCHAR(256),
        Address VARCHAR(256),
        Post_Code VARCHAR(10),
        Contact_Phone VARCHAR(16),
        Contact_Email VARCHAR(64),
        Site_Status ENUM('OnSite','OffSite'),
        Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Created_By INT,
        Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        Status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
        FOREIGN KEY (Created_By) REFERENCES USERS(ID)
    );
    
    CREATE TABLE IF NOT EXISTS SERVICE_TASK_ASSIGNMENTS ( 
        SERVICE_TASK_ID INT AUTO_INCREMENT PRIMARY KEY,
        Service_Call_ID INT,
        Task_ID INT,
        Employee_Assigned INT,
		Time_Start DATETIME, 
        Time_Finish DATETIME,
        FOREIGN KEY (SERVICE_Call_ID) REFERENCES SERVICE_CALLS(SERVICE_CALL_ID),
        FOREIGN KEY (Task_ID) REFERENCES TASKLIST(TASK_ID),
        FOREIGN KEY (Employee_Assigned) REFERENCES USERS(ID)
    );
    
    CREATE TABLE IF NOT EXISTS SERVICE_SUBTASKS ( 
        SERVICE_SUBTASK_ID INT AUTO_INCREMENT PRIMARY KEY, 
        Service_Call_ID INT,
        Subtask_ID INT,
        FOREIGN KEY (Service_Call_ID) REFERENCES SERVICE_CALLS(SERVICE_CALL_ID),
        FOREIGN KEY (Subtask_ID) REFERENCES SUBTASKLIST(SUBTASK_ID)
    );
    
    CREATE TABLE IF NOT EXISTS SERVICE_ATTACHMENTS (
        ATTACHMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
        Service_Call_ID INT,
        Attachment_Name VARCHAR(64),
        Attachment_Type ENUM('Document', 'Video', 'Image', 'Other'),
        File_Format VARCHAR(16),
        File_Path VARCHAR(256),
        Upload_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (Service_Call_ID) REFERENCES SERVICE_CALLS(SERVICE_CALL_ID)
    );
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateMasterSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateMasterSubtask`(IN Subtask_Name Varchar(128), IN Related_Task INT)
BEGIN
	INSERT INTO SUBTASKLIST(Subtask_Name,Related_Task) 
    VALUES 
    (
    Subtask_Name, 
    Related_Task
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateMasterTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateMasterTask`(IN taskName VARCHAR(64))
BEGIN
    IF EXISTS (SELECT 1 FROM TASKLIST WHERE Task_Name = taskName) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Task name already exists';
    ELSE
        INSERT INTO TASKLIST (Task_Name) VALUES (taskName);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateProject`(
    IN p_description VARCHAR(256),
    IN p_address VARCHAR(256),
    IN p_postCode VARCHAR(10),
    IN p_contactPhone VARCHAR(16),
    IN p_contactEmail VARCHAR(64),
    IN p_createdBy INT,
    IN p_status VARCHAR(20) 
)
BEGIN
    IF p_status IS NULL OR p_status = '' THEN
        SET p_status = 'Pending';
    END IF;

    INSERT INTO PROJECTS (
        Project_Description,
        Address,
        Post_Code,
        Contact_Phone,
        Contact_Email,
        Created_By,
        Status
    ) VALUES (
        p_description,
        p_address,
        p_postCode,
        p_contactPhone,
        p_contactEmail,
        p_createdBy,
        p_status
    );
        SELECT LAST_INSERT_ID() AS insertedId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateProjectSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateProjectSubtask`(IN Project_ID int, IN Subtask_ID INT)
BEGIN
	INSERT INTO Project_Subtasklist(Project_ID, Subtask_ID)
    VALUES
    (Project_ID, Subtask_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateProjectTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateProjectTask`(
    IN _Project_ID INT,
    IN _Task_ID INT
)
BEGIN
    INSERT INTO PROJECT_TASKLIST (Project_ID, Task_ID) 
    VALUES (_Project_ID, _Task_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateServiceCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateServiceCall`(
    IN _Service_Call_Description VARCHAR(256),
    IN _Address VARCHAR(256),
    IN _Post_Code VARCHAR(10),
    IN _Contact_Phone VARCHAR(16),
    IN _Contact_Email VARCHAR(64),
    IN _Site_Status VARCHAR(20),
    IN _Created_By INT,
    IN _Status VARCHAR(20)
)
BEGIN
    IF _Status IS NULL OR _Status = '' THEN
        SET _Status = 'Pending';
    END IF;

    INSERT INTO SERVICE_CALLS (
        Service_Call_Description,
        Address,
        Post_Code,
        Contact_Phone,
        Contact_Email,
        Site_Status, 
        Created_By,
        Status
    ) VALUES (
        _Service_Call_Description,
        _Address,
        _Post_Code,
        _Contact_Phone,
        _Contact_Email,
        _Site_Status, 
        _Created_By,
        _Status
    );

    SELECT LAST_INSERT_ID() AS insertedId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateServiceCallAttachment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateServiceCallAttachment`(
    IN SERVICE_CALL_ID INT,
    IN attachmentName VARCHAR(64),
    IN attachmentType ENUM('Document', 'Video', 'Image', 'Other'),
    IN fileFormat VARCHAR(16),
    IN filePath VARCHAR(256)
)
BEGIN
    INSERT INTO SErVICE_ATTACHMENTS (Service_Call_ID, Attachment_Name, Attachment_Type, File_Format, File_Path)
    VALUES (SERVICE_CALL_ID, attachmentName, attachmentType, fileFormat, filePath);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateServiceCallSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateServiceCallSubtask`(IN Service_Call_ID int, IN Subtask_ID INT)
BEGIN
	INSERT INTO SERVICE_SUBTASKS(Service_Call_ID, Subtask_ID)
    VALUES
    (Service_Call_ID, Subtask_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateServiceCallTaskAssignment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateServiceCallTaskAssignment`(
IN ServiceCallID INT, 
IN taskID INT, 
IN employeeAssigned INT,
IN timeStart DATETIME,
IN timeFinish DATETIME
)
BEGIN
	INSERT INTO SERVICE_TASK_ASSIGNMENTS(Service_Call_ID, Task_ID, Employee_Assigned, Time_Start, Time_Finish)
    VALUES (ServiceCallID, taskID, employeeAssigned, timeStart, timeFinish)
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUser`(
	IN p_email VARCHAR(64),
    IN p_password VARCHAR(64),
    IN First_Name VARCHAR(24),
    IN Last_Name VARCHAR(24),
    IN Phone_Number VARCHAR(16),
    IN Address VARCHAR(128),
    IN Birth_Date DATE, 
    IN Job_Title ENUM('Admin','Employee'),
    IN Emergency_Contact_First_Name VARCHAR(24),
    IN Emergency_Contact_Last_Name VARCHAR(24),
    IN Emergency_Contact_Phone_Number VARCHAR(16),
    IN Emergency_Contact_Relation VARCHAR(24), 
    IN Picture_File_Name VARCHAR(64), 
    IN Picture_File_Path VARCHAR(256) 
)
BEGIN

	IF Picture_File_Name IS NULL OR Picture_File_Path IS NULL THEN 
    
    INSERT INTO USERS (
    Email, 
    Password, 
    First_Name, 
    Last_Name, 
    Phone_Number, 
    Address,
    Birth_Date, 
    Job_Title,
    Emergency_Contact_First_Name, 
    Emergency_Contact_Last_Name, 
    Emergency_Contact_Phone_Number, 
    Emergency_Contact_Relation, 
    Picture_File_Name, 
    Picture_File_Path
    ) 
    VALUES (
    p_email, 
    p_password,
    First_Name,
    Last_Name, 
    Phone_Number, 
    Address,
    Birth_Date, 
    Job_Title,
    Emergency_Contact_First_Name, 
    Emergency_Contact_Last_Name, 
    Emergency_Contact_Phone_Number, 
    Emergency_Contact_Relation, 
    "Default_PFP",
    "Default_PFP_Path"
    );
    
    ELSE 
    
     INSERT INTO USERS (
    Email, 
    Password, 
    First_Name, 
    Last_Name, 
    Phone_Number, 
    Address,
    Birth_Date, 
    Job_Title,
    Emergency_Contact_First_Name, 
    Emergency_Contact_Last_Name, 
    Emergency_Contact_Phone_Number, 
    Emergency_Contact_Relation, 
    Picture_File_Name, 
    Picture_File_Path
    ) 
    VALUES (
    p_email, 
    p_password,
    First_Name,
    Last_Name, 
    Phone_Number, 
    Address,
    Birth_Date, 
    Job_Title,
    Emergency_Contact_First_Name, 
    Emergency_Contact_Last_Name, 
    Emergency_Contact_Phone_Number, 
    Emergency_Contact_Relation, 
    Picture_File_Name, 
    Picture_File_Path
    );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUserSpecialty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUserSpecialty`(IN User_ID INT, IN Specialty INT)
BEGIN
	INSERT INTO USER_SPECIALTIES(Task_ID, User_ID) VALUES (Specialty, User_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteAttachment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAttachment`(
    IN attachmentID INT
)
BEGIN
    DELETE FROM PROJECT_ATTACHMENTS WHERE ATTACHMENT_ID = attachmentID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMasterSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMasterSubtask`(IN Subtask_ID INT)
BEGIN
	DELETE FROM subtasklist WHERE SUBTASK_ID = Subtask_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMasterTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMasterTask`(IN p_taskId INT)
BEGIN
    DELETE FROM TASKLIST WHERE TASK_ID = p_taskId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProject`(
    IN p_projectId INT
)
BEGIN
    DELETE FROM PROJECTS WHERE PROJECT_ID = p_projectId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProjectSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProjectSubtask`(IN Subtask_ID INT)
BEGIN
	DELETE FROM subtasklist WHERE SUBTASK_ID = Subtask_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProjectTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProjectTask`(
    IN _PROJECT_TASK_ID INT
)
BEGIN
    DELETE FROM PROJECT_TASKLIST 
    WHERE PROJECT_TASK_ID = _PROJECT_TASK_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteServiceCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteServiceCall`(
IN s_ID INT
)
BEGIN
	DELETE FROM SERVICE_CALLS WHERE SERVICE_CALL_ID = s_ID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteServiceCallSubtask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteServiceCallSubtask`(IN Subtask_ID INT)
BEGIN
	DELETE FROM SERVICE_SUBTASKS WHERE SERVICE_SUBTASK_ID = Subtask_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteServiceCallTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteServiceCallTask`(
    IN _SERVICE_CALL_TASK_ID INT
)
BEGIN
    DELETE FROM SERVICE_TASK_ASSIGNMENTS
    WHERE SERVICE_TASK_ID = _SERVICE_CALL_TASK_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllMasterSubtasks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllMasterSubtasks`()
BEGIN
    SELECT * FROM SUBTASKLIST;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllMasterTasks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllMasterTasks`()
BEGIN
    SELECT * FROM TASKLIST;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllProjects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllProjects`()
BEGIN
    SELECT * FROM PROJECTS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllServiceCalls` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllServiceCalls`()
BEGIN
	SELECT * FROM SERVICE_CALLS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers`()
BEGIN
	SELECT * FROM USERS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAssignedTasksByProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAssignedTasksByProject`(
    IN projectId INT
)
BEGIN
    SELECT TASK_ASSIGNMENTS.Employee_Assigned, TASK_ASSIGNMENTS.Task_Assigned, task_assignments.Time_Start , task_assignments.Time_Finish FROM TASK_ASSIGNMENTS 
    WHERE Project_ID = projectId
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAssignedTasksByServiceCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAssignedTasksByServiceCall`(
    IN ServiceId INT
)
BEGIN
    SELECT CONCAT(users.First_Name, ' ',users.Last_Name) AS Employee, SERVICE_TASK_ASSIGNMENTS.Task_ID, tasklist.Task_Name, SERVICE_TASK_ASSIGNMENTS.Time_Start , SERVICE_TASK_ASSIGNMENTS.Time_Finish FROM SERVICE_TASK_ASSIGNMENTS 
    INNER JOIN tasklist ON SERVICE_TASK_ASSIGNMENTS.Task_ID=tasklist.TASK_ID 
    INNER JOIN users ON SERVICE_TASK_ASSIGNMENTS.Employee_Assigned=users.ID 
    WHERE Service_Call_ID = ServiceId
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAttachmentsByProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttachmentsByProject`(
    IN projectId INT
)
BEGIN
    SELECT * FROM PROJECT_ATTACHMENTS WHERE Project_ID = projectId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAttachmentsByServiceCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttachmentsByServiceCall`(
    IN serviceAttachments INT
)
BEGIN
    SELECT * FROM service_attachments where service_call_id = serviceAttachments;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmployeesForService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeesForService`(IN service_id INT)
BEGIN
    SELECT 
        sta.Employee_Assigned,
        sta.Time_Start,
        sta.Time_Finish,
        u.First_Name,
        u.Last_Name,
        u.Email
    FROM 
        service_task_assignments sta
    LEFT JOIN 
        USERS u ON sta.Employee_Assigned = u.ID
    WHERE 
        sta.Service_Call_ID = service_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFilteredServiceCalls` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFilteredServiceCalls`(
    IN _Employee_Assigned VARCHAR(255), 
    IN _Tasks VARCHAR(255),
    IN _Address VARCHAR(255), 
    IN _Site_Status VARCHAR(50), 
    IN _Start_Time DATETIME, 
    IN _End_Time DATETIME
)
BEGIN
    SELECT DISTINCT 
           sc.Service_Call_ID, 
           sc.Service_Call_Description, 
           sc.Address, 
           sc.Post_Code,
           sc.Contact_Phone, 
           sc.Contact_Email, 
           sc.Site_Status, 
           sc.Created_By,
           sc.Status,
           MIN(s.time_start) AS Earliest_Shift_Start,
           MAX(s.time_finish) AS Latest_Shift_End
    FROM service_calls sc
    JOIN service_task_assignments s 
        ON sc.Service_Call_ID = s.Service_Call_ID
    WHERE 
        (_Employee_Assigned IS NULL OR FIND_IN_SET(s.Employee_Assigned, _Employee_Assigned)) 
        AND (_Tasks IS NULL OR FIND_IN_SET(s.Task_ID, _Tasks)) 
        AND (_Address IS NULL OR sc.Address LIKE CONCAT('%', _Address, '%')) 
        AND (_Site_Status IS NULL OR sc.Site_Status = _Site_Status) 
    GROUP BY 
        sc.Service_Call_ID, 
        sc.Service_Call_Description, 
        sc.Address, 
        sc.Post_Code, 
        sc.Contact_Phone, 
        sc.Contact_Email, 
        sc.Site_Status, 
        sc.Created_By,
        sc.Status
    HAVING 
        (_Start_Time IS NULL OR _End_Time IS NULL) 
        OR (Earliest_Shift_Start >= _Start_Time AND Latest_Shift_End <= _End_Time);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMasterTaskById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMasterTaskById`(IN Task_ID INT)
BEGIN
	SELECT tasklist.Task_Name FROM tasklist 
    WHERE tasklist.Task_ID = Task_ID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProjectById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectById`(
    IN p_projectId INT
)
BEGIN
    SELECT * FROM PROJECTS WHERE PROJECT_ID = p_projectId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProjectSubtasksByProjectID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectSubtasksByProjectID`(IN ProjectID INT)
BEGIN
	SELECT project_subtasklist.Project_ID , project_subtasklist.Subtask_ID FROM Project_Subtasklist 
    WHERE Project_ID = ProjectID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProjectTasksByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectTasksByID`(
    IN _Project_ID INT
)
BEGIN
    SELECT PROJECT_TASKLIST.Project_ID, PROJECT_TASKLIST.Task_ID, tasklist.Task_ID FROM PROJECT_TASKLIST 
    INNER JOIN tasklist ON PROJECT_TASKLIST.Task_ID = tasklist.Task_ID
    WHERE Project_ID = _Project_ID;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetServiceCallById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetServiceCallById`(
    IN _Service_Id INT
)
BEGIN
    SELECT * FROM SERVICE_CALLS WHERE SERVICE_CALL_ID = _Service_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetServiceTasksByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetServiceTasksByID`(
    IN _Service_ID INT
)
BEGIN
    SELECT service_task_assignments.Service_Call_ID, service_task_assignments.Task_ID, service_task_assignments.Employee_Assigned,service_task_assignments.Time_Start,service_task_assignments.Time_Finish, tasklist.Task_ID FROM service_task_assignments
    INNER JOIN tasklist ON service_task_assignments.Task_ID = tasklist.Task_ID
    WHERE Service_Call_ID = _Service_ID
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSubtaskByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSubtaskByID`(
IN p_Subtask_ID INT)
BEGIN
    SELECT * 
    FROM SUBTASKLIST 
    WHERE SUBTASK_ID = p_Subtask_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSubtaskByTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSubtaskByTask`(IN Task_ID INT)
BEGIN
	SELECT * FROM SUBTASKLIST WHERE Related_Task = Task_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSubtasksByProjectID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSubtasksByProjectID`(IN Project_ID INT)
BEGIN
	SELECT * FROM Project_Subtasklist WHERE Project_ID = Project_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSubtasksByServiceCallID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSubtasksByServiceCallID`(IN Service_Call_ID INT)
BEGIN
	SELECT * FROM SERVICE_SUBTASKS WHERE SERVICE_SUBTASKS.Service_Call_ID = Service_Call_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTimeFrameByProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTimeFrameByProject`(IN Project_ID INT)
BEGIN
	SELECT 
    MIN(Time_Start),
    MAX(Time_Finish)
	FROM TASK_ASSIGNMENTS     
    WHERE TASK_ASSIGNMENTS.Project_ID = Project_ID 
    ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserById`(
    IN ID INT
)
BEGIN
    SELECT * FROM USERS WHERE USERS.ID = ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserBySpecialty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserBySpecialty`(IN Specialty INT)
BEGIN
 SELECT * FROM User_Specialties WHERE Task_ID = Specialty;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateMasterTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMasterTask`(IN p_taskId INT, IN p_taskName VARCHAR(64))
BEGIN
    UPDATE TASKLIST SET Task_Name = p_taskName WHERE TASK_ID = p_taskId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProject`(
    IN p_id INT,
    IN p_description VARCHAR(256),
    IN p_address VARCHAR(256),
    IN p_postCode VARCHAR(10),
    IN p_contactPhone VARCHAR(16),
    IN p_contactEmail VARCHAR(64),
    IN p_status VARCHAR(20)  -- Keep this as VARCHAR
)
BEGIN
    IF p_status IS NULL OR p_status = '' THEN
        SET p_status = 'Pending';
    END IF;

    UPDATE PROJECTS
    SET 
        Project_Description = p_description,
        Address = p_address,
        Post_Code = p_postCode,
        Contact_Phone = p_contactPhone,
        Contact_Email = p_contactEmail,
        Status = p_status,
        Updated_At = CURRENT_TIMESTAMP
    WHERE 
        PROJECT_ID = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProjectTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProjectTask`(
    IN _PROJECT_TASK_ID INT,
    IN _Project_ID INT,
    IN _Task_ID INT
)
BEGIN
    UPDATE PROJECT_TASKLIST 
    SET Project_ID = _Project_ID, Task_ID = _Task_ID 
    WHERE PROJECT_TASK_ID = _PROJECT_TASK_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateServiceCall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateServiceCall`(
	IN s_id INT,
    IN s_description VARCHAR(256),
	IN s_address VARCHAR(256),
    IN s_postcode VARCHAR(10),
    IN s_contactPhone VARCHAR(16),
    IN s_contactEmail VARCHAR(64),
    IN s_sitestatus VARCHAR(20), 
    IN s_status VARCHAR(20)
)
BEGIN
	IF s_status IS NULL OR s_status = '' THEN
        SET s_status = 'Pending';
    END IF;
    
    UPDATE SERVICE_CALLS
    SET 
		Service_Call_Description = s_description,
        Address = s_address,
        Post_Code = s_postCode,
        Contact_Phone = s_contactPhone,
        Contact_Email = s_contactEmail,
        Site_Status = s_sitestatus, 
        Status = s_status,
        Updated_At = CURRENT_TIMESTAMP
    WHERE 
        SERVICE_CALL_ID = s_id
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-20 22:41:13
