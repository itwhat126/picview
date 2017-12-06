-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: picview
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1-log

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add permission',4,'add_permission'),(11,'Can change permission',4,'change_permission'),(12,'Can delete permission',4,'delete_permission'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add 大类',7,'add_highcategory'),(20,'Can change 大类',7,'change_highcategory'),(21,'Can delete 大类',7,'delete_highcategory'),(22,'Can add 评论',8,'add_comment'),(23,'Can change 评论',8,'change_comment'),(24,'Can delete 评论',8,'delete_comment'),(25,'Can add 分类',9,'add_category'),(26,'Can change 分类',9,'change_category'),(27,'Can delete 分类',9,'delete_category'),(28,'Can add 用户',10,'add_client'),(29,'Can change 用户',10,'change_client'),(30,'Can delete 用户',10,'delete_client'),(31,'Can add 图片',11,'add_uploadimg'),(32,'Can change 图片',11,'change_uploadimg'),(33,'Can delete 图片',11,'delete_uploadimg'),(34,'Can add 相册',12,'add_gallery'),(35,'Can change 相册',12,'change_gallery'),(36,'Can delete 相册',12,'delete_gallery');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$dZk1pJK1zri6$wVJQ31Q+uyyc3UxB2pw1SP6PdFwVBo4ktIlp6W293z8=','2017-12-05 11:29:58.366796',1,'admin','魏','亚光','itwhat@126.com',1,1,'2017-12-03 15:46:00.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-12-03 15:47:01.383134','1','admin',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"last_login\"]}}]',3,1),(2,'2017-12-03 15:47:34.562217','1','主题分类',1,'[{\"added\": {}}]',7,1),(3,'2017-12-03 15:48:45.872060','1','主题分类 - 清新植物',1,'[{\"added\": {}}]',9,1),(4,'2017-12-03 15:48:54.924705','2','主题分类 - 可爱萌宠',1,'[{\"added\": {}}]',9,1),(5,'2017-12-03 15:51:41.346933','2','尺寸分类',1,'[{\"added\": {}}]',7,1),(6,'2017-12-03 15:51:51.723822','3','尺寸分类 - 1920×1200',1,'[{\"added\": {}}]',9,1),(7,'2017-12-03 15:51:58.081675','1','绿色青苔',1,'[{\"added\": {}}]',12,1),(8,'2017-12-03 15:52:11.831260','1','pics/2017/12/1920x1200_qingtai.jpg',1,'[{\"added\": {}}]',11,1),(9,'2017-12-03 15:52:30.318292','2','pics/2017/12/1920x1200_qingtai-001.jpg',1,'[{\"added\": {}}]',11,1),(10,'2017-12-03 15:53:02.026145','3','pics/2017/12/1920x1200_qingtai-002.jpg',1,'[{\"added\": {}}]',11,1),(11,'2017-12-03 15:53:18.968245','4','pics/2017/12/1920x1200_qingtai-003.jpg',1,'[{\"added\": {}}]',11,1),(12,'2017-12-03 15:53:55.775558','5','pics/2017/12/1920x1200_qingtai-004.jpg',1,'[{\"added\": {}}]',11,1),(13,'2017-12-03 15:54:09.716861','6','pics/2017/12/1920x1200_qingtai-005.jpg',1,'[{\"added\": {}}]',11,1),(14,'2017-12-03 15:54:25.307165','7','pics/2017/12/1920x1200_qingtai-006.jpg',1,'[{\"added\": {}}]',11,1),(15,'2017-12-03 15:54:40.135774','8','pics/2017/12/1920x1200_qingtai-007.jpg',1,'[{\"added\": {}}]',11,1),(16,'2017-12-03 15:54:53.571110','9','pics/2017/12/1920x1200_qingtai-008.jpg',1,'[{\"added\": {}}]',11,1),(17,'2017-12-03 15:55:06.761740','10','pics/2017/12/1920x1200_qingtai-009.jpg',1,'[{\"added\": {}}]',11,1),(18,'2017-12-03 15:55:19.930662','11','pics/2017/12/1920x1200_qingtai-011.jpg',1,'[{\"added\": {}}]',11,1),(19,'2017-12-03 15:55:33.041047','11','pics/2017/12/1920x1200_qingtai-010.jpg',2,'[{\"changed\": {\"fields\": [\"file\"]}}]',11,1),(20,'2017-12-03 15:55:49.486299','12','pics/2017/12/1920x1200_qingtai-011_aHqXLyi.jpg',1,'[{\"added\": {}}]',11,1),(21,'2017-12-03 15:56:19.715632','13','pics/2017/12/1920x1200_qingtai-012.jpg',1,'[{\"added\": {}}]',11,1),(22,'2017-12-03 15:56:35.921260','14','pics/2017/12/1920x1200_qingtai-013.jpg',1,'[{\"added\": {}}]',11,1),(23,'2017-12-03 15:56:51.729074','15','pics/2017/12/1920x1200_qingtai-014.jpg',1,'[{\"added\": {}}]',11,1),(24,'2017-12-03 15:57:06.640717','16','pics/2017/12/1920x1200_qingtai-015.jpg',1,'[{\"added\": {}}]',11,1),(25,'2017-12-03 16:48:16.278739','3','风格分类',1,'[{\"added\": {}}]',7,1),(26,'2017-12-03 16:48:49.029052','3','风格分类',2,'[{\"changed\": {\"fields\": [\"order_by\"]}}]',7,1),(27,'2017-12-03 16:48:58.568347','2','尺寸分类',2,'[{\"changed\": {\"fields\": [\"order_by\"]}}]',7,1),(28,'2017-12-03 16:49:23.828772','4','风格分类 - 安静',1,'[{\"added\": {}}]',9,1),(29,'2017-12-03 16:49:40.112101','5','风格分类 - 狂野',1,'[{\"added\": {}}]',9,1),(30,'2017-12-03 16:50:00.615479','6','风格分类 - 性感',1,'[{\"added\": {}}]',9,1),(31,'2017-12-03 16:50:08.304875','7','风格分类 - 清新',1,'[{\"added\": {}}]',9,1),(32,'2017-12-03 16:50:14.781181','8','风格分类 - 二次元',1,'[{\"added\": {}}]',9,1),(33,'2017-12-03 16:50:30.586939','9','风格分类 - 文艺',1,'[{\"added\": {}}]',9,1),(34,'2017-12-03 16:50:36.832721','10','风格分类 - 复古',1,'[{\"added\": {}}]',9,1),(35,'2017-12-03 16:52:21.263544','1','绿色青苔',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',12,1),(36,'2017-12-03 17:20:42.144271','1','绿色青苔',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',12,1),(37,'2017-12-04 03:03:08.977830','2','清新嫩芽一',1,'[{\"added\": {}}]',12,1),(38,'2017-12-04 03:03:13.480993','17','pics/2017/12/1920x1200_nenya.jpg',1,'[{\"added\": {}}]',11,1),(39,'2017-12-04 03:03:34.838189','18','pics/2017/12/1920x1200_nenya-001.jpg',1,'[{\"added\": {}}]',11,1),(40,'2017-12-04 03:03:47.462540','19','pics/2017/12/1920x1200_nenya-002.jpg',1,'[{\"added\": {}}]',11,1),(41,'2017-12-04 03:04:02.135718','20','pics/2017/12/1920x1200_nenya-003.jpg',1,'[{\"added\": {}}]',11,1),(42,'2017-12-04 03:04:16.978935','21','pics/2017/12/1920x1200_nenya-005.jpg',1,'[{\"added\": {}}]',11,1),(43,'2017-12-04 03:04:44.522998','22','pics/2017/12/1920x1200_nenya-006.jpg',1,'[{\"added\": {}}]',11,1),(44,'2017-12-04 03:05:00.593815','23','pics/2017/12/1920x1200_nenya-007.jpg',1,'[{\"added\": {}}]',11,1),(45,'2017-12-04 03:05:13.590705','24','pics/2017/12/1920x1200_nenya-008.jpg',1,'[{\"added\": {}}]',11,1),(46,'2017-12-04 03:05:26.544899','25','pics/2017/12/1920x1200_nenya-009.jpg',1,'[{\"added\": {}}]',11,1),(47,'2017-12-04 03:05:42.206597','26','pics/2017/12/1920x1200_nenya-010.jpg',1,'[{\"added\": {}}]',11,1),(48,'2017-12-04 03:05:55.133244','27','pics/2017/12/1920x1200_nenya-011.jpg',1,'[{\"added\": {}}]',11,1),(49,'2017-12-04 03:06:09.045507','28','pics/2017/12/1920x1200_nenya-012.jpg',1,'[{\"added\": {}}]',11,1),(50,'2017-12-04 03:06:21.529648','29','pics/2017/12/1920x1200_nenya-013.jpg',1,'[{\"added\": {}}]',11,1),(51,'2017-12-04 03:06:39.502503','30','pics/2017/12/1920x1200_nenya-014.jpg',1,'[{\"added\": {}}]',11,1),(52,'2017-12-04 03:07:15.942994','31','pics/2017/12/1920x1200_nenya-015.jpg',1,'[{\"added\": {}}]',11,1),(53,'2017-12-04 03:07:28.670550','32','pics/2017/12/1920x1200_nenya-016.jpg',1,'[{\"added\": {}}]',11,1),(54,'2017-12-04 03:07:49.521680','33','pics/2017/12/1920x1200_nenya-017.jpg',1,'[{\"added\": {}}]',11,1),(55,'2017-12-04 03:08:01.838797','34','pics/2017/12/1920x1200_nenya-018.jpg',1,'[{\"added\": {}}]',11,1),(56,'2017-12-04 03:08:13.020275','35','pics/2017/12/1920x1200_nenya-019.jpg',1,'[{\"added\": {}}]',11,1),(57,'2017-12-04 03:08:25.963632','36','pics/2017/12/1920x1200_nenya-020.jpg',1,'[{\"added\": {}}]',11,1),(58,'2017-12-04 03:08:37.998516','37','pics/2017/12/1920x1200_nenya-021.jpg',1,'[{\"added\": {}}]',11,1),(59,'2017-12-04 03:08:50.766005','38','pics/2017/12/1920x1200_nenya-022.jpg',1,'[{\"added\": {}}]',11,1),(60,'2017-12-04 03:09:06.898451','39','pics/2017/12/1920x1200_nenya-023.jpg',1,'[{\"added\": {}}]',11,1),(61,'2017-12-04 03:09:20.514012','40','pics/2017/12/1920x1200_nenya-024.jpg',1,'[{\"added\": {}}]',11,1),(62,'2017-12-04 03:09:33.621106','41','pics/2017/12/1920x1200_nenya-026.jpg',1,'[{\"added\": {}}]',11,1),(63,'2017-12-04 03:09:48.111227','42','pics/2017/12/1920x1200_nenya-027.jpg',1,'[{\"added\": {}}]',11,1),(64,'2017-12-04 03:10:03.981252','43','pics/2017/12/1920x1200_nenya-028.jpg',1,'[{\"added\": {}}]',11,1),(65,'2017-12-04 03:10:17.800869','44','pics/2017/12/1920x1200_nenya-029.jpg',1,'[{\"added\": {}}]',11,1),(66,'2017-12-04 03:10:40.516910','41','pics/2017/12/1920x1200_nenya-025.jpg',2,'[{\"changed\": {\"fields\": [\"file\"]}}]',11,1),(67,'2017-12-04 03:11:11.910446','45','pics/2017/12/1920x1200_nenya-026_tSwRz1v.jpg',1,'[{\"added\": {}}]',11,1),(68,'2017-12-04 03:14:23.005095','1','绿色青苔',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',12,1),(69,'2017-12-04 12:57:57.193515','1','绿色青苔',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',12,1),(70,'2017-12-05 01:47:53.311631','1','绿色青苔',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',12,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(4,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(9,'gallery','category'),(10,'gallery','client'),(8,'gallery','comment'),(12,'gallery','gallery'),(7,'gallery','highcategory'),(11,'gallery','uploadimg'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-12-03 13:55:47.812039'),(2,'auth','0001_initial','2017-12-03 13:55:48.111071'),(3,'admin','0001_initial','2017-12-03 13:55:48.179956'),(4,'admin','0002_logentry_remove_auto_add','2017-12-03 13:55:48.196526'),(5,'contenttypes','0002_remove_content_type_name','2017-12-03 13:55:48.249426'),(6,'auth','0002_alter_permission_name_max_length','2017-12-03 13:55:48.275683'),(7,'auth','0003_alter_user_email_max_length','2017-12-03 13:55:48.322077'),(8,'auth','0004_alter_user_username_opts','2017-12-03 13:55:48.333494'),(9,'auth','0005_alter_user_last_login_null','2017-12-03 13:55:48.374018'),(10,'auth','0006_require_contenttypes_0002','2017-12-03 13:55:48.377350'),(11,'auth','0007_alter_validators_add_error_messages','2017-12-03 13:55:48.393911'),(12,'auth','0008_alter_user_username_max_length','2017-12-03 13:55:48.438431'),(13,'gallery','0001_initial','2017-12-03 13:55:48.802351'),(14,'sessions','0001_initial','2017-12-03 13:55:48.828164');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1z3552ogkycw4ijlzsmbfa59l7520hez','YTAxYTZkZmViYjNjYTU2NmQ3MjhiMjg0ODM0YjBkMTllZjkxN2VlOTp7InVzZXJuYW1lIjoidGVzdDAxIiwiaXNsb2dpbiI6dHJ1ZX0=','2017-12-17 14:27:57.093490'),('2opkf649zffi32kq502lvyllwirnccbs','YjliMGIxZTZmYjdjNzFjNThhNGVlMzAxYzA4MDAyNzExZGNlOTI1Yjp7InZlcmlmeWNvZGUiOiJGTU9aIn0=','2017-12-19 09:58:41.965578'),('3fkl8ytwovgyn2o6o9t8x4iafixnhljh','MGU2MjdiMjc1ZDZlYTg4OWEzZGQyZTJlMDRiN2FjZGRlZmRlNGRlNDp7InZlcmlmeWNvZGUiOiJQV0tLIn0=','2017-12-19 08:28:37.816048'),('4ae238kvjk2qx5g9djhfav9odh2egsi2','YTAxYTZkZmViYjNjYTU2NmQ3MjhiMjg0ODM0YjBkMTllZjkxN2VlOTp7InVzZXJuYW1lIjoidGVzdDAxIiwiaXNsb2dpbiI6dHJ1ZX0=','2017-12-17 14:30:17.697215'),('94o8yv40xz33xphqjwwd7z8croyw3bh3','YjJkOTA1NjA3YzJlNDQ1ZjY2ZTc0NGQ4ZDQyZmM5YTk1YTM5N2E5Yzp7ImlzbG9naW4iOnRydWUsInVzZXJuYW1lIjoidGVzdDAxIn0=','2017-12-17 14:21:55.667991'),('97u9mlwhanxs0wwxlpmm3c27r0wui95s','NmFjYzEwYTU5MzZkMmM2MmQ0MWM2YjVjN2VmM2ZiNGZjZjZjZDI1NTp7InZlcmlmeWNvZGUiOiJDVDJIIn0=','2017-12-20 02:17:51.429435'),('9jw07kfspuz1d266vehetekvd1lz3sbp','YTAxYTZkZmViYjNjYTU2NmQ3MjhiMjg0ODM0YjBkMTllZjkxN2VlOTp7InVzZXJuYW1lIjoidGVzdDAxIiwiaXNsb2dpbiI6dHJ1ZX0=','2017-12-17 14:29:49.217188'),('em6vbur1x3biyfss11mcg72ghvvjak19','YTAxYTZkZmViYjNjYTU2NmQ3MjhiMjg0ODM0YjBkMTllZjkxN2VlOTp7InVzZXJuYW1lIjoidGVzdDAxIiwiaXNsb2dpbiI6dHJ1ZX0=','2017-12-17 14:28:23.562576'),('iv9plkd0umh185h213hwmb8tm89eh1pu','MWFmMTM4ZGNiNjU2YWUxZjY1MWI5YjhhN2FjZjJlYzcwMzc2NjlhOTp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmN2Y2NjU1NjZiMjUyNmFhMWYyZGEwNTNkMzYwNzVkYTg5MjM4MzkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-12-17 16:48:00.366529'),('kpkkhuo4axf1b329x609q5cw78lt494t','YjJkOTA1NjA3YzJlNDQ1ZjY2ZTc0NGQ4ZDQyZmM5YTk1YTM5N2E5Yzp7ImlzbG9naW4iOnRydWUsInVzZXJuYW1lIjoidGVzdDAxIn0=','2017-12-17 14:34:36.946476'),('kv95q60ec9bbmv8xszf2ogf6z77rovex','OTJiYzNhNGY2NzEwMGFkMDU3MjAyN2Q5MzE0MWZhYWQ0ZWI1MDEzZDp7InZlcmlmeWNvZGUiOiJMTDMzIn0=','2017-12-19 11:15:09.521519'),('p8q4vdfm4kj7ufso07i529g5uzu4kkb9','ZTdjNzJiNjNiZWZiZGU0ZTU0Y2Q4YjIxOWQ0OGUwNTRiOWE5NzUyYjp7InZlcmlmeWNvZGUiOiJIMDgyIn0=','2017-12-19 10:00:43.769000'),('vjcvlhrabwi6tv0yp67abaspt6nxk661','MTZmNzIzNGZmYjQ1YjE2YjBmOGMwYjAxZDUyZDQyNDU0ZTNjYjM5MTp7InZlcmlmeWNvZGUiOiI3Q0lYIn0=','2017-12-20 02:27:30.800183'),('x28v80d91o3pcnc0b16r9o8sa3n1kc2j','OGQ5N2QxYmU3YzY2MjJjNjQ1ZmZkNGViOTMyZTA0Yjc4OGUzYWI0MDp7InZlcmlmeWNvZGUiOiJHUEVVIn0=','2017-12-19 11:17:44.809770'),('yyr45dpo7i9la3l4w43kx373ss6c2mvd','MzMyZThmYjc2MzExMGQ0ODRiMzRmMjQwODAyYWMyNjc3ZGM0N2MyZTp7InZlcmlmeWNvZGUiOiJOVlhPIn0=','2017-12-19 10:57:19.088750');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_category`
--

