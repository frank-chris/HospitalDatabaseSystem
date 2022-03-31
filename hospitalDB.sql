-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: hospitaldb
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allot`
--

DROP TABLE IF EXISTS `allot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allot` (
  `equipment_id` int NOT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `room_no` (`room_no`),
  CONSTRAINT `allot_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `allot_ibfk_2` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allot`
--

LOCK TABLES `allot` WRITE;
/*!40000 ALTER TABLE `allot` DISABLE KEYS */;
INSERT INTO `allot` VALUES (1,101),(7,101),(10,101),(2,102),(3,103),(5,104),(4,105),(6,105),(8,106),(9,107),(11,201),(13,202),(14,203),(16,204),(12,205),(15,205),(17,205);
/*!40000 ALTER TABLE `allot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ambulance`
--

DROP TABLE IF EXISTS `ambulance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambulance` (
  `amb_id` int NOT NULL,
  `vehicle_no` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`amb_id`),
  UNIQUE KEY `amb_id` (`amb_id`),
  UNIQUE KEY `vehicle_no` (`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulance`
--

LOCK TABLES `ambulance` WRITE;
/*!40000 ALTER TABLE `ambulance` DISABLE KEYS */;
INSERT INTO `ambulance` VALUES (1,'GJ01RH3715','Basic Life Support Ambulance'),(2,'GJ01DF1543','Basic Life Support Ambulance'),(3,'GJ01SK6392','Mobile ICU Ambulance');
/*!40000 ALTER TABLE `ambulance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ambulance_services`
--

DROP TABLE IF EXISTS `ambulance_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambulance_services` (
  `emp_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `amb_id` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`,`patient_id`,`date_of_admittance`),
  KEY `patient_id` (`patient_id`,`date_of_admittance`),
  CONSTRAINT `ambulance_services_ibfk_1` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulance_services`
--

