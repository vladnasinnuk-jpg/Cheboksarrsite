-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: hr_department_site
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_user_id` int NOT NULL,
  `second_user_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_user_id` (`first_user_id`,`second_user_id`),
  KEY `second_user_id` (`second_user_id`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`first_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`second_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,1,2,'2026-05-22 12:18:24'),(2,1,3,'2026-05-22 12:18:24'),(3,2,4,'2026-05-22 12:18:24'),(4,3,4,'2026-05-22 12:18:24'),(5,1,4,'2026-05-24 12:11:10'),(6,1,38,'2026-05-24 12:21:38'),(7,1,49,'2026-05-24 12:24:47'),(8,1,37,'2026-05-24 12:27:30'),(9,1,35,'2026-05-24 12:28:08');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(1000) DEFAULT NULL,
  `topic` varchar(100) DEFAULT NULL,
  `img_url` varchar(100) DEFAULT NULL,
  `published` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,'Повідомляємо, що проблему з некоректним форматуванням титульних сторінок у щотижневих TPS-звітах, яка виникла на початку цього місяця, успішно усунено. Наші провідні фахівці, Пітер Гіббонс та Майкл Болтон (на фото вище під час фінального аудиту коду), завершили впровадження нового програмного модуля.','Оновлення протоколів підготовки TPS-звітів','post-1.jpg','2026-05-16 16:36:30'),(2,'Ми раді бачити такий високий рівень зацікавленості нашою новою ініціативою щодо оптимізації робочого простору. Фото нижче було зроблено під час сьогоднішнього візиту зовнішніх консультантів з ефективності (відомих як «Боб та Боб»), що викликало неабиякий ажіотаж серед команди.','Запуск програми «Відкритий офіс» та аудит робочого простору','post-2.jpg','2026-05-16 16:36:30'),(3,'Шановні колеги!Як було анонсовано раніше, в межах програми підвищення ефективності ми залучили провідних фахівців з реструктуризації бізнес-процесів. Раді представити вам команду — Боб Слайделл та Боб Портер (на фото).','Зовнішній аудит корпоративної стратегії','post-3.jpg','2026-05-16 16:36:30');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_documents_user` (`user_id`),
  CONSTRAINT `fk_documents_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,1,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(2,1,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(3,1,'document-3.png','Резюме','2026-05-04 16:04:51'),(4,2,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(5,3,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(6,3,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(7,3,'document-3.png','Резюме','2026-05-04 16:04:51'),(8,4,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(9,4,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(10,5,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(11,6,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(12,6,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(13,7,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(14,7,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(15,8,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(16,9,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(17,9,'document-2.png','Трудовой договор','2026-05-04 16:04:51'),(18,9,'document-3.png','Резюме','2026-05-04 16:04:51'),(19,10,'document-1.png','Скан паспорта','2026-05-04 16:04:51'),(20,10,'document-2.png','Трудовой договор','2026-05-04 16:04:51');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `user_id` int NOT NULL,
  `age` int DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_employees_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `employees_chk_1` CHECK (((`age` > 18) or (`age` = 18))),
  CONSTRAINT `employees_chk_2` CHECK ((`status` in (_utf8mb4'active',_utf8mb4'offline'))),
  CONSTRAINT `employees_chk_3` CHECK ((`salary` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,28,'0931112233','1996-05-15','Київ, вул. Центральна, 1','active','olex@example.com','Specialist',25000,'2022-01-10'),(2,34,'0934445566','1990-11-20','Львів, вул. Зелена, 12','active','maria@example.com','Recruiter',22000,'2021-03-15'),(3,40,'0937778899','1984-02-05','Одеса, вул. Морська, 5','offline','dima@example.com','Specialist',45000,'2019-08-20'),(4,25,'0676767676','1999-07-12','Харків, вул. Миру, 3','offline','anna@gmail.com','Assistant',18000,'2023-02-01'),(5,31,'0672223344','1993-09-30','Дніпро, вул. Поля, 44','offline','serg@example.com','Specialist',23000,'2020-11-12');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr`
--

