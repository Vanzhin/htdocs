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
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Разделы интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Материнские платы'),(3,'Видеокарты'),(4,'Жесткие диски'),(5,'Оперативная память');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (28,100009,'2021-10-11 18:04:08','2021-10-12 10:36:55','n4peghiotg8ndi3gcdi4m06m1b','handling','петя',1212121212,'7777'),(29,0,'2021-10-11 18:11:41','2021-10-11 19:12:17','hhc0qcv4pjn2382go654e6dvda','shipped','gopa',111111111111,'qsqsawdasdasd'),(30,100007,'2021-10-18 18:42:28',NULL,'hhs6ejpctm9817kbncu249abal','active',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Состав заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (58,28,1,2,'2021-10-11 18:04:08','2021-10-11 18:04:34','n4peghiotg8ndi3gcdi4m06m1b',7890.00),(59,29,1,1,'2021-10-11 18:11:23','2021-10-11 18:11:41','hhc0qcv4pjn2382go654e6dvda',7890.00),(60,29,2,1,'2021-10-11 18:11:26','2021-10-11 18:11:41','hhc0qcv4pjn2382go654e6dvda',12700.00),(61,28,6,1,'2021-10-12 10:36:27',NULL,'n55ooad56org9ok6q648htg6re',4790.00),(62,NULL,1,1,'2021-10-13 10:17:46',NULL,'4c36jar90b8er4qiv9gtt1i20g',7890.00),(63,NULL,2,1,'2021-10-13 10:17:50',NULL,'4c36jar90b8er4qiv9gtt1i20g',12700.00),(64,30,1,1,'2021-10-18 18:59:15',NULL,'hhs6ejpctm9817kbncu249abal',7890.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_feedback`
--

LOCK TABLES `product_feedback` WRITE;
/*!40000 ALTER TABLE `product_feedback` DISABLE KEYS */;
INSERT INTO `product_feedback` VALUES (112,1,'sarah','test','2021-10-18 17:29:17','2021-10-25 11:22:05','sgftd0t3n8i9ueuc9djnv7dqs4',NULL),(113,1,'коля','asdasdasdas','2021-10-18 17:30:29',NULL,'41kbm6as401pi09tlcg12kn2oa',100009),(114,1,'Pjotr','hren','2021-10-18 17:32:11',NULL,'41kbm6as401pi09tlcg12kn2oa',100009),(115,1,'Nikolay','without','2021-10-18 17:43:04',NULL,'4s17r2rm7scsb1v38a3bpkmhl1',NULL),(116,1,'testuser','with','2021-10-18 17:43:41','2021-10-18 17:43:55','k8rv33p6bb29dmcs648ae2rspl',100009);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_likes`
--

LOCK TABLES `product_likes` WRITE;
/*!40000 ALTER TABLE `product_likes` DISABLE KEYS */;
INSERT INTO `product_likes` VALUES (1,1,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:23'),(2,2,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:25'),(3,1,'20tkjdt45sf453vscf66446sk1',100009,'2021-10-07 08:58:26'),(4,1,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 09:06:22'),(5,2,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 09:06:23'),(6,1,'7mmub1u1vdiq5ssq0fs9v1s5kv',0,'2021-10-07 10:32:10'),(7,4,'r8ptlrg62s3t2a99kvlfq48h6m',100007,'2021-10-07 10:33:01'),(8,1,'avm0udvpnanrk7a4e61pmsu0nf',100007,'2021-10-07 12:12:37'),(9,4,'ph9q0hut2nrc4b86qla6jjgu5c',100009,'2021-10-07 12:45:28'),(10,5,'mupkckbvigg81eb6bn2c7ipa3m',0,'2021-10-07 17:33:25'),(11,1,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:27'),(12,2,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:31'),(13,2,'4c36jar90b8er4qiv9gtt1i20g',0,'2021-10-13 09:07:33'),(14,1,'',100007,'2021-10-18 18:17:10'),(15,2,'',100007,'2021-10-18 18:17:11'),(16,1,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:19:57'),(17,1,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:00'),(18,2,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:01'),(19,5,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:25'),(20,7,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:29'),(21,6,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:32'),(22,6,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:20:33'),(23,4,'hhs6ejpctm9817kbncu249abal',100007,'2021-10-18 18:48:37');
/*!40000 ALTER TABLE `product_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
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
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',7890.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(2,'Intel Core i5-7400','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',12700.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(3,'AMD FX-8320E','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',4780.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(4,'AMD FX-8320','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',7120.00,1,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(5,'ASUS ROG MAXIMUS X HERO','Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',19310.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(6,'Gigabyte H310M S2H','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',4790.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(7,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',5060.00,2,'2021-08-25 07:31:01','2021-08-25 07:31:01'),(171,'Ноутбук Apple MacBook Pro 13.3\"','Вашим лучшим спутником в путешествиях и командировках сможет стать компактный ноутбук APPLE MacBook Pro MXK52RU/A. Он выполнен в прочном алюминиевом корпусе серого цвета, на котором практически не видно никаких загрязнений, а его вес составляет всего 1.4 кг.',15900.00,1,'2021-10-24 15:39:48','2021-10-24 15:39:48');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=100013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'guest',NULL,'2021-10-07 08:45:30','2021-10-07 08:45:30','0',NULL,NULL),(100007,'admin',NULL,'2021-10-04 09:38:25','2021-10-17 14:46:19','$2y$10$Rga/hv3Kd5bnnEK2X2P9Led2fjNa32TC/S86H8AKlnfTtaM9HzZJG','930676073616bf0eb3200e4.21255730',NULL),(100009,'pjotr',NULL,'2021-10-05 17:20:47','2021-10-17 14:05:54','$2y$10$mo5U.kkuJBf3NklTEvwgRuB49IQoUlpruL5BF3kbqJectmD6RchNu','1732221802616be772e58fb4.16158642',NULL),(100010,'ivan',NULL,'2021-10-05 17:30:55','2021-10-05 17:30:55','$2y$10$M0D9qG4FM0hkjqQD5bEWfuSP/uH4qBrtffJCSAHGRcVFTR39oWi.6',NULL,NULL),(100011,'req',NULL,'2021-10-18 09:43:59','2021-10-18 09:43:59','$2y$10$RyPCmWi6cO3ATA/1rzYxCu60eEZ1ynZDBbP5FmLu.VRjNuwiASmvu',NULL,NULL),(100012,'nikolay.vanzhin@yandex.ru',NULL,'2021-10-18 09:52:31','2021-10-18 09:52:31','$2y$10$OnRNwFMiwVxLSmuO2oyv/eOtkS1kM3/nEhj4rmoKSCJA8Zmv8h7P.',NULL,NULL);
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

-- Dump completed on 2021-10-25 11:41:38
