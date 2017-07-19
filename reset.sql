-- MySQL dump 10.13  Distrib 5.7.18, for osx10.12 (x86_64)
--
-- Host: localhost    Database: cacc-crm_develop
-- ------------------------------------------------------
-- Server version	5.7.18

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `kind` int(11) DEFAULT NULL,
  `om` varchar(255) DEFAULT NULL,
  `fd1` varchar(255) DEFAULT NULL,
  `fd2` varchar(255) DEFAULT NULL,
  `rc` varchar(255) DEFAULT NULL,
  `referrer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Account 1','303-763-0001',NULL,NULL,NULL,'401 Jackson St','Golden',NULL,'80403',400,NULL,NULL,NULL,NULL,NULL),(2,'Account 2','303-763-0002',NULL,NULL,NULL,'402 Jackson St','Golden',NULL,'80403',400,NULL,NULL,NULL,NULL,NULL),(3,'Account 3','303-763-0003',NULL,NULL,NULL,'403 Jackson St','Golden',NULL,'80403',400,NULL,NULL,NULL,NULL,NULL),(4,'Account 4','303-763-0004',NULL,NULL,NULL,'404 Jackson St','Golden',NULL,'80403',400,NULL,NULL,NULL,NULL,NULL),(5,'Account 5','303-763-0005',NULL,NULL,NULL,'405 Jackson St','Golden',NULL,'80403',400,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`),
  KEY `index_activities_on_account_id` (`account_id`),
  CONSTRAINT `fk_rails_e53101708c` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,1,'2017-07-05 22:10:22','activity 1 for account Account 1'),(2,1,'2017-07-05 21:10:22','activity 2 for account Account 1'),(3,1,'2017-07-05 20:10:22','activity 3 for account Account 1'),(4,2,'2017-07-05 22:10:22','activity 1 for account Account 2'),(5,2,'2017-07-05 21:10:22','activity 2 for account Account 2'),(6,2,'2017-07-05 20:10:22','activity 3 for account Account 2'),(7,3,'2017-07-05 22:10:22','activity 1 for account Account 3'),(8,3,'2017-07-05 21:10:23','activity 2 for account Account 3'),(9,3,'2017-07-05 20:10:23','activity 3 for account Account 3'),(10,4,'2017-07-05 22:10:23','activity 1 for account Account 4'),(11,4,'2017-07-05 21:10:23','activity 2 for account Account 4'),(12,4,'2017-07-05 20:10:23','activity 3 for account Account 4'),(13,5,'2017-07-05 22:10:23','activity 1 for account Account 5'),(14,5,'2017-07-05 21:10:23','activity 2 for account Account 5'),(15,5,'2017-07-05 20:10:23','activity 3 for account Account 5');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2017-07-05 22:10:21','2017-07-05 22:10:21');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `kind` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `ma` varchar(255) DEFAULT NULL,
  `sunday` tinyint(1) DEFAULT NULL,
  `monday` tinyint(1) DEFAULT NULL,
  `tuesday` tinyint(1) DEFAULT NULL,
  `wednesday` tinyint(1) DEFAULT NULL,
  `thursday` tinyint(1) DEFAULT NULL,
  `friday` tinyint(1) DEFAULT NULL,
  `saturday` tinyint(1) DEFAULT NULL,
  `cellphone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_contacts_on_account_id` (`account_id`),
  CONSTRAINT `fk_rails_e4cf502667` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'f1_a1','l1_a1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,1,'f2_a1','l2_a1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,1,'f3_a1','l3_a1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,2,'f1_a2','l1_a2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,2,'f2_a2','l2_a2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,2,'f3_a2','l3_a2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,3,'f1_a3','l1_a3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,3,'f2_a3','l2_a3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,3,'f3_a3','l3_a3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,4,'f1_a4','l1_a4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,4,'f2_a4','l2_a4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,4,'f3_a4','l3_a4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,5,'f1_a5','l1_a5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,5,'f2_a5','l2_a5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,5,'f3_a5','l3_a5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `favoritable_type` varchar(255) DEFAULT NULL,
  `favoritable_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_favorites` (`favoritable_id`,`favoritable_type`,`user_id`),
  KEY `index_favorites_on_user_id` (`user_id`),
  KEY `index_favorites_on_favoritable_id` (`favoritable_id`),
  KEY `index_favorites_on_favoritable_type` (`favoritable_type`),
  CONSTRAINT `fk_rails_d15744e438` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,1,'Account',1),(4,2,'Account',1),(7,3,'Account',1),(10,4,'Account',1),(13,5,'Account',1),(16,6,'Account',1),(19,7,'Account',1),(22,8,'Account',1),(25,9,'Account',1),(28,10,'Account',1),(2,1,'Account',2),(5,2,'Account',2),(8,3,'Account',2),(11,4,'Account',2),(14,5,'Account',2),(17,6,'Account',2),(20,7,'Account',2),(23,8,'Account',2),(26,9,'Account',2),(29,10,'Account',2),(3,1,'Account',3),(6,2,'Account',3),(9,3,'Account',3),(12,4,'Account',3),(15,5,'Account',3),(18,6,'Account',3),(21,7,'Account',3),(24,8,'Account',3),(27,9,'Account',3),(30,10,'Account',3);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20161229222659'),('20161229230810'),('20170208001247'),('20170208001532'),('20170208001724'),('20170208002229'),('20170315235955'),('20170503235423'),('20170504140223'),('20170505123131');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(255) NOT NULL DEFAULT 'email',
  `uid` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tokens` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT '1000',
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_uid_and_provider` (`uid`,`provider`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_users_on_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'email','r0@null.com','$2a$11$qwRhcUCnVBL9tuGgkndjN.MbAJxZdG8LeuVLAMSU7FAMxnEba8D46',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r0@null.com','{}','2017-07-05 22:10:21','2017-07-05 22:10:21','rf0','rl0',100,NULL,NULL),(2,'email','a0@null.com','$2a$11$z4gSblFz36/NobOsriV7WeQK3j9qm88NOynUlNiMcsDSbgFo3RrWq',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a0@null.com','{}','2017-07-05 22:10:21','2017-07-05 22:10:21','af0','al0',1000,NULL,NULL),(3,'email','r1@null.com','$2a$11$bTLR4KqStPy80elM1FFnku4pfu77r./XTvTAoVQ5GetTb7v7O0/c.',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r1@null.com','{}','2017-07-05 22:10:21','2017-07-05 22:10:21','rf1','rl1',100,NULL,NULL),(4,'email','a1@null.com','$2a$11$P299SQLUk6pETUfWu1PVP.ZHbj4G7evbEG4zirVDQLvTq93IAVbVi',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a1@null.com','{}','2017-07-05 22:10:21','2017-07-05 22:10:21','af1','al1',1000,NULL,NULL),(5,'email','r2@null.com','$2a$11$zL3y18nhx6bJ2q..9HyQaOfZR.sKjdx2pkQLcMGN8aAYfMFO5OcCa',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r2@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','rf2','rl2',100,NULL,NULL),(6,'email','a2@null.com','$2a$11$f1w9cR3/5HpvS6xUYw1JAOcmKsfDcrzEnWk9EkZ29yXnhFW6TVPXy',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a2@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','af2','al2',1000,NULL,NULL),(7,'email','r3@null.com','$2a$11$JFDosjhxAeDMwTP7JRzjmONp4EDmbVLR3qIuVR8W.DWS/RmgbZqaK',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r3@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','rf3','rl3',100,NULL,NULL),(8,'email','a3@null.com','$2a$11$HqyLaHxDbdOyWisbWQ7Psunn.9uxuXhyW9F6W4fQHXD6fQiBcMyH2',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a3@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','af3','al3',1000,NULL,NULL),(9,'email','r4@null.com','$2a$11$M6VG8wpiHKhDGVzNwGMZEec0vLNGGXxBmtOCs9DZsl4Wjn8gMQFay',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r4@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','rf4','rl4',100,NULL,NULL),(10,'email','a4@null.com','$2a$11$c4Uh31Gg6cPZHIv0pkNvyeHpgn/WHsmaGrmCpziJ0WZfjJFCgu2Fu',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a4@null.com','{}','2017-07-05 22:10:22','2017-07-05 22:10:22','af4','al4',1000,NULL,NULL);
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

-- Dump completed on 2017-07-05 16:10:23