LOCK TABLES `ambulance_services` WRITE;
/*!40000 ALTER TABLE `ambulance_services` DISABLE KEYS */;
INSERT INTO `ambulance_services` VALUES (222,432,'2020-05-17',2),(222,436,'2020-05-24',1),(222,441,'2021-05-06',3),(223,432,'2020-02-20',2),(223,437,'2020-03-26',2),(223,438,'2020-10-29',1);
/*!40000 ALTER TABLE `ambulance_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `doctor_emp_id` int NOT NULL,
  `rec_emp_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `appointment_id` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`doctor_emp_id`,`rec_emp_id`,`patient_id`,`date_of_admittance`),
  UNIQUE KEY `appointment_id` (`appointment_id`),
  KEY `rec_emp_id` (`rec_emp_id`),
  KEY `patient_id` (`patient_id`,`date_of_admittance`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`doctor_emp_id`) REFERENCES `doctor` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`rec_emp_id`) REFERENCES `receptionist` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (207,227,432,'2020-02-20',1,'2020-02-13'),(207,227,432,'2020-05-17',4,'2020-05-12'),(209,228,433,'2020-09-22',2,'2020-09-18'),(210,228,434,'2020-03-27',3,'2020-03-25'),(212,229,435,'2020-01-19',5,'2020-01-12');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashier`
--

DROP TABLE IF EXISTS `cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier` (
  `emp_id` int NOT NULL,
  `counter_no` int NOT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `cashier_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashier`
--

LOCK TABLES `cashier` WRITE;
/*!40000 ALTER TABLE `cashier` DISABLE KEYS */;
INSERT INTO `cashier` VALUES (224,1),(225,2),(226,3);
/*!40000 ALTER TABLE `cashier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_name` varchar(512) NOT NULL,
  `budget` int NOT NULL,
  PRIMARY KEY (`dept_name`),
  UNIQUE KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('OPD',20000),('OT Complex',100000),('Paramedical',30000),('Radiology',50000);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_floor`
--

DROP TABLE IF EXISTS `department_floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_floor` (
  `dept_name` varchar(512) NOT NULL,
  `floor` int NOT NULL,
  PRIMARY KEY (`dept_name`,`floor`),
  CONSTRAINT `department_floor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_floor`
--

LOCK TABLES `department_floor` WRITE;
/*!40000 ALTER TABLE `department_floor` DISABLE KEYS */;
INSERT INTO `department_floor` VALUES ('OPD',1),('OT Complex',2),('Paramedical',1),('Radiology',2);
/*!40000 ALTER TABLE `department_floor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_dept`
--

DROP TABLE IF EXISTS `doc_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_dept` (
  `emp_id` int NOT NULL,
  `dept_name` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `doc_dept_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `doctor` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `doc_dept_ibfk_2` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_dept`
--

LOCK TABLES `doc_dept` WRITE;
/*!40000 ALTER TABLE `doc_dept` DISABLE KEYS */;
INSERT INTO `doc_dept` VALUES (207,'OPD'),(209,'OPD'),(210,'OPD'),(212,'OPD'),(206,'OT Complex'),(211,'OT Complex'),(208,'Paramedical'),(213,'Radiology'),(214,'Radiology');
/*!40000 ALTER TABLE `doc_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_offices`
--

DROP TABLE IF EXISTS `doc_offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_offices` (
  `emp_id` int NOT NULL,
  `office_no` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `office_no` (`office_no`),
  CONSTRAINT `doc_offices_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `doctor` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `doc_offices_ibfk_2` FOREIGN KEY (`office_no`) REFERENCES `office` (`office_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_offices`
--

LOCK TABLES `doc_offices` WRITE;
/*!40000 ALTER TABLE `doc_offices` DISABLE KEYS */;
INSERT INTO `doc_offices` VALUES (206,102),(207,103),(208,104),(209,201),(210,202),(211,203),(212,204),(213,205),(214,206);
/*!40000 ALTER TABLE `doc_offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `emp_id` int NOT NULL,
  `specialization` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (206,'Anesthesiologist'),(207,'Dermatologist'),(208,'Endocrinologist'),(209,'Family Physician'),(210,'Family Physician'),(211,'Neurologist'),(212,'Pediatrician'),(213,'Radiologist'),(214,'Radiologist');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `emp_id` int NOT NULL,
  `license_no` varchar(128) NOT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `driver_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (222,'GJ02 20193456721'),(223,'GJ01 20183139319');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_id` int NOT NULL,
  `first_name` varchar(32) NOT NULL,
  `middle_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `dob` date NOT NULL,
  `gender` varchar(32) NOT NULL,
  `joining_date` date NOT NULL,
  `salary` int NOT NULL,
  `qualification` varchar(64) NOT NULL,
  `house_no` int NOT NULL,
  `street` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `pin_code` int NOT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_id` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (205,'Julian','H','Wilson','1970-08-17','Female','2020-07-07',73000,'MD',33,'Lismore Villas','Agra',352898),(206,'Cherry','R','Fowler','1985-06-19','Female','2009-10-15',19000,'MD',18,'Monks Cliff','Rourkela',309411),(207,'Emily','Y','Carroll','1977-03-26','Female','1992-12-08',31000,'MD',59,'Piper West','Berhampur',348489),(208,'Lucy','S','Ryan','1970-07-16','Female','2015-04-06',92000,'MBBS',80,'Oakdale Willows','Jaunpur',379664),(209,'Agata','G','Carter','1981-02-07','Male','2001-12-26',17000,'MBBS',2,'Brambling Town','Hindupur',361891),(210,'Maria','B','Richards','1972-07-29','Male','2009-07-07',85000,'MD',85,'Watery Strand','Tadepalligudem',353289),(211,'Emma','F','Turner','1973-09-09','Male','2012-11-23',22000,'MD',89,'Windermere Drift','Jaipur',307026),(212,'Walter','A','Gibson','1979-09-08','Female','1999-11-05',73000,'MD',6,'Cowley Mount','Coimbatore',324710),(213,'David','R','Foster','1975-07-15','Female','2003-06-29',85000,'MBBS',32,'Furze Spur','Chennai',363798),(214,'Aston','U','Richards','1973-11-03','Male','2018-06-28',81000,'MBBS',11,'Crawford Cloisters','Motihari',357370),(215,'Ada','I','Fowler','1988-02-25','Female','2010-04-12',37000,'GNM',57,'Broad North','Jammu',370025),(216,'Sarah','O','Smith','1980-06-12','Male','2007-01-01',24000,'ANM',77,'Amberley Broadway','Serampore',371051),(217,'Oscar','P','Thomas','1971-05-29','Male','1997-10-12',23000,'ANM',15,'Old Crosby','Aurangabad',358591),(218,'Harold','Q','Andrews','1976-07-27','Male','2021-12-02',49000,'ANM',43,'Beeston Cliff','Solapur',362246),(219,'Daniel','W','Armstrong','1985-05-15','Female','2004-10-06',60000,'GNM',76,'North Village','Tadepalligudem',380861),(220,'Paul','E','Thomas','1977-12-02','Female','2009-10-05',43000,'GNM',71,'Christopher Pleasant','Tiruchirappalli',304249),(221,'Andrew','V','Brown','1977-05-02','Male','2012-12-24',28000,'ANM',65,'Charnwood Barton','Satna',354573),(222,'Adison','C','Morris','1987-07-10','Female','1992-11-25',68000,'12th pass',18,'Dovecote Knoll','Mira-Bhayandar',319173),(223,'Alen','X','Johnson','1985-12-27','Male','2014-03-19',29000,'10th pass',98,'Alma Avenue','Ratlam',386301),(224,'Lilianna','S','Martin','1973-07-07','Female','1998-05-31',36000,'B. Com',39,'Percival Orchards','Rae Bareli',344075),(225,'Blake','R','Ross','1984-07-09','Female','1997-05-13',33000,'B. Com',13,'Chittock Gate','Asansol',366313),(226,'Robert','V','Fowler','1986-10-24','Female','2011-02-27',19000,'B. Com',69,'Sunny Lawns','Bettiah',302962),(227,'Kate','H','Montgomery','1986-09-16','Female','2000-08-14',11000,'BA',77,'Garfield Grove','Murwara',352615),(228,'Eddy','F','Owens','1984-07-24','Female','2007-11-13',62000,'BA',19,'Greenside Knoll','Howrah',397280),(229,'Maddie','D','Riley','1986-10-30','Male','2022-01-08',62000,'BA',38,'Popplewell Terrace','Surendranagar Dudhrej',325286);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_phone_no`
--

DROP TABLE IF EXISTS `employee_phone_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_phone_no` (
  `emp_id` int NOT NULL,
  `phone_no` varchar(16) NOT NULL,
  PRIMARY KEY (`emp_id`,`phone_no`),
  CONSTRAINT `employee_phone_no_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_phone_no`
--

LOCK TABLES `employee_phone_no` WRITE;
/*!40000 ALTER TABLE `employee_phone_no` DISABLE KEYS */;
INSERT INTO `employee_phone_no` VALUES (205,'5853440378'),(206,'2613910107'),(206,'5739728956'),(207,'7609606066'),(208,'4516542091'),(209,'6180226253'),(210,'8561258157'),(211,'2486465239'),(212,'8195639028'),(213,'5757118376'),(214,'6961136958'),(215,'58501458'),(216,'5426370317'),(217,'7748621316'),(218,'3199590826'),(219,'5083136142'),(219,'9061253835'),(220,'470778793'),(221,'8152734851'),(221,'8961788945'),(222,'5730999117'),(222,'9853348301'),(223,'1272787248'),(224,'6407764818'),(225,'7015405691'),(225,'7210814309'),(226,'9681331255'),(227,'7442335675'),(228,'1998536620'),(228,'2002818417'),(229,'8093001583');
/*!40000 ALTER TABLE `employee_phone_no` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL,
  `purchase_date` date NOT NULL,
  `name` varchar(1024) NOT NULL,
  PRIMARY KEY (`equipment_id`),
  UNIQUE KEY `equipment_id` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'2016-03-04','equipment-0-01'),(2,'2016-03-04','equipment-0-02'),(3,'2016-03-04','equipment-0-03'),(4,'2016-03-04','equipment-0-04'),(5,'2016-03-04','equipment-0-05'),(6,'2016-04-04','equipment-1-01'),(7,'2016-04-04','equipment-1-02'),(8,'2016-04-04','equipment-1-03'),(9,'2016-04-04','equipment-1-04'),(10,'2016-05-04','equipment-2-01'),(11,'2016-05-04','equipment-2-02'),(12,'2016-05-04','equipment-2-03'),(13,'2017-06-07','new-equipment-0-01'),(14,'2017-06-07','new-equipment-0-02'),(15,'2017-06-07','new-equipment-0-03'),(16,'2017-07-08','new-equipment-1-01'),(17,'2017-07-08','new-equipment-1-02');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gets`
--

DROP TABLE IF EXISTS `gets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gets` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `room_no` int NOT NULL,
  `prescription` varchar(512) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`,`room_no`,`prescription`,`date`),
  KEY `room_no` (`room_no`),
  KEY `patient_id` (`patient_id`,`date_of_admittance`,`date`,`prescription`),
  CONSTRAINT `gets_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gets_ibfk_2` FOREIGN KEY (`patient_id`, `date_of_admittance`, `date`, `prescription`) REFERENCES `treatment` (`patient_id`, `date_of_admittance`, `date`, `prescription`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gets`
--

LOCK TABLES `gets` WRITE;
/*!40000 ALTER TABLE `gets` DISABLE KEYS */;
INSERT INTO `gets` VALUES (432,'2020-02-20',101,'presc-001','2020-02-21'),(432,'2020-02-20',101,'presc-002','2020-02-21'),(432,'2020-05-17',101,'presc-003','2020-05-18'),(432,'2021-02-17',101,'presc-019','2021-02-18'),(440,'2020-01-20',103,'presc-014','2020-01-21'),(433,'2020-09-22',104,'presc-004','2020-09-23'),(434,'2020-03-27',105,'presc-005','2020-03-28'),(441,'2021-05-06',106,'presc-015','2021-05-07'),(435,'2020-01-19',107,'presc-006','2020-01-20'),(436,'2020-05-24',201,'presc-007','2020-05-25'),(437,'2020-03-26',202,'presc-008','2020-03-27'),(437,'2020-03-26',202,'presc-009','2020-03-28'),(437,'2020-03-26',202,'presc-010','2020-03-31'),(437,'2020-03-26',202,'presc-011','2020-04-02'),(438,'2020-10-29',203,'presc-012','2020-10-30'),(442,'2021-08-02',203,'presc-016','2021-08-03'),(439,'2020-06-03',204,'presc-013','2020-06-04'),(443,'2021-08-06',204,'presc-017','2021-08-07'),(444,'2021-02-16',205,'presc-018','2021-02-17');
/*!40000 ALTER TABLE `gets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guardian`
--

DROP TABLE IF EXISTS `guardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guardian` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `guardian_name` varchar(32) NOT NULL,
  `phone_no` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`,`guardian_name`),
  CONSTRAINT `guardian_ibfk_1` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guardian`
--

LOCK TABLES `guardian` WRITE;
/*!40000 ALTER TABLE `guardian` DISABLE KEYS */;
INSERT INTO `guardian` VALUES (432,'2020-02-20','John Hayes','8328184689'),(432,'2020-05-17','John Hayes','8328184689'),(432,'2021-02-17','Brandon Jenkins','8397106232'),(433,'2020-09-22','Lisa Mccarty','9053139412'),(434,'2020-03-27','David Garcia','9503085429'),(435,'2020-01-19','Stephanie Lawson','9880301414'),(436,'2020-05-24','Jesse Hanson','8206570944'),(437,'2020-03-26','Gregory Tapia','8373253232'),(438,'2020-10-29','Emily Ellis','9700422784'),(439,'2020-06-03','Paul Turner','9368364355'),(440,'2020-01-20','Sylvia Mendoza','8370882970'),(441,'2021-05-06','Katherine Sanford','9510337450'),(442,'2021-08-02','David Reed','8640236179'),(443,'2021-08-06','Makayla Gonzalez','9800074622'),(444,'2021-02-16','Samantha Jones','8338442130');
/*!40000 ALTER TABLE `guardian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `emp_id` int NOT NULL,
  `position` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `nurse_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (215,'Registered nurse'),(216,'Registered nurse'),(217,'Medical-surgical nurse'),(218,'Medical-surgical nurse'),(219,'ICU nurse'),(220,'ICU nurse'),(221,'Emergency room nurse');
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `office_no` int NOT NULL,
  `floor` int NOT NULL,
  PRIMARY KEY (`office_no`),
  UNIQUE KEY `office_no` (`office_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
INSERT INTO `office` VALUES (101,1),(102,1),(103,1),(104,1),(201,2),(202,2),(203,2),(204,2),(205,2),(206,2);
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `first_name` varchar(32) NOT NULL,
  `middle_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `dob` date NOT NULL,
  `gender` varchar(32) NOT NULL,
  `date_of_discharge` date DEFAULT NULL,
  `house_no` int NOT NULL,
  `street` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `pin_code` int NOT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (432,'2020-02-20','Andrew','F','Wilson','1991-08-10','Male','2020-02-23',17,'YWADMRF','Chennai',362677),(432,'2020-05-17','Andrew','F','Wilson','1991-08-10','Male','2020-05-22',42,'XNOMKWN','Motihari',345016),(432,'2021-02-17','Andrew','F','Wilson','1991-08-10','Male','2021-02-27',23,'HWQXDZQ','Rajkot',349896),(433,'2020-09-22','Alen','A','Carroll','2021-02-17','Male','2020-10-07',36,'FPRTGUF','Jammu',343435),(434,'2020-03-27','Lilianna','C','Ryan','1975-07-15','Female','2020-03-30',46,'MGXUBYI','Serampore',323461),(435,'2020-01-19','Blake','A','Carter','1973-11-03','Female','2020-01-29',28,'UQDYPYD','Aurangabad',395833),(436,'2020-05-24','Robert','G','Johnson','1988-02-25','Female','2020-06-06',30,'VTYOUTB','Solapur',309173),(437,'2020-03-26','Kate','T','Martin','1980-06-12','Female','2020-04-07',42,'TBTQCTF','Tadepalligudem',366244),(438,'2020-10-29','Eddy','H','Ross','1971-05-29','Female','2020-11-06',10,'MFQNMSW','Tiruchirappalli',352522),(439,'2020-06-03','Maddie','P','Fowler','1976-07-27','Male','2020-06-11',12,'VCKALRG','Satna',349119),(440,'2020-01-20','Maria','T','Montgomery','1985-05-15','Male','2020-02-04',23,'WFZUWAV','Mira-Bhayandar',313578),(441,'2021-05-06','Emma','S','Owens','1977-12-02','Male','2021-05-10',48,'VIQNFTY','Ratlam',394117),(442,'2021-08-02','Walter','B','Riley','1977-05-02','Female','2021-08-15',14,'FVDSHBO','Rae Bareli',353515),(443,'2021-08-06','David','I','Andrews','1987-07-10','Female','2021-08-21',19,'HCGOUIK','Asansol',304955),(444,'2021-02-16','Aston','D','Armstrong','1985-12-27','Male','2021-02-20',43,'VXCZNNA','Gandhinagar',357454);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_phone_no`
--

DROP TABLE IF EXISTS `patient_phone_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_phone_no` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `phone_no` varchar(16) NOT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`,`phone_no`),
  CONSTRAINT `patient_phone_no_ibfk_1` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_phone_no`
--

LOCK TABLES `patient_phone_no` WRITE;
/*!40000 ALTER TABLE `patient_phone_no` DISABLE KEYS */;
INSERT INTO `patient_phone_no` VALUES (432,'2020-02-20','9717683946'),(432,'2020-05-17','9717683946'),(432,'2021-02-17','9084337019'),(433,'2020-09-22','9723147714'),(434,'2020-03-27','9733508735'),(435,'2020-01-19','9104412474'),(436,'2020-05-24','8344240749'),(437,'2020-03-26','8813733203'),(438,'2020-10-29','9494389392'),(439,'2020-06-03','8277898994'),(440,'2020-01-20','9569031828'),(441,'2021-05-06','8866461865'),(442,'2021-08-02','9920117087'),(443,'2021-08-06','9922287837'),(444,'2021-02-16','9406281651');
/*!40000 ALTER TABLE `patient_phone_no` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `emp_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `room_no` int NOT NULL,
  `prescription` varchar(512) NOT NULL,
  `date` date NOT NULL,
  `payment_id` int NOT NULL,
  PRIMARY KEY (`emp_id`,`patient_id`,`date_of_admittance`,`room_no`,`prescription`,`date`),
  UNIQUE KEY `payment_id` (`payment_id`),
  KEY `room_no` (`room_no`),
  KEY `patient_id` (`patient_id`,`date_of_admittance`,`date`,`prescription`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`patient_id`, `date_of_admittance`, `date`, `prescription`) REFERENCES `treatment` (`patient_id`, `date_of_admittance`, `date`, `prescription`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`patient_id`, `date_of_admittance`, `date`, `prescription`) REFERENCES `treatment` (`patient_id`, `date_of_admittance`, `date`, `prescription`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (224,436,'2020-05-24',104,'presc-007','2020-05-25',100001),(224,437,'2020-03-26',105,'presc-009','2020-03-28',100002),(226,438,'2020-10-29',201,'presc-012','2020-10-30',100003),(224,441,'2021-05-06',202,'presc-015','2021-05-07',100004),(225,432,'2020-02-20',205,'presc-001','2020-02-21',100005),(225,432,'2020-05-17',101,'presc-003','2020-05-18',100006);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptionist`
--

DROP TABLE IF EXISTS `receptionist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receptionist` (
  `emp_id` int NOT NULL,
  `floor` int NOT NULL,
  PRIMARY KEY (`emp_id`),
  CONSTRAINT `receptionist_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptionist`
--

LOCK TABLES `receptionist` WRITE;
/*!40000 ALTER TABLE `receptionist` DISABLE KEYS */;
INSERT INTO `receptionist` VALUES (227,1),(228,2),(229,3);
/*!40000 ALTER TABLE `receptionist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_no` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`room_no`),
  UNIQUE KEY `room_no` (`room_no`),
  CONSTRAINT `room_chk_1` CHECK ((`price` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,10000),(102,10000),(103,10000),(104,12000),(105,12000),(106,15000),(107,15000),(201,17500),(202,17500),(203,20000),(204,20000),(205,25000);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takes_care`
--

DROP TABLE IF EXISTS `takes_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `takes_care` (
  `emp_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  PRIMARY KEY (`emp_id`,`patient_id`,`date_of_admittance`),
  KEY `patient_id` (`patient_id`,`date_of_admittance`),
  CONSTRAINT `takes_care_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `nurse` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `takes_care_ibfk_2` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takes_care`
--

LOCK TABLES `takes_care` WRITE;
/*!40000 ALTER TABLE `takes_care` DISABLE KEYS */;
INSERT INTO `takes_care` VALUES (215,432,'2020-02-20'),(216,432,'2020-05-17'),(221,432,'2021-02-17'),(217,433,'2020-09-22'),(218,434,'2020-03-27'),(215,435,'2020-01-19'),(216,436,'2020-05-24'),(217,437,'2020-03-26'),(218,438,'2020-10-29'),(215,439,'2020-06-03'),(216,440,'2020-01-20'),(217,441,'2021-05-06'),(218,442,'2021-08-02'),(221,443,'2021-08-06'),(221,444,'2021-02-16');
/*!40000 ALTER TABLE `takes_care` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `date` date NOT NULL,
  `prescription` varchar(512) NOT NULL,
  `cost` int NOT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`,`date`,`prescription`),
  CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `treatment_chk_1` CHECK ((`cost` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` VALUES (432,'2020-02-20','2020-02-21','presc-001',44564),(432,'2020-02-20','2020-02-21','presc-002',19700),(432,'2020-05-17','2020-05-18','presc-003',72398),(432,'2021-02-17','2021-02-18','presc-019',32426),(433,'2020-09-22','2020-09-23','presc-004',10181),(434,'2020-03-27','2020-03-28','presc-005',18057),(435,'2020-01-19','2020-01-20','presc-006',36799),(436,'2020-05-24','2020-05-25','presc-007',47332),(437,'2020-03-26','2020-03-27','presc-008',22294),(437,'2020-03-26','2020-03-28','presc-009',58450),(437,'2020-03-26','2020-03-31','presc-010',58774),(437,'2020-03-26','2020-04-02','presc-011',33043),(438,'2020-10-29','2020-10-30','presc-012',22900),(439,'2020-06-03','2020-06-04','presc-013',30304),(440,'2020-01-20','2020-01-21','presc-014',38278),(441,'2021-05-06','2021-05-07','presc-015',60078),(442,'2021-08-02','2021-08-03','presc-016',49115),(443,'2021-08-06','2021-08-07','presc-017',54716),(444,'2021-02-16','2021-02-17','presc-018',34665);
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treats`
--

DROP TABLE IF EXISTS `treats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treats` (
  `patient_id` int NOT NULL,
  `date_of_admittance` date NOT NULL,
  `emp_id` int DEFAULT NULL,
  PRIMARY KEY (`patient_id`,`date_of_admittance`),
  CONSTRAINT `treats_ibfk_1` FOREIGN KEY (`patient_id`, `date_of_admittance`) REFERENCES `patient` (`patient_id`, `date_of_admittance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treats`
--

LOCK TABLES `treats` WRITE;
/*!40000 ALTER TABLE `treats` DISABLE KEYS */;
INSERT INTO `treats` VALUES (432,'2020-02-20',207),(432,'2020-05-17',207),(432,'2021-02-17',207),(433,'2020-09-22',209),(434,'2020-03-27',210),(435,'2020-01-19',212),(436,'2020-05-24',205),(437,'2020-03-26',205),(438,'2020-10-29',206),(439,'2020-06-03',206),(440,'2020-01-20',208),(441,'2021-05-06',209),(442,'2021-08-02',211),(443,'2021-08-06',213),(444,'2021-02-16',214);
/*!40000 ALTER TABLE `treats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-31 23:03:55
