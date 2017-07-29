-- MySQL dump 10.13  Distrib 5.7.18, for osx10.12 (x86_64)
--
-- Host: localhost    Database: webapp_develop
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
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2017-07-29 22:40:21','2017-07-29 22:40:21');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cees`
--

DROP TABLE IF EXISTS `cees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `source` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cees`
--

LOCK TABLES `cees` WRITE;
/*!40000 ALTER TABLE `cees` DISABLE KEYS */;
INSERT INTO `cees` VALUES (1,'Coffee',200,200),(2,'Chocolate',400,200),(3,'Cheese',300,100),(4,'Cervesa',200,200),(5,'Cake',400,100);
/*!40000 ALTER TABLE `cees` ENABLE KEYS */;
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
INSERT INTO `favorites` VALUES (1,1,'Cee',1),(4,2,'Cee',1),(7,3,'Cee',1),(10,4,'Cee',1),(13,5,'Cee',1),(16,6,'Cee',1),(19,7,'Cee',1),(22,8,'Cee',1),(25,9,'Cee',1),(28,10,'Cee',1),(2,1,'Cee',2),(5,2,'Cee',2),(8,3,'Cee',2),(11,4,'Cee',2),(14,5,'Cee',2),(17,6,'Cee',2),(20,7,'Cee',2),(23,8,'Cee',2),(26,9,'Cee',2),(29,10,'Cee',2),(3,1,'Cee',3),(6,2,'Cee',3),(9,3,'Cee',3),(12,4,'Cee',3),(15,5,'Cee',3),(18,6,'Cee',3),(21,7,'Cee',3),(24,8,'Cee',3),(27,9,'Cee',3),(30,10,'Cee',3);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flavors`
--

DROP TABLE IF EXISTS `flavors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flavors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cee_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_flavors_on_cee_id` (`cee_id`),
  CONSTRAINT `fk_rails_666b79ba13` FOREIGN KEY (`cee_id`) REFERENCES `cees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flavors`
--

LOCK TABLES `flavors` WRITE;
/*!40000 ALTER TABLE `flavors` DISABLE KEYS */;
INSERT INTO `flavors` VALUES (1,1,'Dark Roast','Brown'),(2,1,'Medium Roast','Light Brown'),(3,2,'Dark','Brown'),(4,2,'Milik','Light Brown'),(5,3,'Cream','White'),(6,3,'Brie','White'),(7,3,'Port','Cream'),(8,4,'Stout','Black'),(9,4,'English Bitter','Tan'),(10,4,'Lager','Light Brown'),(11,5,'Chocolate','Brown'),(12,5,'Lemon','Yellow'),(13,5,'Vanilla','White');
/*!40000 ALTER TABLE `flavors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cee_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`),
  KEY `index_notes_on_cee_id` (`cee_id`),
  CONSTRAINT `fk_rails_2d2c54a020` FOREIGN KEY (`cee_id`) REFERENCES `cees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,5,'2017-07-29 22:40:38','note 1 for Cake'),(2,5,'2017-07-29 21:40:38','note 2 for Cake'),(3,5,'2017-07-29 20:40:38','note 3 for Cake'),(4,4,'2017-07-29 22:40:38','note 1 for Cervesa'),(5,4,'2017-07-29 21:40:38','note 2 for Cervesa'),(6,4,'2017-07-29 20:40:38','note 3 for Cervesa'),(7,3,'2017-07-29 22:40:38','note 1 for Cheese'),(8,3,'2017-07-29 21:40:38','note 2 for Cheese'),(9,3,'2017-07-29 20:40:38','note 3 for Cheese'),(10,2,'2017-07-29 22:40:38','note 1 for Chocolate'),(11,2,'2017-07-29 21:40:38','note 2 for Chocolate'),(12,2,'2017-07-29 20:40:38','note 3 for Chocolate'),(13,1,'2017-07-29 22:40:38','note 1 for Coffee'),(14,1,'2017-07-29 21:40:38','note 2 for Coffee'),(15,1,'2017-07-29 20:40:38','note 3 for Coffee');
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
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
INSERT INTO `schema_migrations` VALUES ('20161229222659'),('20161229230810'),('20170208001247'),('20170208001532'),('20170208001724'),('20170208002229');
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
INSERT INTO `users` VALUES (1,'email','r0@null.com','$2a$11$4ecv6rg35JrkFpfYT2g6heyj5iOWY9BinZlOtkz5d2eY0sXcgHQq2',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r0@null.com','{}','2017-07-29 22:40:35','2017-07-29 22:40:35','rf0','rl0',100,NULL,NULL),(2,'email','a0@null.com','$2a$11$Q83dgkpe6ODHEA9vqwuX4ubAcB9IpqxYVuCxRCU/wvF9/Q.9OjjLe',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a0@null.com','{}','2017-07-29 22:40:35','2017-07-29 22:40:35','af0','al0',1000,NULL,NULL),(3,'email','r1@null.com','$2a$11$s2ueedGw.aoKFE0E8tHVCOXQuzMo6YsQndEDupoH8Y1RBePDq8lyi',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r1@null.com','{}','2017-07-29 22:40:36','2017-07-29 22:40:36','rf1','rl1',100,NULL,NULL),(4,'email','a1@null.com','$2a$11$zCc8NbIqeumf.WUNnBoCfeOeQRLQdSwDz9fZ4hsX2uOAd774uSxQS',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a1@null.com','{}','2017-07-29 22:40:36','2017-07-29 22:40:36','af1','al1',1000,NULL,NULL),(5,'email','r2@null.com','$2a$11$3zsqDZ3CWoEXlLuNSebg1.slnEvLEN6Ux6dNlKOFTsmDbcHbYxPEm',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r2@null.com','{}','2017-07-29 22:40:36','2017-07-29 22:40:36','rf2','rl2',100,NULL,NULL),(6,'email','a2@null.com','$2a$11$4UkrGRuWl1TXIa6orAkUnezpNcd/oQxSBSZW.vYgdm7oFsacbBDRe',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a2@null.com','{}','2017-07-29 22:40:36','2017-07-29 22:40:36','af2','al2',1000,NULL,NULL),(7,'email','r3@null.com','$2a$11$LXpNoH1n6.PYOIhgUSgfW.cLlMltzjso0FQn8RCcZ4a1/iNXia1/K',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r3@null.com','{}','2017-07-29 22:40:37','2017-07-29 22:40:37','rf3','rl3',100,NULL,NULL),(8,'email','a3@null.com','$2a$11$AmFbrE/h7rnrVvlTbl92x.ulzfW9OavY5PceAUM8JFtEAfSlgA60a',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a3@null.com','{}','2017-07-29 22:40:37','2017-07-29 22:40:37','af3','al3',1000,NULL,NULL),(9,'email','r4@null.com','$2a$11$jDLDWppRiaHmbrk.aVgYluBmvYPzfyPIckSiuo6dCVGUsfjSJldxK',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'r4@null.com','{}','2017-07-29 22:40:37','2017-07-29 22:40:37','rf4','rl4',100,NULL,NULL),(10,'email','a4@null.com','$2a$11$7KNoc5y43UyWsMS8ZfZEQOST0SuSnwtuovmDXUG5DL.PwV1Ntaii6',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a4@null.com','{}','2017-07-29 22:40:37','2017-07-29 22:40:37','af4','al4',1000,NULL,NULL);
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

-- Dump completed on 2017-07-29 16:40:41