DROP TABLE IF EXISTS `gallery_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `order_by` int(11) NOT NULL,
  `high_cate_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `gallery_category_high_cate_id_3ec7f03b_fk_gallery_h` (`high_cate_id`),
  CONSTRAINT `gallery_category_high_cate_id_3ec7f03b_fk_gallery_h` FOREIGN KEY (`high_cate_id`) REFERENCES `gallery_highcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_category`
--

LOCK TABLES `gallery_category` WRITE;
/*!40000 ALTER TABLE `gallery_category` DISABLE KEYS */;
INSERT INTO `gallery_category` VALUES (1,'清新植物',0,1),(2,'可爱萌宠',0,1),(3,'1920×1200',0,2),(4,'安静',0,3),(5,'狂野',0,3),(6,'性感',0,3),(7,'清新',0,3),(8,'二次元',0,3),(9,'文艺',0,3),(10,'复古',0,3);
/*!40000 ALTER TABLE `gallery_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_client`
--

DROP TABLE IF EXISTS `gallery_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `salt` varchar(29) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_client`
--

LOCK TABLES `gallery_client` WRITE;
/*!40000 ALTER TABLE `gallery_client` DISABLE KEYS */;
INSERT INTO `gallery_client` VALUES (1,'test01','88888888','13264000066','$2b$10$m42NDEWMuj9AGJBSkJPtuO',0),(2,'test02','$2b$10$L4Z2q7zsWXI9llh30whZHugeExMNPQ1b/YgVazjVfhIL3DqTDWqyO','13264000066','$2b$10$L4Z2q7zsWXI9llh30whZHu',0),(3,'test03','$2b$10$PkBgq4xe5nAGIdcNQDvcuu/Q/OdKdTFUPe95ikRRabI4niPmtg8HG','13264000066','$2b$10$PkBgq4xe5nAGIdcNQDvcuu',0),(4,'test04','$2b$10$OMTwJG0PGxXeUoDSU4j3C.ofZU0FVtfUtqaginUS2huBzuAPxl8Ba','13264000066','$2b$10$OMTwJG0PGxXeUoDSU4j3C.',0),(6,'test05','$2b$10$4ywte17AtF2.e0RGlK/6KOusK7gk0pTAg0WnQWF8tGj.XYLG1oj32','13264000066','$2b$10$4ywte17AtF2.e0RGlK/6KO',0),(7,'test06','$2b$10$Yl2WgKezqfy9QnLcjdvBje38orFuL5q1eQ83rWbrO6iro1I9yrhN6','13264000066','$2b$10$Yl2WgKezqfy9QnLcjdvBje',0),(8,'test07','$2b$10$NaIP.SuSxNo0NvHOwMPque0boC.j5lnZN5g3xSDz2YodTKi53aoIq','13264000066','$2b$10$NaIP.SuSxNo0NvHOwMPque',0),(9,'test08','$2b$10$Sw7PqN7hSFVb1v4/1k1haO9D1plAfe62gJcFvLOeSYsW5I8mYwNre','13264000066','$2b$10$Sw7PqN7hSFVb1v4/1k1haO',0),(10,'test09','$2b$10$ZRS0N1NAuG8cQnp8aQHoc.e0bs.83dvxEH0U/Xi0BWj6PcEB24zFG','13264000066','$2b$10$ZRS0N1NAuG8cQnp8aQHoc.',0),(11,'test10','$2b$10$yNU0VvwvPg5A2EdysnSAnexZ8wOFiQeSIs3uYZOcVaoFu1MMXAeDi','13264000066','$2b$10$yNU0VvwvPg5A2EdysnSAne',0),(12,'test11','$2b$10$D5kGMhyxIUtKP5E5fyLwROCeCeWIe4jI8HvJ.GTO4.onMR7nTlX7a','13264000066','$2b$10$D5kGMhyxIUtKP5E5fyLwRO',0),(13,'test12','$2b$10$rGR4JtQk6KZajTOa2lhQ0eMXZ1cPbaE.LYwEyoD81cZ.tEhOZUige','13264000066','$2b$10$rGR4JtQk6KZajTOa2lhQ0e',0),(14,'test13','$2b$10$zTFgE6lw6/0VCaJe7WPv8uc1.NcnmqwvtcGVhS3fy4YR8ANJz/14m','13264000066','$2b$10$zTFgE6lw6/0VCaJe7WPv8u',0),(15,'test14','$2b$10$WdRYUEBA7mgmnmu0yqTp3eGkWZDxuU1NcDaVnMBANs1ommdRw/1qi','13264000066','$2b$10$WdRYUEBA7mgmnmu0yqTp3e',0);
/*!40000 ALTER TABLE `gallery_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_comment`
--

DROP TABLE IF EXISTS `gallery_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `modify_at` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  `gallery_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gallery_comment_author_id_aeaf39d7_fk_gallery_client_id` (`author_id`),
  KEY `gallery_comment_gallery_id_0aa1f131_fk_gallery_gallery_id` (`gallery_id`),
  CONSTRAINT `gallery_comment_author_id_aeaf39d7_fk_gallery_client_id` FOREIGN KEY (`author_id`) REFERENCES `gallery_client` (`id`),
  CONSTRAINT `gallery_comment_gallery_id_0aa1f131_fk_gallery_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery_gallery` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_comment`
--

LOCK TABLES `gallery_comment` WRITE;
/*!40000 ALTER TABLE `gallery_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_gallery`
--

DROP TABLE IF EXISTS `gallery_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `order_by` int(11) NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `modify_at` datetime(6) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gallery_gallery_owner_id_6b88c5ee_fk_auth_user_id` (`owner_id`),
  CONSTRAINT `gallery_gallery_owner_id_6b88c5ee_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_gallery`
--

LOCK TABLES `gallery_gallery` WRITE;
/*!40000 ALTER TABLE `gallery_gallery` DISABLE KEYS */;
INSERT INTO `gallery_gallery` VALUES (1,'绿色青苔',0,'2017-12-03 15:51:58.049390','2017-12-05 01:47:53.290809',1),(2,'清新嫩芽一',0,'2017-12-04 03:03:08.930614','2017-12-04 03:03:08.930673',1);
/*!40000 ALTER TABLE `gallery_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_gallery_category`
--

DROP TABLE IF EXISTS `gallery_gallery_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_gallery_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gallery_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gallery_gallery_category_gallery_id_category_id_97bd1e80_uniq` (`gallery_id`,`category_id`),
  KEY `gallery_gallery_cate_category_id_090c6b5a_fk_gallery_c` (`category_id`),
  CONSTRAINT `gallery_gallery_cate_category_id_090c6b5a_fk_gallery_c` FOREIGN KEY (`category_id`) REFERENCES `gallery_category` (`id`),
  CONSTRAINT `gallery_gallery_cate_gallery_id_5533916e_fk_gallery_g` FOREIGN KEY (`gallery_id`) REFERENCES `gallery_gallery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_gallery_category`
--

LOCK TABLES `gallery_gallery_category` WRITE;
/*!40000 ALTER TABLE `gallery_gallery_category` DISABLE KEYS */;
INSERT INTO `gallery_gallery_category` VALUES (1,1,1),(7,1,2),(8,1,3),(4,2,1);
/*!40000 ALTER TABLE `gallery_gallery_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_highcategory`
--

DROP TABLE IF EXISTS `gallery_highcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_highcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `order_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_highcategory`
--

LOCK TABLES `gallery_highcategory` WRITE;
/*!40000 ALTER TABLE `gallery_highcategory` DISABLE KEYS */;
INSERT INTO `gallery_highcategory` VALUES (1,'主题分类',0),(2,'尺寸分类',2),(3,'风格分类',1);
/*!40000 ALTER TABLE `gallery_highcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_uploadimg`
--

DROP TABLE IF EXISTS `gallery_uploadimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_uploadimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) DEFAULT NULL,
  `ext` varchar(32) DEFAULT NULL,
  `md5` varchar(32) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `order_by` int(11) NOT NULL,
  `is_cover` tinyint(1) NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `modify_at` datetime(6) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gallery_uploadimg_gallery_id_c1724fed_fk_gallery_gallery_id` (`gallery_id`),
  KEY `gallery_uploadimg_owner_id_0137ac2c_fk_auth_user_id` (`owner_id`),
  CONSTRAINT `gallery_uploadimg_gallery_id_c1724fed_fk_gallery_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery_gallery` (`id`),
  CONSTRAINT `gallery_uploadimg_owner_id_0137ac2c_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_uploadimg`
--

LOCK TABLES `gallery_uploadimg` WRITE;
/*!40000 ALTER TABLE `gallery_uploadimg` DISABLE KEYS */;
INSERT INTO `gallery_uploadimg` VALUES (1,'绿色青苔0','jpg','8bd3e530c8cb3f0d6ed538cc2d14d8b7',511608,'pics/2017/12/1920x1200_qingtai.jpg',0,0,'2017-12-03 15:52:11.826744','2017-12-03 15:52:11.826799',1,1),(2,'绿色青苔01','jpg','4e7c263a2912f0bba93e268cc506a1d7',419822,'pics/2017/12/1920x1200_qingtai-001.jpg',0,0,'2017-12-03 15:52:30.313192','2017-12-03 15:52:30.313241',1,1),(3,'绿色青苔02','jpg','e00936e6d89784136d49ea7536a25188',1096304,'pics/2017/12/1920x1200_qingtai-002.jpg',0,0,'2017-12-03 15:53:02.020234','2017-12-03 15:53:02.020517',1,1),(4,'绿色青苔03','jpg','ff56cdd9ed2a186d839af0ca3d3f0c83',635999,'pics/2017/12/1920x1200_qingtai-003.jpg',0,0,'2017-12-03 15:53:18.964729','2017-12-03 15:53:18.964778',1,1),(5,'绿色青苔04','jpg','c56ef5bff809621210e9624da32778ce',644198,'pics/2017/12/1920x1200_qingtai-004.jpg',0,1,'2017-12-03 15:53:55.768894','2017-12-03 15:53:55.768945',1,1),(6,'绿色青苔05','jpg','9f1ead24ba69fbc3de6cec8caa10ad7b',702666,'pics/2017/12/1920x1200_qingtai-005.jpg',0,0,'2017-12-03 15:54:09.713026','2017-12-03 15:54:09.713119',1,1),(7,'绿色青苔06','jpg','649fea6494555ebac72263f51f6c9a3b',467965,'pics/2017/12/1920x1200_qingtai-006.jpg',0,0,'2017-12-03 15:54:25.302685','2017-12-03 15:54:25.302802',1,1),(8,'绿色青苔07','jpg','174f51154ff6223a7a18be71484bb357',522162,'pics/2017/12/1920x1200_qingtai-007.jpg',0,0,'2017-12-03 15:54:40.130067','2017-12-03 15:54:40.130122',1,1),(9,'绿色青苔08','jpg','a4bfb8e24c779276ed85ba981f0df6bd',415249,'pics/2017/12/1920x1200_qingtai-008.jpg',0,0,'2017-12-03 15:54:53.568800','2017-12-03 15:54:53.568856',1,1),(10,'绿色青苔09','jpg','f46dacf1c08c9f4131778d159da4dee5',738852,'pics/2017/12/1920x1200_qingtai-009.jpg',0,0,'2017-12-03 15:55:06.760169','2017-12-03 15:55:06.760224',1,1),(11,'绿色青苔10','jpg','181e9a2c40266862c697f5cd4a452f6e',1296795,'pics/2017/12/1920x1200_qingtai-010.jpg',0,0,'2017-12-03 15:55:19.926979','2017-12-03 15:55:33.036802',1,1),(12,'绿色青苔11','jpg','fbd388b9ae0bcb5d403bb9954dbf496a',576753,'pics/2017/12/1920x1200_qingtai-011_aHqXLyi.jpg',0,0,'2017-12-03 15:55:49.484414','2017-12-03 15:55:49.484532',1,1),(13,'绿色青苔12','jpg','fba61422a31dc3ce976bfc13c4ba4f01',880072,'pics/2017/12/1920x1200_qingtai-012.jpg',0,0,'2017-12-03 15:56:19.714004','2017-12-03 15:56:19.714059',1,1),(14,'绿色青苔13','jpg','b73dafda57ebcddae44c0b7ec87dc635',533369,'pics/2017/12/1920x1200_qingtai-013.jpg',0,0,'2017-12-03 15:56:35.917059','2017-12-03 15:56:35.917112',1,1),(15,'绿色青苔14','jpg','9c16669264062c868ce12029b173e4a2',1001335,'pics/2017/12/1920x1200_qingtai-014.jpg',0,0,'2017-12-03 15:56:51.727599','2017-12-03 15:56:51.727654',1,1),(16,'绿色青苔15','jpg','e9ebc69eec0aab9b2175787bf2d3cb4a',483157,'pics/2017/12/1920x1200_qingtai-015.jpg',0,0,'2017-12-03 15:57:06.637736','2017-12-03 15:57:06.637827',1,1),(17,'清新嫩芽0','jpg','a9eb42f49dfbc8df6b93a4cfb5c3209e',991757,'pics/2017/12/1920x1200_nenya.jpg',0,0,'2017-12-04 03:03:13.476282','2017-12-04 03:03:13.476348',2,1),(18,'清新嫩芽01','jpg','e319ea3d9f9c92d851ddac55731d2e8f',1750838,'pics/2017/12/1920x1200_nenya-001.jpg',0,0,'2017-12-04 03:03:34.832526','2017-12-04 03:03:34.832801',2,1),(19,'清新嫩芽02','jpg','2b102aee15475a9b86c1e01b8dffa79f',1383097,'pics/2017/12/1920x1200_nenya-002.jpg',0,0,'2017-12-04 03:03:47.453639','2017-12-04 03:03:47.453695',2,1),(20,'清新嫩芽03','jpg','4e24b9028760647dbf41060032bee2ca',866387,'pics/2017/12/1920x1200_nenya-003.jpg',0,0,'2017-12-04 03:04:02.133419','2017-12-04 03:04:02.133489',2,1),(21,'清新嫩芽04','jpg','366c1d3758dd2570df3ca01924786758',1162537,'pics/2017/12/1920x1200_nenya-005.jpg',0,0,'2017-12-04 03:04:16.969323','2017-12-04 03:04:16.969557',2,1),(22,'清新嫩芽06','jpg','9dc340771a380aa1dd30d2fad70eeea1',1189049,'pics/2017/12/1920x1200_nenya-006.jpg',0,0,'2017-12-04 03:04:44.520035','2017-12-04 03:04:44.520095',2,1),(23,'清新嫩芽07','jpg','1650d65adf22e5187d0725373decff79',793761,'pics/2017/12/1920x1200_nenya-007.jpg',0,1,'2017-12-04 03:05:00.582236','2017-12-04 03:05:00.582296',2,1),(24,'清新嫩芽08','jpg','4accdc14fb9ffe740ad4260b82d37b75',1084934,'pics/2017/12/1920x1200_nenya-008.jpg',0,0,'2017-12-04 03:05:13.587140','2017-12-04 03:05:13.587202',2,1),(25,'清新嫩芽09','jpg','299d22f4b2092605b71a1ed787d97f2a',1187370,'pics/2017/12/1920x1200_nenya-009.jpg',0,0,'2017-12-04 03:05:26.537461','2017-12-04 03:05:26.537818',2,1),(26,'清新嫩芽10','jpg','ba50ca7b14d3e46af3280213a84e786d',1234138,'pics/2017/12/1920x1200_nenya-010.jpg',0,0,'2017-12-04 03:05:42.204344','2017-12-04 03:05:42.204485',2,1),(27,'清新嫩芽11','jpg','4fa1167a4bff3742df93d5964a1dff66',1341123,'pics/2017/12/1920x1200_nenya-011.jpg',0,0,'2017-12-04 03:05:55.129169','2017-12-04 03:05:55.129409',2,1),(28,'清新嫩芽12','jpg','15e80f4e60ea2e291859c2a8bf173de5',1050638,'pics/2017/12/1920x1200_nenya-012.jpg',0,0,'2017-12-04 03:06:09.039788','2017-12-04 03:06:09.040091',2,1),(29,'清新嫩芽13','jpg','433509fcb55706ef2b988940b8a3db74',936481,'pics/2017/12/1920x1200_nenya-013.jpg',0,0,'2017-12-04 03:06:21.525006','2017-12-04 03:06:21.525096',2,1),(30,'清新嫩芽14','jpg','75930e7f21b692c782f35baec9e159fd',1223778,'pics/2017/12/1920x1200_nenya-014.jpg',0,0,'2017-12-04 03:06:39.500301','2017-12-04 03:06:39.500472',2,1),(31,'清新嫩芽15','jpg','b6a4d7d940ceaf02023e1ddc86d6f4fd',862083,'pics/2017/12/1920x1200_nenya-015.jpg',0,0,'2017-12-04 03:07:15.938953','2017-12-04 03:07:15.939005',2,1),(32,'清新嫩芽16','jpg','3928e05c28cad45efbdd862a67092dc0',1178884,'pics/2017/12/1920x1200_nenya-016.jpg',0,0,'2017-12-04 03:07:28.667205','2017-12-04 03:07:28.667257',2,1),(33,'清新嫩芽17','jpg','8e410ddefb88afd627eacf5dd0b6ded2',1003751,'pics/2017/12/1920x1200_nenya-017.jpg',0,0,'2017-12-04 03:07:49.513362','2017-12-04 03:07:49.513527',2,1),(34,'清新嫩芽18','jpg','8c545e6cae9ee06fa109368bc9b6edf1',1064901,'pics/2017/12/1920x1200_nenya-018.jpg',0,0,'2017-12-04 03:08:01.833550','2017-12-04 03:08:01.833624',2,1),(35,'清新嫩芽19','jpg','7e5a30d989de259a256be68dd8f40821',856248,'pics/2017/12/1920x1200_nenya-019.jpg',0,0,'2017-12-04 03:08:13.018676','2017-12-04 03:08:13.018738',2,1),(36,'清新嫩芽20','jpg','1c955eb4006d45768c0bafbd7af1138c',1047812,'pics/2017/12/1920x1200_nenya-020.jpg',0,0,'2017-12-04 03:08:25.961429','2017-12-04 03:08:25.961479',2,1),(37,'清新嫩芽21','jpg','4d1dff17de49b7c8a90e9153eeb95122',1691598,'pics/2017/12/1920x1200_nenya-021.jpg',0,0,'2017-12-04 03:08:37.993835','2017-12-04 03:08:37.993896',2,1),(38,'清新嫩芽22','jpg','f3a6293ac3bd9d5868b53f493c4dd159',922414,'pics/2017/12/1920x1200_nenya-022.jpg',0,0,'2017-12-04 03:08:50.761040','2017-12-04 03:08:50.761359',2,1),(39,'清新嫩芽23','jpg','d1c3e9962762fddc2dcf83240151a02a',1246711,'pics/2017/12/1920x1200_nenya-023.jpg',0,0,'2017-12-04 03:09:06.889715','2017-12-04 03:09:06.889787',2,1),(40,'清新嫩芽24','jpg','894a8a62995b9716643ff84ce122a069',858052,'pics/2017/12/1920x1200_nenya-024.jpg',0,0,'2017-12-04 03:09:20.511289','2017-12-04 03:09:20.511362',2,1),(41,'清新嫩芽25','jpg','a8e084d8702e47ed2a6288c02b62fef8',849874,'pics/2017/12/1920x1200_nenya-025.jpg',0,0,'2017-12-04 03:09:33.619772','2017-12-04 03:10:40.504146',2,1),(42,'清新嫩芽27','jpg','187c0e100af6785c70cbb6b743683ce4',955408,'pics/2017/12/1920x1200_nenya-027.jpg',0,0,'2017-12-04 03:09:48.109672','2017-12-04 03:09:48.109730',2,1),(43,'清新嫩芽28','jpg','d1d45c4193944824f70abf3f39ddda59',766244,'pics/2017/12/1920x1200_nenya-028.jpg',0,0,'2017-12-04 03:10:03.978590','2017-12-04 03:10:03.978647',2,1),(44,'清新嫩芽29','jpg','39eb842befef15a419085da409d510a2',1323893,'pics/2017/12/1920x1200_nenya-029.jpg',0,0,'2017-12-04 03:10:17.796949','2017-12-04 03:10:17.797060',2,1),(45,'清新嫩芽26','jpg','b313b5929aae6bfd3b84833df0bcc494',974856,'pics/2017/12/1920x1200_nenya-026_tSwRz1v.jpg',0,0,'2017-12-04 03:11:11.904012','2017-12-04 03:11:11.904066',2,1);
/*!40000 ALTER TABLE `gallery_uploadimg` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-06 11:25:37
