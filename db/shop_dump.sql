-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `session_id` char(64) NOT NULL,
  `status` enum('active','handling','shipped','delivered') DEFAULT 'active',
  `name` varchar(255) DEFAULT NULL,
  `tel` bigint unsigned DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (35,100017,'2021-11-14 13:10:42','2021-11-14 15:12:40','fpqa3k8up21hmutjig5k0lh7fg','delivered','петя',1212121212,'xxxxxx'),(36,0,'2021-11-15 08:29:51',NULL,'118ajku1ktm9q64e3kv5gp9hdc','handling','петя',111111111111,'привет');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `total` int unsigned DEFAULT '1' COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `session_id` char(64) NOT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_of_session_id` (`session_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Состав заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (59,29,1,1,'2021-10-11 18:11:23','2021-10-11 18:11:41','hhc0qcv4pjn2382go654e6dvda',7890.00),(60,29,2,1,'2021-10-11 18:11:26','2021-10-11 18:11:41','hhc0qcv4pjn2382go654e6dvda',12700.00),(62,NULL,1,1,'2021-10-13 10:17:46',NULL,'4c36jar90b8er4qiv9gtt1i20g',7890.00),(63,NULL,2,1,'2021-10-13 10:17:50',NULL,'4c36jar90b8er4qiv9gtt1i20g',12700.00),(64,30,1,7,'2021-10-18 18:59:15','2021-11-07 10:08:30','hhs6ejpctm9817kbncu249abal',7890.00),(77,NULL,2,1,'2021-11-04 16:42:40',NULL,'oavpronehki59rvbt4n35ev4tg',12700.00),(78,NULL,1,1,'2021-11-04 17:10:21',NULL,'olgn4q7rhavj5t1ihd6678bf1d',7890.00),(79,NULL,2,1,'2021-11-04 17:10:24',NULL,'olgn4q7rhavj5t1ihd6678bf1d',12700.00),(117,NULL,1,1,'2021-11-06 12:36:25',NULL,'fg3jknio7ok30kjr8vkug650cc',7890.00),(118,NULL,1,6,'2021-11-06 12:41:33','2021-11-06 12:41:48','5q054t8tt7i0glv5s6reqepqtk',7890.00),(119,NULL,2,1,'2021-11-06 12:41:51',NULL,'5q054t8tt7i0glv5s6reqepqtk',12700.00),(120,NULL,3,1,'2021-11-06 12:43:08',NULL,'5q054t8tt7i0glv5s6reqepqtk',4780.00),(125,NULL,3,6,'2021-11-06 12:57:19','2021-11-06 13:32:10','040elgau3085ruiu9sb62586vn',4780.00),(126,NULL,1,30,'2021-11-06 13:01:40','2021-11-06 13:33:38','040elgau3085ruiu9sb62586vn',7890.00),(127,NULL,2,15,'2021-11-06 13:01:48','2021-11-06 13:32:30','040elgau3085ruiu9sb62586vn',12700.00),(128,NULL,4,3,'2021-11-06 13:02:59','2021-11-06 13:07:28','040elgau3085ruiu9sb62586vn',7120.00),(129,NULL,5,1,'2021-11-06 13:32:35',NULL,'040elgau3085ruiu9sb62586vn',19310.00),(130,NULL,7,1,'2021-11-06 13:32:46',NULL,'040elgau3085ruiu9sb62586vn',5060.00),(131,NULL,1,2,'2021-11-06 14:24:07','2021-11-06 14:24:17','c2pgf5dk0ncf511t8g23l9v3hb',7890.00),(132,NULL,2,2,'2021-11-06 14:24:42','2021-11-06 14:24:56','c2pgf5dk0ncf511t8g23l9v3hb',12700.00),(133,NULL,3,1,'2021-11-06 14:24:51',NULL,'c2pgf5dk0ncf511t8g23l9v3hb',4780.00),(134,NULL,4,1,'2021-11-06 14:25:00',NULL,'c2pgf5dk0ncf511t8g23l9v3hb',7120.00),(137,NULL,3,3,'2021-11-06 15:22:47','2021-11-06 15:24:36','pf0mv3bb1ojmba3oqkrs9abpgc',4780.00),(138,NULL,2,5,'2021-11-06 15:25:03','2021-11-06 15:29:51','pf0mv3bb1ojmba3oqkrs9abpgc',12700.00),(139,NULL,1,2,'2021-11-06 15:26:42','2021-11-06 15:29:47','pf0mv3bb1ojmba3oqkrs9abpgc',7890.00),(146,NULL,1,4,'2021-11-06 17:23:36','2021-11-06 17:23:54','of9ap86kbasl9urjrogttoe9rh',7890.00),(147,NULL,2,4,'2021-11-06 17:23:45','2021-11-06 17:23:56','of9ap86kbasl9urjrogttoe9rh',12700.00),(150,30,2,4,'2021-11-06 17:38:43','2021-11-07 10:08:32','r8jme35a54cgqi1k1u9i2p6t4g',12700.00),(154,NULL,1,4,'2021-11-07 10:08:44','2021-11-07 10:16:45','q7ilef3tjp1mme42522g9odiss',7890.00),(155,NULL,2,3,'2021-11-07 10:08:47','2021-11-07 10:09:42','q7ilef3tjp1mme42522g9odiss',12700.00),(156,NULL,1,7,'2021-11-07 10:17:00','2021-11-07 10:25:27','n6cp9v33o99se7hrknt0m5ktp3',7890.00),(157,NULL,2,3,'2021-11-07 10:23:28','2021-11-07 10:23:41','n6cp9v33o99se7hrknt0m5ktp3',12700.00),(158,NULL,1,3,'2021-11-07 10:48:24','2021-11-07 10:52:29','aps6mcnl06vnlbvcqajo3til56',7890.00),(159,NULL,2,3,'2021-11-07 10:48:26','2021-11-07 10:49:53','aps6mcnl06vnlbvcqajo3til56',12700.00),(160,NULL,1,1,'2021-11-07 10:52:41',NULL,'hkjt42k4hh47mrb95l8vgchpt9',7890.00),(161,NULL,2,1,'2021-11-07 10:52:44',NULL,'hkjt42k4hh47mrb95l8vgchpt9',12700.00),(162,NULL,1,1,'2021-11-07 10:52:57',NULL,'unn6imkefs0l57v0elc5djus25',7890.00),(164,NULL,1,2,'2021-11-07 10:55:15','2021-11-07 10:55:18','v5t3grb67ec4lpbgrnb24p4hga',7890.00),(165,NULL,2,2,'2021-11-07 10:55:16','2021-11-07 10:55:17','v5t3grb67ec4lpbgrnb24p4hga',12700.00),(186,NULL,1,1,'2021-11-07 12:29:13',NULL,'qkqhjom93qo3lr3nsamc5t6qgr',7890.00),(187,NULL,1,1,'2021-11-07 12:29:14',NULL,'qkqhjom93qo3lr3nsamc5t6qgr',7890.00),(188,NULL,2,1,'2021-11-07 12:29:16',NULL,'qkqhjom93qo3lr3nsamc5t6qgr',12700.00),(189,NULL,1,1,'2021-11-07 12:53:04',NULL,'9npsepak2pgfohvfb5rnb0g82l',7890.00),(190,NULL,1,1,'2021-11-07 12:53:05',NULL,'9npsepak2pgfohvfb5rnb0g82l',7890.00),(191,NULL,1,1,'2021-11-07 12:53:05',NULL,'9npsepak2pgfohvfb5rnb0g82l',7890.00),(192,NULL,1,1,'2021-11-07 12:53:05',NULL,'9npsepak2pgfohvfb5rnb0g82l',7890.00),(193,NULL,1,1,'2021-11-07 13:00:23',NULL,'6rio0hsqrbqjhn76181q0b9f5q',7890.00),(194,NULL,1,1,'2021-11-07 13:00:23',NULL,'6rio0hsqrbqjhn76181q0b9f5q',7890.00),(195,NULL,1,1,'2021-11-07 13:00:23',NULL,'6rio0hsqrbqjhn76181q0b9f5q',7890.00),(196,NULL,1,1,'2021-11-07 13:00:24',NULL,'6rio0hsqrbqjhn76181q0b9f5q',7890.00),(197,NULL,1,1,'2021-11-07 13:07:03',NULL,'g8u4obf7s9hc8sev7vuui88mid',7890.00),(198,NULL,1,1,'2021-11-07 13:07:04',NULL,'g8u4obf7s9hc8sev7vuui88mid',7890.00),(199,NULL,1,1,'2021-11-07 13:07:04',NULL,'g8u4obf7s9hc8sev7vuui88mid',7890.00),(235,NULL,1,1,'2021-11-07 14:43:42',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(236,NULL,1,1,'2021-11-07 14:43:43',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(237,NULL,1,1,'2021-11-07 14:43:43',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(238,NULL,1,1,'2021-11-07 14:43:43',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(239,NULL,1,1,'2021-11-07 16:12:47',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(240,NULL,1,1,'2021-11-07 16:12:47',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(241,NULL,1,1,'2021-11-07 16:12:47',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(242,NULL,1,1,'2021-11-07 16:12:47',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(243,NULL,1,1,'2021-11-07 16:12:48',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(247,NULL,1,1,'2021-11-07 16:15:22',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(248,NULL,1,1,'2021-11-08 10:06:32',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(249,NULL,1,1,'2021-11-08 16:43:54',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(250,NULL,1,1,'2021-11-08 17:35:15',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(251,NULL,1,1,'2021-11-08 17:35:16',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(252,NULL,1,1,'2021-11-08 17:35:16',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(253,NULL,1,1,'2021-11-08 17:35:16',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(254,NULL,1,1,'2021-11-08 17:35:17',NULL,'tr4583sl4vnmca378mgvpe73rg',7890.00),(255,NULL,1,1,'2021-11-09 09:20:21',NULL,'50q2rnjr7ep3jvtsujd3j8btch',NULL),(256,NULL,1,1,'2021-11-09 09:20:48',NULL,'50q2rnjr7ep3jvtsujd3j8btch',NULL),(257,NULL,1,1,'2021-11-09 09:41:23',NULL,'50q2rnjr7ep3jvtsujd3j8btch',NULL),(267,NULL,1,1,'2021-11-09 10:22:26',NULL,'qshm1fl1qo20jnkpsfeda8m54c',7890.00),(268,NULL,2,1,'2021-11-09 10:22:27',NULL,'qshm1fl1qo20jnkpsfeda8m54c',12700.00),(319,NULL,1,1,'2021-11-09 12:01:15',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',7890.00),(320,NULL,1,1,'2021-11-09 12:02:48',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',7890.00),(321,NULL,2,1,'2021-11-09 12:02:53',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',12700.00),(322,NULL,2,1,'2021-11-09 12:02:53',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',12700.00),(323,NULL,1,1,'2021-11-09 12:03:24',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',7890.00),(324,NULL,1,1,'2021-11-09 12:03:27',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',7890.00),(325,NULL,1,1,'2021-11-09 12:03:27',NULL,'1s10bq6pcuheg9ju4dh4ekpfli',7890.00),(326,NULL,1,1,'2021-11-09 12:03:41',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(327,NULL,2,1,'2021-11-09 12:03:44',NULL,'96bv8geeb5thg9a2094pacdaoj',12700.00),(328,NULL,2,1,'2021-11-09 12:03:44',NULL,'96bv8geeb5thg9a2094pacdaoj',12700.00),(329,NULL,1,1,'2021-11-09 12:04:15',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(330,NULL,2,1,'2021-11-09 12:04:18',NULL,'96bv8geeb5thg9a2094pacdaoj',12700.00),(331,NULL,2,1,'2021-11-09 12:04:21',NULL,'96bv8geeb5thg9a2094pacdaoj',12700.00),(332,NULL,3,1,'2021-11-09 12:04:33',NULL,'96bv8geeb5thg9a2094pacdaoj',4780.00),(333,NULL,3,1,'2021-11-09 12:04:36',NULL,'96bv8geeb5thg9a2094pacdaoj',4780.00),(334,NULL,1,1,'2021-11-09 12:04:39',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(335,NULL,1,1,'2021-11-09 12:04:39',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(336,NULL,1,1,'2021-11-09 12:04:43',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(337,NULL,1,1,'2021-11-09 12:04:43',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(338,NULL,1,1,'2021-11-09 12:12:50',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(339,NULL,1,1,'2021-11-09 12:13:19',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(340,NULL,1,1,'2021-11-09 12:13:19',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(341,NULL,1,1,'2021-11-09 12:14:42',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(342,NULL,1,1,'2021-11-09 12:14:54',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(343,NULL,1,1,'2021-11-09 12:14:54',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(344,NULL,3,1,'2021-11-09 12:14:58',NULL,'96bv8geeb5thg9a2094pacdaoj',4780.00),(345,NULL,1,1,'2021-11-09 12:19:50',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(346,NULL,1,1,'2021-11-09 12:20:05',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(347,NULL,1,1,'2021-11-09 12:20:06',NULL,'96bv8geeb5thg9a2094pacdaoj',7890.00),(349,NULL,3,1,'2021-11-09 12:35:47',NULL,'og34ja53utnva4midimt2uski1',4780.00),(352,NULL,5,1,'2021-11-09 12:41:29',NULL,'og34ja53utnva4midimt2uski1',19310.00),(353,NULL,5,1,'2021-11-09 12:41:34',NULL,'og34ja53utnva4midimt2uski1',19310.00),(362,NULL,1,1,'2021-11-11 22:08:45',NULL,'5o36p6o0oqpvsggfp4ls7a9iga',7890.00),(363,NULL,4,1,'2021-11-11 22:08:50',NULL,'5o36p6o0oqpvsggfp4ls7a9iga',7120.00),(364,NULL,1,1,'2021-11-13 09:37:40',NULL,'5o36p6o0oqpvsggfp4ls7a9iga',7890.00),(365,NULL,1,1,'2021-11-13 09:42:37',NULL,'5o36p6o0oqpvsggfp4ls7a9iga',7890.00),(366,NULL,1,1,'2021-11-13 09:57:55',NULL,'2dm0csl0eg4p36q70n7s6j98sd',7890.00),(373,28,1,1,'2021-11-14 10:04:47',NULL,'p609gl9kno12r76lelf7ivhhof',7890.00),(375,28,4,1,'2021-11-14 10:04:48',NULL,'p609gl9kno12r76lelf7ivhhof',7120.00),(376,31,1,1,'2021-11-14 10:29:36',NULL,'sdni0ne6mrrhku41eo4vmumq6u',7890.00),(378,32,2,1,'2021-11-14 12:03:16',NULL,'lipu4kvavlkh239hb1bdcsjpta',12700.00),(379,32,2,1,'2021-11-14 12:03:16',NULL,'lipu4kvavlkh239hb1bdcsjpta',12700.00),(380,32,7,1,'2021-11-14 12:03:17',NULL,'lipu4kvavlkh239hb1bdcsjpta',5060.00),(381,32,7,1,'2021-11-14 12:03:17',NULL,'lipu4kvavlkh239hb1bdcsjpta',5060.00),(382,33,1,1,'2021-11-14 12:39:37',NULL,'ah48dqeoahfcpgqc9uvubr8i4j',7890.00),(383,33,4,1,'2021-11-14 12:39:38',NULL,'ah48dqeoahfcpgqc9uvubr8i4j',7120.00),(384,33,4,1,'2021-11-14 12:39:38',NULL,'ah48dqeoahfcpgqc9uvubr8i4j',7120.00),(385,34,3,1,'2021-11-14 13:07:58',NULL,'e05ccgu582coshhn4ej8glo6tk',4780.00),(386,34,3,1,'2021-11-14 13:07:58',NULL,'e05ccgu582coshhn4ej8glo6tk',4780.00),(387,34,3,1,'2021-11-14 13:07:58',NULL,'e05ccgu582coshhn4ej8glo6tk',4780.00),(388,34,3,1,'2021-11-14 13:07:58',NULL,'e05ccgu582coshhn4ej8glo6tk',4780.00),(389,35,2,1,'2021-11-14 13:10:42',NULL,'fpqa3k8up21hmutjig5k0lh7fg',12700.00),(390,35,2,1,'2021-11-14 13:10:42',NULL,'fpqa3k8up21hmutjig5k0lh7fg',12700.00),(391,35,7,1,'2021-11-14 13:10:43',NULL,'fpqa3k8up21hmutjig5k0lh7fg',5060.00),(392,35,6,1,'2021-11-14 13:10:45',NULL,'fpqa3k8up21hmutjig5k0lh7fg',4790.00),(393,35,6,1,'2021-11-14 13:10:46',NULL,'fpqa3k8up21hmutjig5k0lh7fg',4790.00),(394,35,3,1,'2021-11-14 13:10:58',NULL,'fpqa3k8up21hmutjig5k0lh7fg',4780.00),(395,NULL,1,1,'2021-11-15 08:29:25',NULL,'118ajku1ktm9q64e3kv5gp9hdc',7890.00),(396,NULL,1,1,'2021-11-15 08:29:25',NULL,'118ajku1ktm9q64e3kv5gp9hdc',7890.00),(397,NULL,7,1,'2021-11-15 08:29:28',NULL,'118ajku1ktm9q64e3kv5gp9hdc',5060.00),(398,NULL,7,1,'2021-11-15 08:29:28',NULL,'118ajku1ktm9q64e3kv5gp9hdc',5060.00);
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_feedback`
--

DROP TABLE IF EXISTS `product_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_feedback` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `feedback` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `session_id` char(64) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_feedback_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_feedback`
--

LOCK TABLES `product_feedback` WRITE;
/*!40000 ALTER TABLE `product_feedback` DISABLE KEYS */;
INSERT INTO `product_feedback` VALUES (114,1,'Pjotr','hren','2021-10-18 17:32:11',NULL,'41kbm6as401pi09tlcg12kn2oa',100009),(116,1,'testuser','hello 123','2021-10-18 17:43:41','2021-11-14 09:43:02','k8rv33p6bb29dmcs648ae2rspl',100009),(117,1,'pjotr','sadasdasd','2021-11-13 12:59:51',NULL,'om9d605k0entgb1dqelnpgdlop',100009),(120,4,'pjotr','very good','2021-11-13 13:50:13',NULL,'tvb4akg08jpueeqbigiskm8ifq',100009),(126,1,'pjotr','qwerty','2021-11-14 09:43:14',NULL,'7bcqn8ncegaffsohe872hs6rtt',100009);
/*!40000 ALTER TABLE `product_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `product_id` bigint unsigned NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `id` (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,'01.jpg',1),(2,'02.jpg',2),(3,'03.jpg',3),(4,'04.jpg',4),(5,'05.jpg',5),(6,'06.jpg',6),(7,'07.jpg',7);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_likes`
--

DROP TABLE IF EXISTS `product_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `product_likes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_likes`
--

LOCK TABLES `product_likes` WRITE;
/*!40000 ALTER TABLE `product_likes` DISABLE KEYS */;
INSERT INTO `product_likes` VALUES (1,1,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:23'),(2,2,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:25'),(3,1,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:26'),(4,1,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 09:06:22'),(5,2,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 09:06:23'),(6,1,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 10:32:10'),(7,4,'r8ptlrg62s3t2a99kvlfq48h6m',100007,'2021-10-07 10:33:01'),(8,1,'avm0udvpnanrk7a4e61pmsu0nf',100007,'2021-10-07 12:12:37'),(9,4,'ph9q0hut2nrc4b86qla6jjgu5c',100009,'2021-10-07 12:45:28'),(10,5,'mupkckbvigg81eb6bn2c7ipa3m',0,'2021-10-07 17:33:25'),(11,1,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:27'),(12,2,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:31'),(13,2,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:33'),(14,1,'',100007,'2021-10-18 18:17:10'),(15,2,'',100007,'2021-10-18 18:17:11'),(16,1,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:19:57'),(17,1,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:00'),(18,2,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:01'),(19,5,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:25'),(20,7,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:29'),(21,6,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:32'),(22,6,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:33'),(23,4,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:48:37'),(24,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:36:34'),(25,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:37:51'),(26,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:45:59'),(27,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:46:01'),(28,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:46:39'),(29,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:47:43'),(30,2,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:47:44'),(31,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:49:08'),(32,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:51:43'),(33,1,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:26'),(34,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:30'),(35,5,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:31'),(36,7,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:34'),(37,7,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:35'),(38,6,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:36'),(39,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:46'),(40,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:47'),(41,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:47'),(42,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:47'),(43,4,'vf8f6kssu0tfqjak9h8rbogj2u',0,'2021-11-10 23:55:48'),(44,1,'tjgl8527dt4rhnfp80jpvjqsrf',0,'2021-11-13 11:01:03'),(45,4,'tjgl8527dt4rhnfp80jpvjqsrf',0,'2021-11-13 11:01:04'),(46,7,'tjgl8527dt4rhnfp80jpvjqsrf',0,'2021-11-13 11:01:10'),(47,7,'om9d605k0entgb1dqelnpgdlop',100009,'2021-11-13 13:01:24'),(48,1,'p4jjqapsabogl6nudf8h90fia5',100009,'2021-11-13 14:05:46'),(49,3,'e05ccgu582coshhn4ej8glo6tk',100009,'2021-11-14 13:07:57'),(50,1,'118ajku1ktm9q64e3kv5gp9hdc',0,'2021-11-15 08:29:22');
/*!40000 ALTER TABLE `product_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',7890.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(2,'Intel Core i5-7400','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',12700.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(3,'AMD FX-8320E','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',4780.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(4,'AMD FX-8320','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',7120.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(5,'ASUS ROG MAXIMUS X HERO','Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',19310.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(6,'Gigabyte H310M S2H','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',4790.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(7,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',5060.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(181,'calculator','хороший компьтер',12000.00,2,'2021-10-29 17:28:38','2021-10-29 17:29:47');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pass_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'guest',NULL,'2021-10-07 08:45:30','2021-10-07 08:45:30','0',NULL,NULL),(100007,'admin',NULL,'2021-10-04 09:38:25','2021-10-17 14:46:19','$2y$10$Rga/hv3Kd5bnnEK2X2P9Led2fjNa32TC/S86H8AKlnfTtaM9HzZJG','930676073616bf0eb3200e4.21255730',NULL),(100009,'pjotr',NULL,'2021-10-05 17:20:47','2021-11-02 20:08:42','$2y$10$mo5U.kkuJBf3NklTEvwgRuB49IQoUlpruL5BF3kbqJectmD6RchNu','2400959626181628a55a300.54083498',NULL),(100010,'ivan',NULL,'2021-10-05 17:30:55','2021-10-05 17:30:55','$2y$10$M0D9qG4FM0hkjqQD5bEWfuSP/uH4qBrtffJCSAHGRcVFTR39oWi.6',NULL,NULL),(100011,'req',NULL,'2021-10-18 09:43:59','2021-10-18 09:43:59','$2y$10$RyPCmWi6cO3ATA/1rzYxCu60eEZ1ynZDBbP5FmLu.VRjNuwiASmvu',NULL,NULL),(100012,'nikolay.vanzhin@yandex.ru',NULL,'2021-10-18 09:52:31','2021-10-18 09:52:31','$2y$10$OnRNwFMiwVxLSmuO2oyv/eOtkS1kM3/nEhj4rmoKSCJA8Zmv8h7P.',NULL,NULL),(100017,'test1',NULL,'2021-11-02 22:53:46','2021-11-02 22:53:46','$2y$10$zTH.yw72mc25WnudT8I/FOxTRuIgVgh8NvdZQ9GJNlewQqkaUFNgq',NULL,NULL),(100018,'test2',NULL,'2021-11-07 09:24:30','2021-11-07 09:24:30','$2y$10$qcvDBxjEf/a5alwa1OatsehlkmKoKgKf/i6toLp/T0OfBe3F6y2mW',NULL,NULL),(100019,'test111',NULL,'2021-11-13 10:42:01','2021-11-13 10:42:01','$2y$10$2FmMcIYd5pZyNG6QxuZ6t.o5VjfUVjIr3kiSC43b0t1QNxEL9Isq2',NULL,NULL);
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

-- Dump completed on 2021-11-15  8:41:30
