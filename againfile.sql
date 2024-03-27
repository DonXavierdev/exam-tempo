-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: sample
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add student',7,'add_student'),(26,'Can change student',7,'change_student'),(27,'Can delete student',7,'delete_student'),(28,'Can view student',7,'view_student'),(29,'Can add notification',8,'add_notification'),(30,'Can change notification',8,'change_notification'),(31,'Can delete notification',8,'delete_notification'),(32,'Can view notification',8,'view_notification'),(33,'Can add test',9,'add_test'),(34,'Can change test',9,'change_test'),(35,'Can delete test',9,'delete_test'),(36,'Can view test',9,'view_test'),(37,'Can add teacher',10,'add_teacher'),(38,'Can change teacher',10,'change_teacher'),(39,'Can delete teacher',10,'delete_teacher'),(40,'Can view teacher',10,'view_teacher'),(41,'Can add users',11,'add_users'),(42,'Can change users',11,'change_users'),(43,'Can delete users',11,'delete_users'),(44,'Can view users',11,'view_users'),(45,'Can add student allocation',12,'add_studentallocation'),(46,'Can change student allocation',12,'change_studentallocation'),(47,'Can delete student allocation',12,'delete_studentallocation'),(48,'Can view student allocation',12,'view_studentallocation'),(49,'Can add user_date',13,'add_user_date'),(50,'Can change user_date',13,'change_user_date'),(51,'Can delete user_date',13,'delete_user_date'),(52,'Can view user_date',13,'view_user_date'),(53,'Can add room data',14,'add_roomdata'),(54,'Can change room data',14,'change_roomdata'),(55,'Can delete room data',14,'delete_roomdata'),(56,'Can view room data',14,'view_roomdata'),(57,'Can add teacher allocation',15,'add_teacherallocation'),(58,'Can change teacher allocation',15,'change_teacherallocation'),(59,'Can delete teacher allocation',15,'delete_teacherallocation'),(60,'Can view teacher allocation',15,'view_teacherallocation');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'myapp','notification'),(14,'myapp','roomdata'),(7,'myapp','student'),(12,'myapp','studentallocation'),(10,'myapp','teacher'),(15,'myapp','teacherallocation'),(9,'myapp','test'),(13,'myapp','user_date'),(11,'myapp','users'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-11 15:41:44.439610'),(2,'auth','0001_initial','2024-03-11 15:41:44.529564'),(3,'admin','0001_initial','2024-03-11 15:41:44.553739'),(4,'admin','0002_logentry_remove_auto_add','2024-03-11 15:41:44.557172'),(5,'admin','0003_logentry_add_action_flag_choices','2024-03-11 15:41:44.560144'),(6,'contenttypes','0002_remove_content_type_name','2024-03-11 15:41:44.580114'),(7,'auth','0002_alter_permission_name_max_length','2024-03-11 15:41:44.592268'),(8,'auth','0003_alter_user_email_max_length','2024-03-11 15:41:44.600123'),(9,'auth','0004_alter_user_username_opts','2024-03-11 15:41:44.603618'),(10,'auth','0005_alter_user_last_login_null','2024-03-11 15:41:44.613568'),(11,'auth','0006_require_contenttypes_0002','2024-03-11 15:41:44.614610'),(12,'auth','0007_alter_validators_add_error_messages','2024-03-11 15:41:44.618173'),(13,'auth','0008_alter_user_username_max_length','2024-03-11 15:41:44.631953'),(14,'auth','0009_alter_user_last_name_max_length','2024-03-11 15:41:44.644832'),(15,'auth','0010_alter_group_name_max_length','2024-03-11 15:41:44.650703'),(16,'auth','0011_update_proxy_permissions','2024-03-11 15:41:44.654150'),(17,'auth','0012_alter_user_first_name_max_length','2024-03-11 15:41:44.665572'),(18,'myapp','0001_initial','2024-03-11 15:41:44.669224'),(19,'myapp','0002_student','2024-03-11 15:41:44.674992'),(20,'myapp','0003_notification','2024-03-11 15:41:44.678290'),(21,'myapp','0004_test','2024-03-11 15:41:44.681077'),(22,'myapp','0005_teacher','2024-03-11 15:41:44.685322'),(23,'myapp','0006_rename_name_user_password_remove_user_number_and_more','2024-03-11 15:41:44.692858'),(24,'myapp','0007_delete_user','2024-03-11 15:41:44.695279'),(25,'myapp','0008_users','2024-03-11 15:41:44.699319'),(26,'myapp','0009_remove_users_email_users_prn_users_type','2024-03-11 15:41:44.709247'),(27,'myapp','0010_alter_users_options','2024-03-11 15:41:44.711086'),(28,'myapp','0011_remove_notification_stud_id_notification_prn','2024-03-11 15:41:44.720155'),(29,'sessions','0001_initial','2024-03-11 15:41:44.726843'),(30,'myapp','0012_studentallocation_user_date','2024-03-19 14:34:12.092202'),(31,'myapp','0013_roomdata','2024-03-19 19:11:35.333342'),(32,'myapp','0014_teacherallocation','2024-03-20 03:38:14.936046'),(33,'myapp','0015_remove_studentallocation_seat_number_and_more','2024-03-20 05:40:34.799948');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_notification`
--

DROP TABLE IF EXISTS `myapp_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `prn` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_notification`
--

LOCK TABLES `myapp_notification` WRITE;
/*!40000 ALTER TABLE `myapp_notification` DISABLE KEYS */;
INSERT INTO `myapp_notification` VALUES (1,'Sem 3 results Out now','210021027643'),(2,'Request for duty exchange','SPK0034'),(3,'Pay Your exam fees','210021027643'),(4,'Exam postponement','210021027643'),(5,'Exam postponement','210021027657'),(6,'Request for duty exchange','SPC0041'),(7,'Pay Your fees','210021027637');
/*!40000 ALTER TABLE `myapp_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_student`
--

DROP TABLE IF EXISTS `myapp_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `prn` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `cgpa` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_student`
--

LOCK TABLES `myapp_student` WRITE;
/*!40000 ALTER TABLE `myapp_student` DISABLE KEYS */;
INSERT INTO `myapp_student` VALUES (1,'Don','12425155125','BBA',6.12),(2,'Shreya','210021027643','Maths',7.24),(3,'Abin','210021027657','chemistry',7.24),(4,'Amal','210021027635','English',6.29),(5,'Annson','210021027637','B.Com C.A',7.91);
/*!40000 ALTER TABLE `myapp_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_studentallocation`
--

DROP TABLE IF EXISTS `myapp_studentallocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_studentallocation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prn` varchar(100) NOT NULL,
  `course_code` varchar(100) NOT NULL,
  `room_name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `student_col` int NOT NULL,
  `student_row` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_studentallocation`
--

LOCK TABLES `myapp_studentallocation` WRITE;
/*!40000 ALTER TABLE `myapp_studentallocation` DISABLE KEYS */;
INSERT INTO `myapp_studentallocation` VALUES (1,'210021027643','CC1CRT09','Auditorium','2024-03-19',4,5),(2,'210021027635','CC1CRT09','Auditorium','2024-03-19',4,5),(3,'210021027657','CC1CRT09','Auditorium','2024-03-19',4,5),(4,'210021027643','FX2XRF10','G01','2024-03-25',2,1),(5,'210021027643','SS25TY09','F21','2024-03-27',2,1),(6,'210021027635','FX2XRF10','F21','2024-03-28',3,2),(7,'210021027635','CC1CRT09','Auditorium','2024-03-30',7,6),(8,'210021027657','FX2XRF10','G01','2024-03-30',1,2),(9,'210021027657','CC1CRT09','G01','2024-03-31',3,2),(10,'210021027637','FX2XRF10','G01','2024-03-30',3,1);
/*!40000 ALTER TABLE `myapp_studentallocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_teacher`
--

DROP TABLE IF EXISTS `myapp_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `prn` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_teacher`
--

LOCK TABLES `myapp_teacher` WRITE;
/*!40000 ALTER TABLE `myapp_teacher` DISABLE KEYS */;
INSERT INTO `myapp_teacher` VALUES (1,'John Doe','SPK0034','BBA'),(2,'Nikitha pinheiro','SPC0041','English');
/*!40000 ALTER TABLE `myapp_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_teacherallocation`
--

DROP TABLE IF EXISTS `myapp_teacherallocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_teacherallocation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prn` varchar(100) NOT NULL,
  `room_name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_teacherallocation`
--

LOCK TABLES `myapp_teacherallocation` WRITE;
/*!40000 ALTER TABLE `myapp_teacherallocation` DISABLE KEYS */;
INSERT INTO `myapp_teacherallocation` VALUES (1,'SPK0034','Auditorium','2024-03-19'),(2,'SPK0034','G01','2024-03-25'),(3,'SPK0034','F21','2024-03-27'),(4,'SPK0034','G01','2024-03-31'),(5,'SPC0041','G01','2024-03-30');
/*!40000 ALTER TABLE `myapp_teacherallocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_test`
--

DROP TABLE IF EXISTS `myapp_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_test` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `msg` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_test`
--

