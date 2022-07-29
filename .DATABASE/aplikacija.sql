/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `aplikacija`;
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aplikacija`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'milantex', '02A8749D83E89C1F4E0EF9764EFC7D8C7E928B16DA5722EA5CC1386A1FA32D5840E0F56DCD27CE5C3CA058ECFF8F5D3A4EBBF8539C1E7D71D297E40A8F9CDD8A'),
	(2, 'test_user', 'BD39EA66270E78AA56671726669D138C64AD1C56BED0970901A340209C9B4EC18FBBFAFFB88AA8D526E5695F063A41A2960128B71318D7ED31D3B123F280DB95'),
	(3, 'pperic', 'BD39EA66270E78AA56671726669D138C64AD1C56BED0970901A340209C9B4EC18FBBFAFFB88AA8D526E5695F063A41A2960128B71318D7ED31D3B123F280DB95'),
	(6, 'mmilic', 'CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E'),
	(9, 'admin22', 'CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E'),
	(10, 'admin144', '$2b$10$t/VCk8wKWFN20i75ghbWIeblwllDN2XT2ObG25atsh.ZTvAS8K0FS'),
	(11, 'admin14334', 'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),
	(12, 'admin1432443sdasda34', '0'),
	(13, 'rade', 'rade'),
	(14, 'aasdasda22', '0'),
	(15, 'aasdasadadasdadasda22', 'CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E'),
	(16, 'eawewew', '4D31CFFC79BE00C8C59A1337B969A1E16373004A042172FF73D5A662FF7138163AED2779B866B425311B59E284C70064A7D293EEDC768C290D8C4B42EC52D780'),
	(18, 'eawewessw', '2489E96B2EB2CAB0FBAEC0DC25EC828AD1A09A5957A874B8D39BCB6E1D38581827E9F37F999F3F02A32C8738DFBEEAE25D11D09BC52FE6DE3B617E17B2F797F1'),
	(19, 'ppericccc', '027BDEA8ACA6C94592CE4D9B8521CFCC2C2913D22B1098B90FE3E722A657F210A34604F974A7C5D02EFF7D7315894FBAEE083A0F12973F22994DF7D9BDA10553'),
	(21, 'mmarko', '5F0520FC930A40BA01925D50255719C32E3434449EB39ADF403B266E35A11AB8A7C97B1090195CDC35A977B050FD60F61E89DC5532F6FC2D9EDB1BBBE8D03C0C'),
	(24, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC'),
	(25, 'admin11', 'C230E0811F617EA267BAB08F8A62CA0585218CFA33676F6ED7D67B7D5AF36192DF3879350D5ACCC26A22486C8774BCE92C3CFE3A3E5C9AA270CCE55709DB6821');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `excerpt` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('available','visible','hidden') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'available',
  `is_promoted` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(1, 'ACME HDD 512GB', 5, 'Kratak opis', 'Detaljan opis', 'available', 0, '2021-07-19 16:22:28'),
	(4, 'ACME HD11 1024GB', 5, 'Neki kratak tekst 2', 'najduzi tekst do sada o nekom proizvodu', 'visible', 1, '2021-07-19 20:30:36'),
	(5, 'ACME HD11 1TB', 5, 'Neki kratak tekst....', 'Neki malo duzi tekst o proizvodu.', 'available', 0, '2021-07-19 20:37:59'),
	(6, 'ACME HD11 1TB', 5, 'Neki kratak tekst....', 'Neki malo duzi tekst o proizvodu.', 'available', 0, '2021-07-19 20:42:42'),
	(7, 'ACME HD11 1TB', 5, 'Neki kratak tekst....', 'Neki malo duzi tekst o proizvodu.', 'available', 0, '2021-07-19 21:13:07'),
	(8, 'ACME HD11 1TB', 5, 'Neki kratak tekst....', 'Neki malo duzi tekst o proizvodu.', 'available', 0, '2021-07-19 21:16:31'),
	(9, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 21:20:08'),
	(10, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 21:24:50'),
	(11, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 21:28:44'),
	(13, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 21:36:36'),
	(14, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 22:43:31'),
	(15, 'Novi naziv artikla', 3, 'Novi kratak opis artikla', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 23:13:56'),
	(16, 'Novi naziv artikla', 3, 'Novi kratak opis artiklaaaa', 'Novi tekst detaljnog opisa artikla...', 'available', 0, '2021-07-19 23:15:27'),
	(17, 'ACME HD11 1024GB', 5, 'Neki kratak tekst 2', 'najduzi tekst do sada o nekom proizvodu', 'visible', 1, '2021-07-20 01:48:57'),
	(18, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-10 02:28:38'),
	(19, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-10 02:37:40'),
	(20, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-10 02:37:59'),
	(21, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-10 02:38:15'),
	(22, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-10 02:38:51'),
	(23, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:26:13'),
	(24, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:28:45'),
	(25, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:29:53'),
	(26, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:30:25'),
	(27, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:48:39'),
	(28, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:49:17'),
	(29, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:50:22'),
	(30, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:51:20'),
	(31, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 20:51:53'),
	(32, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 21:11:20'),
	(33, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 21:21:24'),
	(34, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-11 21:22:28'),
	(35, 'AMCE HDD22 2TB', 5, 'Neki tekst itako', 'neki duzi tekst o proizvodu', 'available', 0, '2022-07-12 20:41:20');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(1, 1, 2, 'SATA3'),
	(3, 1, 3, 'SSD'),
	(6, 34, 1, '1TB'),
	(7, 34, 3, 'SSD'),
	(8, 35, 1, '1TB'),
	(9, 35, 3, 'SSD'),
	(12, 17, 1, '1024GB'),
	(13, 17, 2, 'SATA 3.0');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `article_price`;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
	(1, 1, 43.56, '2021-07-19 17:38:40'),
	(2, 17, 56.89, '2021-07-20 01:48:57'),
	(19, 18, 75.55, '2022-07-10 02:28:38'),
	(20, 19, 75.55, '2022-07-10 02:37:40'),
	(21, 20, 75.55, '2022-07-10 02:38:00'),
	(22, 21, 75.55, '2022-07-10 02:38:15'),
	(23, 22, 75.55, '2022-07-10 02:38:51'),
	(24, 23, 75.55, '2022-07-11 20:26:13'),
	(25, 24, 75.55, '2022-07-11 20:28:45'),
	(26, 25, 75.55, '2022-07-11 20:29:53'),
	(27, 26, 75.55, '2022-07-11 20:30:25'),
	(28, 27, 75.55, '2022-07-11 20:48:39'),
	(29, 28, 75.55, '2022-07-11 20:49:17'),
	(30, 29, 75.55, '2022-07-11 20:50:22'),
	(31, 30, 75.55, '2022-07-11 20:51:20'),
	(32, 31, 75.55, '2022-07-11 20:51:53'),
	(33, 32, 75.55, '2022-07-11 21:11:20'),
	(34, 33, 75.55, '2022-07-11 21:21:24'),
	(35, 34, 75.55, '2022-07-11 21:22:28'),
	(36, 35, 75.55, '2022-07-12 20:41:20'),
	(37, 17, 57.11, '2022-07-22 21:34:34'),
	(38, 17, 57.77, '2022-07-22 22:17:54');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_card_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Racunarske komponente', 'assets/pc.jpg', NULL),
	(2, 'Kucna elektronika', 'assets/home.jpg', NULL),
	(3, 'Laptop racunari', 'assets/pc/laptop.jpg', 1),
	(4, 'Memorijski mediji', 'assets/pc/memory.jpg', 1),
	(5, 'Hard diskovi', 'assets/pc/memory/hdd.jpg', 4);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(1, 'Kapacitet', 5),
	(5, 'napon', 2),
	(4, 'Radni napon', 2),
	(3, 'Tehnologija', 5),
	(2, 'Tip', 5);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(1, 1, 'images/1/front.jpg'),
	(2, 1, 'images/1/label.jpg'),
	(6, 5, '2022713-5796711623-harddisk.jpg'),
	(7, 5, '2022714-9927588271-hard.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `passwrod_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `forename` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `phone_number` varchar(24) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `postal_address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `passwrod_hash`, `forename`, `surname`, `phone_number`, `postal_address`) VALUES
	(1, 'test@testt22.rs', '4EAFAF346EDBB53F3A4A7E0AFF1328F6B066E59DF8B5082781FC4232F588C1EC1E6E615D4104DA96161545C6DF35C44A0D907012D13BCB764D09AE2AB9590045', 'pera', 'peric', '+3812324325', 'Nepoznata adresa bb,Glavna ulica');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