DROP TABLE IF EXISTS `hr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr` (
  `age` int DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_hr_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `hr_chk_1` CHECK (((`age` > 18) or (`age` = 18))),
  CONSTRAINT `hr_chk_2` CHECK ((`status` in (_utf8mb4'active',_utf8mb4'offline'))),
  CONSTRAINT `hr_chk_3` CHECK ((`salary` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr`
--

LOCK TABLES `hr` WRITE;
/*!40000 ALTER TABLE `hr` DISABLE KEYS */;
INSERT INTO `hr` VALUES (40,'0677778899','1984-12-05','Киев, пр. Победы, 101','Accounting','offline','finance_olena@test.com',35000,'2019-02-14',6),(24,'0501110011','2000-03-18','Винница, ул. Лесная, 7','HR','active','junior_hr@test.com',18000,'2024-02-01',7),(29,'0502223344','1995-06-25','Полтава, ул. Степная, 3','Logistics','offline','viktoria_log@test.com',24000,'2021-09-15',8),(31,'0505556677','1993-01-05','Житомир, ул. Новая, 22','Security','active','sec_andrey@test.com',20000,'2023-06-10',9),(42,'0630009988','1997-10-15','Черкассы, ул. Шевченко, 8','','offline','yulia_mark@test.com',28000,'2022-10-01',10);
/*!40000 ALTER TABLE `hr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'Привіт','2026-05-22 12:18:24'),(2,1,2,'Привіт','2026-05-22 12:18:25'),(3,1,1,'Як справи?','2026-05-22 12:18:26'),(4,1,2,'Все добре, працюю над проектом','2026-05-22 12:18:27'),(5,1,1,'Я теж','2026-05-22 12:18:28'),(6,2,1,'Ти сьогодні в офісі?','2026-05-22 12:18:29'),(7,2,3,'Так','2026-05-22 12:18:30'),(8,2,1,'Потрібно обговорити документи','2026-05-22 12:18:31'),(9,2,3,'Добре','2026-05-22 12:18:32'),(10,3,2,'Коли буде звіт?','2026-05-22 12:18:43'),(11,3,4,'До вечора','2026-05-22 12:18:44'),(12,3,2,'Добре, чекатиму','2026-05-22 12:18:45'),(13,4,3,'Ти бачив новий дизайн сайту?','2026-05-22 12:18:46'),(14,4,4,'Так, виглядає круто','2026-05-22 12:18:47'),(15,4,3,'Особливо чат','2026-05-22 12:18:48'),(16,4,4,'Згоден','2026-05-22 12:18:49'),(17,1,1,'Автоматичне тестове повідомлення №1','2026-05-22 12:18:31'),(18,1,2,'Автоматичне тестове повідомлення №2','2026-05-22 12:18:32'),(19,1,1,'Автоматичне тестове повідомлення №3','2026-05-22 12:18:33'),(20,1,2,'Автоматичне тестове повідомлення №4','2026-05-22 12:18:34'),(21,1,2,'Автоматичне тестове повідомлення №5','2026-05-22 12:18:35'),(22,1,1,'Автоматичне тестове повідомлення №6','2026-05-22 12:18:36'),(23,1,1,'Автоматичне тестове повідомлення №7','2026-05-22 12:18:37'),(24,1,1,'Автоматичне тестове повідомлення №8','2026-05-22 12:18:38'),(25,1,1,'Автоматичне тестове повідомлення №9','2026-05-22 12:18:39'),(26,1,1,'Автоматичне тестове повідомлення №10','2026-05-22 12:18:40'),(27,1,2,'Автоматичне тестове повідомлення №11','2026-05-22 12:18:41'),(28,1,2,'Автоматичне тестове повідомлення №12','2026-05-22 12:18:42'),(29,1,1,'Автоматичне тестове повідомлення №13','2026-05-22 12:18:43'),(30,1,1,'Автоматичне тестове повідомлення №14','2026-05-22 12:18:44'),(31,1,1,'Автоматичне тестове повідомлення №15','2026-05-22 12:18:45'),(32,1,2,'Автоматичне тестове повідомлення №16','2026-05-22 12:18:46'),(33,1,2,'Автоматичне тестове повідомлення №17','2026-05-22 12:18:47'),(34,1,2,'Автоматичне тестове повідомлення №18','2026-05-22 12:18:48'),(35,1,1,'Автоматичне тестове повідомлення №19','2026-05-22 12:18:49'),(36,1,1,'Автоматичне тестове повідомлення №20','2026-05-22 12:18:50'),(37,1,2,'Автоматичне тестове повідомлення №21','2026-05-22 12:18:51'),(38,1,1,'Автоматичне тестове повідомлення №22','2026-05-22 12:18:52'),(39,1,2,'Автоматичне тестове повідомлення №23','2026-05-22 12:18:53'),(40,1,2,'Автоматичне тестове повідомлення №24','2026-05-22 12:18:54'),(41,1,2,'Автоматичне тестове повідомлення №25','2026-05-22 12:18:55'),(42,1,2,'Автоматичне тестове повідомлення №26','2026-05-22 12:18:56'),(43,1,2,'Автоматичне тестове повідомлення №27','2026-05-22 12:18:57'),(44,1,2,'Автоматичне тестове повідомлення №28','2026-05-22 12:18:58'),(45,1,2,'Автоматичне тестове повідомлення №29','2026-05-22 12:18:59'),(46,1,2,'Автоматичне тестове повідомлення №30','2026-05-22 12:19:00'),(47,1,1,'Автоматичне тестове повідомлення №31','2026-05-22 12:19:01'),(48,1,2,'Автоматичне тестове повідомлення №32','2026-05-22 12:19:02'),(49,1,2,'Автоматичне тестове повідомлення №33','2026-05-22 12:19:03'),(50,1,2,'Автоматичне тестове повідомлення №34','2026-05-22 12:19:04'),(51,1,1,'Автоматичне тестове повідомлення №35','2026-05-22 12:19:05'),(52,1,1,'Автоматичне тестове повідомлення №36','2026-05-22 12:19:06'),(53,1,2,'Автоматичне тестове повідомлення №37','2026-05-22 12:19:07'),(54,1,2,'Автоматичне тестове повідомлення №38','2026-05-22 12:19:08'),(55,1,1,'Автоматичне тестове повідомлення №39','2026-05-22 12:19:09'),(56,1,1,'Автоматичне тестове повідомлення №40','2026-05-22 12:19:10'),(57,1,1,'Автоматичне тестове повідомлення №41','2026-05-22 12:19:11'),(58,1,2,'Автоматичне тестове повідомлення №42','2026-05-22 12:19:12'),(59,1,2,'Автоматичне тестове повідомлення №43','2026-05-22 12:19:13'),(60,1,2,'Автоматичне тестове повідомлення №44','2026-05-22 12:19:14'),(61,1,1,'Автоматичне тестове повідомлення №45','2026-05-22 12:19:15'),(62,1,1,'Автоматичне тестове повідомлення №46','2026-05-22 12:19:16'),(63,1,1,'Автоматичне тестове повідомлення №47','2026-05-22 12:19:17'),(64,1,2,'Автоматичне тестове повідомлення №48','2026-05-22 12:19:18'),(65,1,1,'Автоматичне тестове повідомлення №49','2026-05-22 12:19:19'),(66,1,1,'Автоматичне тестове повідомлення №50','2026-05-22 12:19:20'),(67,1,1,'Автоматичне тестове повідомлення №51','2026-05-22 12:19:21'),(68,1,2,'Автоматичне тестове повідомлення №52','2026-05-22 12:19:22'),(69,1,2,'Автоматичне тестове повідомлення №53','2026-05-22 12:19:23'),(70,1,2,'Автоматичне тестове повідомлення №54','2026-05-22 12:19:24'),(71,1,2,'Автоматичне тестове повідомлення №55','2026-05-22 12:19:25'),(72,1,1,'Автоматичне тестове повідомлення №56','2026-05-22 12:19:26'),(73,1,2,'Автоматичне тестове повідомлення №57','2026-05-22 12:19:27'),(74,1,1,'Автоматичне тестове повідомлення №58','2026-05-22 12:19:28'),(75,1,1,'Автоматичне тестове повідомлення №59','2026-05-22 12:19:29'),(76,1,1,'Автоматичне тестове повідомлення №60','2026-05-22 12:19:30'),(77,1,2,'Автоматичне тестове повідомлення №61','2026-05-22 12:19:31'),(78,1,2,'Автоматичне тестове повідомлення №62','2026-05-22 12:19:32'),(79,1,1,'Автоматичне тестове повідомлення №63','2026-05-22 12:19:33'),(80,1,1,'Автоматичне тестове повідомлення №64','2026-05-22 12:19:34'),(81,1,2,'Автоматичне тестове повідомлення №65','2026-05-22 12:19:35'),(82,1,1,'Автоматичне тестове повідомлення №66','2026-05-22 12:19:36'),(83,1,2,'Автоматичне тестове повідомлення №67','2026-05-22 12:19:37'),(84,1,1,'Автоматичне тестове повідомлення №68','2026-05-22 12:19:38'),(85,1,1,'Автоматичне тестове повідомлення №69','2026-05-22 12:19:39'),(86,1,1,'Автоматичне тестове повідомлення №70','2026-05-22 12:19:40'),(87,1,1,'Автоматичне тестове повідомлення №71','2026-05-22 12:19:41'),(88,1,2,'Автоматичне тестове повідомлення №72','2026-05-22 12:19:42'),(89,1,2,'Автоматичне тестове повідомлення №73','2026-05-22 12:19:43'),(90,1,1,'Автоматичне тестове повідомлення №74','2026-05-22 12:19:44'),(91,1,1,'Автоматичне тестове повідомлення №75','2026-05-22 12:19:45'),(92,1,2,'Автоматичне тестове повідомлення №76','2026-05-22 12:19:46'),(93,1,2,'Автоматичне тестове повідомлення №77','2026-05-22 12:19:47'),(94,1,1,'Автоматичне тестове повідомлення №78','2026-05-22 12:19:48'),(95,1,2,'Автоматичне тестове повідомлення №79','2026-05-22 12:19:49'),(96,1,2,'Автоматичне тестове повідомлення №80','2026-05-22 12:19:50'),(97,1,2,'Автоматичне тестове повідомлення №81','2026-05-22 12:19:51'),(98,1,1,'Автоматичне тестове повідомлення №82','2026-05-22 12:19:52'),(99,1,2,'Автоматичне тестове повідомлення №83','2026-05-22 12:19:53'),(100,1,2,'Автоматичне тестове повідомлення №84','2026-05-22 12:19:54'),(101,1,2,'Автоматичне тестове повідомлення №85','2026-05-22 12:19:55'),(102,1,2,'Автоматичне тестове повідомлення №86','2026-05-22 12:19:56'),(103,1,1,'Автоматичне тестове повідомлення №87','2026-05-22 12:19:57'),(104,1,2,'Автоматичне тестове повідомлення №88','2026-05-22 12:19:58'),(105,1,1,'Автоматичне тестове повідомлення №89','2026-05-22 12:19:59'),(106,1,2,'Автоматичне тестове повідомлення №90','2026-05-22 12:20:00'),(107,1,2,'Автоматичне тестове повідомлення №91','2026-05-22 12:20:01'),(108,1,1,'Автоматичне тестове повідомлення №92','2026-05-22 12:20:02'),(109,1,2,'Автоматичне тестове повідомлення №93','2026-05-22 12:20:03'),(110,1,1,'Автоматичне тестове повідомлення №94','2026-05-22 12:20:04'),(111,1,2,'Автоматичне тестове повідомлення №95','2026-05-22 12:20:05'),(112,1,1,'Автоматичне тестове повідомлення №96','2026-05-22 12:20:06'),(113,1,2,'Автоматичне тестове повідомлення №97','2026-05-22 12:20:07'),(114,1,1,'Автоматичне тестове повідомлення №98','2026-05-22 12:20:08'),(115,1,2,'Автоматичне тестове повідомлення №99','2026-05-22 12:20:09'),(116,1,2,'Автоматичне тестове повідомлення №100','2026-05-22 12:20:10'),(117,1,1,'fewfwefwefwef','2026-05-23 13:40:00'),(118,1,1,'qqqqqqqqqqqqqqqqqqq','2026-05-23 13:47:28'),(119,1,1,'123','2026-05-23 13:49:08'),(120,1,1,'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww','2026-05-23 13:49:42'),(121,1,1,'ww','2026-05-23 14:12:08'),(122,1,2,'ww','2026-05-23 14:17:25'),(123,1,1,'уцйуйцуйц','2026-05-24 08:16:59'),(124,1,1,'уу','2026-05-24 08:17:01'),(125,1,1,'','2026-05-24 08:17:01'),(126,1,1,'','2026-05-24 08:17:01'),(127,1,1,'','2026-05-24 08:17:02'),(128,1,1,'','2026-05-24 08:17:02'),(129,1,1,'','2026-05-24 08:17:02'),(130,1,1,'','2026-05-24 08:17:03'),(131,1,1,'','2026-05-24 08:17:03'),(132,1,1,'','2026-05-24 08:17:03'),(133,1,1,'','2026-05-24 08:17:22'),(134,1,1,'','2026-05-24 08:17:23'),(135,1,1,'','2026-05-24 08:17:23'),(136,1,1,'','2026-05-24 08:17:23'),(137,1,1,'','2026-05-24 08:17:24'),(138,1,1,'','2026-05-24 08:17:24'),(139,1,1,'','2026-05-24 08:17:24'),(140,1,1,'','2026-05-24 08:17:25'),(141,1,1,'','2026-05-24 08:17:25'),(142,1,1,'','2026-05-24 08:17:25'),(143,1,1,'','2026-05-24 08:17:25'),(144,1,1,'','2026-05-24 08:17:25'),(145,1,1,'','2026-05-24 08:17:25'),(146,1,1,'','2026-05-24 08:17:25'),(147,1,1,'','2026-05-24 08:17:26'),(148,1,1,'','2026-05-24 08:17:26'),(149,1,1,'','2026-05-24 08:17:26'),(150,1,1,'','2026-05-24 08:17:26'),(151,1,1,'','2026-05-24 08:17:26'),(152,1,1,'','2026-05-24 08:17:26'),(153,1,1,'','2026-05-24 08:17:26'),(154,1,1,'','2026-05-24 08:17:26'),(155,1,1,'','2026-05-24 08:17:26'),(156,1,1,'','2026-05-24 08:17:26'),(157,1,1,'','2026-05-24 08:17:26'),(158,1,1,'','2026-05-24 08:17:26'),(159,1,1,'','2026-05-24 08:17:27'),(160,1,1,'','2026-05-24 08:17:27'),(161,1,1,'','2026-05-24 08:17:27'),(162,1,1,'','2026-05-24 08:17:27'),(163,1,1,'','2026-05-24 08:17:27'),(164,1,1,'','2026-05-24 08:17:27'),(165,1,1,'','2026-05-24 08:17:27'),(166,1,1,'','2026-05-24 08:17:27'),(167,1,1,'','2026-05-24 08:17:27'),(168,1,1,'','2026-05-24 08:17:27'),(169,9,1,'hi','2026-05-24 09:28:13');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `check_role_name` CHECK ((`name` in (_utf8mb4'visitor',_utf8mb4'employees',_utf8mb4'hr')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'visitor'),(2,'employees'),(3,'hr');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `second_name` varchar(100) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `roles_id` int DEFAULT NULL,
  `login` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_roles` (`roles_id`),
  CONSTRAINT `fk_user_roles` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pass123','Александр','Коваленко','sth-img-1.png',2,'alex_kov'),(2,'qwerty','Мария','Петренко','sth-img-2.png',2,'maria_p'),(3,'admin77','Дмитрий','Сидоренко','sth-img-3.png',2,'dima_sid'),(4,'user_pass','Анна','Мельник','sth-img-4.png',2,'anna_m'),(5,'p@ssword','Сергей','Шевченко','sth-img-5.png',2,'sergey_sh'),(6,'secret','Елена','Бойко','sth-img-6.png',3,'olena_b'),(7,'123456','Иван','Ткаченко','sth-img-7.png',3,'ivan_tk'),(8,'login8','Виктория','Кравченко','sth-img-8.png',3,'viki_krav'),(9,'my_pass','Андрей','Олейник','sth-img-9.png',3,'andrey_ol'),(10,'top_secret','Юлия','Мороз','sth-img-10.png',3,'yulia_m'),(35,'q','q','q',NULL,1,'q'),(36,'w','4324','32432423',NULL,1,'w'),(37,'e','e','e',NULL,1,'e'),(38,'pass1','User1','Test1',NULL,1,'user1'),(39,'pass2','User2','Test2',NULL,1,'user2'),(40,'pass3','User3','Test3',NULL,1,'user3'),(41,'pass4','User4','Test4',NULL,1,'user4'),(42,'pass5','User5','Test5',NULL,1,'user5'),(43,'pass6','User6','Test6',NULL,1,'user6'),(44,'pass7','User7','Test7',NULL,1,'user7'),(45,'pass8','User8','Test8',NULL,1,'user8'),(46,'pass9','User9','Test9',NULL,1,'user9'),(47,'pass10','User10','Test10',NULL,1,'user10'),(48,'pass11','User11','Test11',NULL,1,'user11'),(49,'pass12','User12','Test12',NULL,1,'user12'),(50,'pass13','User13','Test13',NULL,1,'user13'),(51,'pass14','User14','Test14',NULL,1,'user14'),(52,'pass15','User15','Test15',NULL,1,'user15'),(53,'pass16','User16','Test16',NULL,1,'user16'),(54,'pass17','User17','Test17',NULL,1,'user17'),(55,'pass18','User18','Test18',NULL,1,'user18'),(56,'pass19','User19','Test19',NULL,1,'user19'),(57,'pass20','User20','Test20',NULL,1,'user20'),(58,'pass21','User21','Test21',NULL,1,'user21'),(59,'pass22','User22','Test22',NULL,1,'user22'),(60,'pass23','User23','Test23',NULL,1,'user23'),(61,'pass24','User24','Test24',NULL,1,'user24'),(62,'pass25','User25','Test25',NULL,1,'user25'),(63,'pass26','User26','Test26',NULL,1,'user26'),(64,'pass27','User27','Test27',NULL,1,'user27'),(65,'pass28','User28','Test28',NULL,1,'user28'),(66,'pass29','User29','Test29',NULL,1,'user29'),(67,'pass30','User30','Test30',NULL,1,'user30'),(68,'pass31','User31','Test31',NULL,1,'user31'),(69,'pass32','User32','Test32',NULL,1,'user32'),(70,'pass33','User33','Test33',NULL,1,'user33'),(71,'pass34','User34','Test34',NULL,1,'user34'),(72,'pass35','User35','Test35',NULL,1,'user35'),(73,'pass36','User36','Test36',NULL,1,'user36'),(74,'pass37','User37','Test37',NULL,1,'user37'),(75,'pass38','User38','Test38',NULL,1,'user38'),(76,'pass39','User39','Test39',NULL,1,'user39'),(77,'pass40','User40','Test40',NULL,1,'user40'),(78,'pass41','User41','Test41',NULL,1,'user41'),(79,'pass42','User42','Test42',NULL,1,'user42'),(80,'pass43','User43','Test43',NULL,1,'user43'),(81,'pass44','User44','Test44',NULL,1,'user44'),(82,'pass45','User45','Test45',NULL,1,'user45'),(83,'pass46','User46','Test46',NULL,1,'user46'),(84,'pass47','User47','Test47',NULL,1,'user47'),(85,'pass48','User48','Test48',NULL,1,'user48'),(86,'pass49','User49','Test49',NULL,1,'user49'),(87,'pass50','User50','Test50',NULL,1,'user50'),(88,'pass51','User51','Test51',NULL,1,'user51'),(89,'pass52','User52','Test52',NULL,1,'user52'),(90,'pass53','User53','Test53',NULL,1,'user53'),(91,'pass54','User54','Test54',NULL,1,'user54'),(92,'pass55','User55','Test55',NULL,1,'user55'),(93,'pass56','User56','Test56',NULL,1,'user56'),(94,'pass57','User57','Test57',NULL,1,'user57'),(95,'pass58','User58','Test58',NULL,1,'user58'),(96,'pass59','User59','Test59',NULL,1,'user59'),(97,'pass60','User60','Test60',NULL,1,'user60'),(98,'pass61','User61','Test61',NULL,1,'user61'),(99,'pass62','User62','Test62',NULL,1,'user62'),(100,'pass63','User63','Test63',NULL,1,'user63'),(101,'pass64','User64','Test64',NULL,1,'user64'),(102,'pass65','User65','Test65',NULL,1,'user65'),(103,'pass66','User66','Test66',NULL,1,'user66'),(104,'pass67','User67','Test67',NULL,1,'user67'),(105,'pass68','User68','Test68',NULL,1,'user68'),(106,'pass69','User69','Test69',NULL,1,'user69'),(107,'pass70','User70','Test70',NULL,1,'user70'),(108,'pass71','User71','Test71',NULL,1,'user71'),(109,'pass72','User72','Test72',NULL,1,'user72'),(110,'pass73','User73','Test73',NULL,1,'user73'),(111,'pass74','User74','Test74',NULL,1,'user74'),(112,'pass75','User75','Test75',NULL,1,'user75'),(113,'pass76','User76','Test76',NULL,1,'user76'),(114,'pass77','User77','Test77',NULL,1,'user77'),(115,'pass78','User78','Test78',NULL,1,'user78'),(116,'pass79','User79','Test79',NULL,1,'user79'),(117,'pass80','User80','Test80',NULL,1,'user80'),(118,'pass81','User81','Test81',NULL,1,'user81'),(119,'pass82','User82','Test82',NULL,1,'user82'),(120,'pass83','User83','Test83',NULL,1,'user83'),(121,'pass84','User84','Test84',NULL,1,'user84'),(122,'pass85','User85','Test85',NULL,1,'user85'),(123,'pass86','User86','Test86',NULL,1,'user86'),(124,'pass87','User87','Test87',NULL,1,'user87'),(125,'pass88','User88','Test88',NULL,1,'user88'),(126,'pass89','User89','Test89',NULL,1,'user89'),(127,'pass90','User90','Test90',NULL,1,'user90'),(128,'pass91','User91','Test91',NULL,1,'user91'),(129,'pass92','User92','Test92',NULL,1,'user92'),(130,'pass93','User93','Test93',NULL,1,'user93'),(131,'pass94','User94','Test94',NULL,1,'user94'),(132,'pass95','User95','Test95',NULL,1,'user95'),(133,'pass96','User96','Test96',NULL,1,'user96'),(134,'pass97','User97','Test97',NULL,1,'user97'),(135,'pass98','User98','Test98',NULL,1,'user98'),(136,'pass99','User99','Test99',NULL,1,'user99'),(137,'pass100','User100','Test100',NULL,1,'user100'),(138,'pass101','User101','Test101',NULL,1,'user101'),(139,'pass102','User102','Test102',NULL,1,'user102'),(140,'pass103','User103','Test103',NULL,1,'user103'),(141,'pass104','User104','Test104',NULL,1,'user104'),(142,'pass105','User105','Test105',NULL,1,'user105'),(143,'pass106','User106','Test106',NULL,1,'user106'),(144,'pass107','User107','Test107',NULL,1,'user107'),(145,'pass108','User108','Test108',NULL,1,'user108'),(146,'pass109','User109','Test109',NULL,1,'user109'),(147,'pass110','User110','Test110',NULL,1,'user110'),(148,'pass111','User111','Test111',NULL,1,'user111'),(149,'pass112','User112','Test112',NULL,1,'user112'),(150,'pass113','User113','Test113',NULL,1,'user113'),(151,'pass114','User114','Test114',NULL,1,'user114'),(152,'pass115','User115','Test115',NULL,1,'user115'),(153,'pass116','User116','Test116',NULL,1,'user116'),(154,'pass117','User117','Test117',NULL,1,'user117'),(155,'pass118','User118','Test118',NULL,1,'user118'),(156,'pass119','User119','Test119',NULL,1,'user119'),(157,'pass120','User120','Test120',NULL,1,'user120'),(158,'pass121','User121','Test121',NULL,1,'user121'),(159,'pass122','User122','Test122',NULL,1,'user122'),(160,'pass123','User123','Test123',NULL,1,'user123'),(161,'pass124','User124','Test124',NULL,1,'user124'),(162,'pass125','User125','Test125',NULL,1,'user125'),(163,'pass126','User126','Test126',NULL,1,'user126'),(164,'pass127','User127','Test127',NULL,1,'user127'),(165,'pass128','User128','Test128',NULL,1,'user128'),(166,'pass129','User129','Test129',NULL,1,'user129'),(167,'pass130','User130','Test130',NULL,1,'user130'),(168,'pass131','User131','Test131',NULL,1,'user131'),(169,'pass132','User132','Test132',NULL,1,'user132'),(170,'pass133','User133','Test133',NULL,1,'user133'),(171,'pass134','User134','Test134',NULL,1,'user134'),(172,'pass135','User135','Test135',NULL,1,'user135'),(173,'pass136','User136','Test136',NULL,1,'user136'),(174,'pass137','User137','Test137',NULL,1,'user137'),(175,'pass138','User138','Test138',NULL,1,'user138'),(176,'pass139','User139','Test139',NULL,1,'user139'),(177,'pass140','User140','Test140',NULL,1,'user140'),(178,'pass141','User141','Test141',NULL,1,'user141'),(179,'pass142','User142','Test142',NULL,1,'user142'),(180,'pass143','User143','Test143',NULL,1,'user143'),(181,'pass144','User144','Test144',NULL,1,'user144'),(182,'pass145','User145','Test145',NULL,1,'user145'),(183,'pass146','User146','Test146',NULL,1,'user146'),(184,'pass147','User147','Test147',NULL,1,'user147'),(185,'pass148','User148','Test148',NULL,1,'user148'),(186,'pass149','User149','Test149',NULL,1,'user149'),(187,'pass150','User150','Test150',NULL,1,'user150'),(188,'pass151','User151','Test151',NULL,1,'user151'),(189,'pass152','User152','Test152',NULL,1,'user152'),(190,'pass153','User153','Test153',NULL,1,'user153'),(191,'pass154','User154','Test154',NULL,1,'user154'),(192,'pass155','User155','Test155',NULL,1,'user155'),(193,'pass156','User156','Test156',NULL,1,'user156'),(194,'pass157','User157','Test157',NULL,1,'user157'),(195,'pass158','User158','Test158',NULL,1,'user158'),(196,'pass159','User159','Test159',NULL,1,'user159'),(197,'pass160','User160','Test160',NULL,1,'user160'),(198,'pass161','User161','Test161',NULL,1,'user161'),(199,'pass162','User162','Test162',NULL,1,'user162'),(200,'pass163','User163','Test163',NULL,1,'user163'),(201,'pass164','User164','Test164',NULL,1,'user164'),(202,'pass165','User165','Test165',NULL,1,'user165'),(203,'pass166','User166','Test166',NULL,1,'user166'),(204,'pass167','User167','Test167',NULL,1,'user167'),(205,'pass168','User168','Test168',NULL,1,'user168'),(206,'pass169','User169','Test169',NULL,1,'user169'),(207,'pass170','User170','Test170',NULL,1,'user170'),(208,'pass171','User171','Test171',NULL,1,'user171'),(209,'pass172','User172','Test172',NULL,1,'user172'),(210,'pass173','User173','Test173',NULL,1,'user173'),(211,'pass174','User174','Test174',NULL,1,'user174'),(212,'pass175','User175','Test175',NULL,1,'user175'),(213,'pass176','User176','Test176',NULL,1,'user176'),(214,'pass177','User177','Test177',NULL,1,'user177'),(215,'pass178','User178','Test178',NULL,1,'user178'),(216,'pass179','User179','Test179',NULL,1,'user179'),(217,'pass180','User180','Test180',NULL,1,'user180'),(218,'pass181','User181','Test181',NULL,1,'user181'),(219,'pass182','User182','Test182',NULL,1,'user182'),(220,'pass183','User183','Test183',NULL,1,'user183'),(221,'pass184','User184','Test184',NULL,1,'user184'),(222,'pass185','User185','Test185',NULL,1,'user185'),(223,'pass186','User186','Test186',NULL,1,'user186'),(224,'pass187','User187','Test187',NULL,1,'user187'),(225,'pass188','User188','Test188',NULL,1,'user188'),(226,'pass189','User189','Test189',NULL,1,'user189'),(227,'pass190','User190','Test190',NULL,1,'user190'),(228,'pass191','User191','Test191',NULL,1,'user191'),(229,'pass192','User192','Test192',NULL,1,'user192'),(230,'pass193','User193','Test193',NULL,1,'user193'),(231,'pass194','User194','Test194',NULL,1,'user194'),(232,'pass195','User195','Test195',NULL,1,'user195'),(233,'pass196','User196','Test196',NULL,1,'user196'),(234,'pass197','User197','Test197',NULL,1,'user197'),(235,'pass198','User198','Test198',NULL,1,'user198'),(236,'pass199','User199','Test199',NULL,1,'user199'),(237,'pass200','User200','Test200',NULL,1,'user200'),(238,'1234','default','user',NULL,1,'user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hr_department_site'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 13:27:38