LOCK TABLES `myapp_test` WRITE;
/*!40000 ALTER TABLE `myapp_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_user_date`
--

DROP TABLE IF EXISTS `myapp_user_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_user_date` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prn` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_user_date`
--

LOCK TABLES `myapp_user_date` WRITE;
/*!40000 ALTER TABLE `myapp_user_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_user_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_users`
--

DROP TABLE IF EXISTS `myapp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(15) NOT NULL,
  `prn` varchar(25) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_users`
--

LOCK TABLES `myapp_users` WRITE;
/*!40000 ALTER TABLE `myapp_users` DISABLE KEYS */;
INSERT INTO `myapp_users` VALUES (1,'122','210021027643','student'),(2,'122','210021027635','student'),(3,'122','210021027657','student'),(4,'122','SPK0034','teacher'),(5,'122','SPC0041','teacher'),(6,'122','210021027637','student');
/*!40000 ALTER TABLE `myapp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_data`
--

DROP TABLE IF EXISTS `room_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_name` varchar(255) NOT NULL,
  `seats` int NOT NULL,
  `columns` int NOT NULL,
  `rows` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_data`
--

LOCK TABLES `room_data` WRITE;
/*!40000 ALTER TABLE `room_data` DISABLE KEYS */;
INSERT INTO `room_data` VALUES (1,'Auditorium',180,6,15),(2,'F21',60,3,10),(3,'G01',30,3,5);
/*!40000 ALTER TABLE `room_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-27  9:46:02
