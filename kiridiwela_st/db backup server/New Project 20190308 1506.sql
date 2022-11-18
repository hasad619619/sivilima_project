-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema kird
--

CREATE DATABASE IF NOT EXISTS kird;
USE kird;

--
-- Definition of table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `idaccount` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `remarks` varchar(45) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `customer` int(11) DEFAULT NULL,
  `supplier` int(11) DEFAULT NULL,
  `expences` int(11) DEFAULT NULL,
  `employee` int(11) DEFAULT NULL,
  `debit_balance` double DEFAULT NULL,
  `credit_balance` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `credit_limit` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  PRIMARY KEY (`idaccount`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `account`
--

/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`idaccount`,`name`,`contact`,`email`,`address`,`remarks`,`bank`,`customer`,`supplier`,`expences`,`employee`,`debit_balance`,`credit_balance`,`status`,`credit_limit`,`balance`) VALUES 
 (3,'Idea Industries Limited','0112577777','info@iroof .lk','06,Lucas Road Colombo 14','N/A',0,1,1,0,0,0,503540,1,0,0),
 (4,'Weliweriya Mega Stores','0770420321','saman @ gmail.com','weliweriya','N/A',0,0,1,0,0,0,1402619,1,0,0),
 (5,'Idea Imports & Exports (pvt) Ltd','0722002200','info@iroof.lk','06 Lucas Road Colombo 14','N/A',0,1,1,0,0,0,0,1,0,0),
 (6,'Seylan Bank','0332269709','seylan@gmail.com','Main Street , Kirindiwela','N/A',1,0,0,0,0,0,100000,1,0,11000),
 (7,'K C Homes','0774900101','kulae19@gmail.com','No1A,Kandy Road,Nittabuwa.','N/A',0,1,0,0,0,0,0,1,0,540822),
 (8,'Petty Cash (Senula)','0703555355','www.fairmart.lk','25/11/B,Rajaweediya Kirindiwela','N/A',0,0,0,1,0,0,0,1,0,0),
 (9,'Niro Lanka Holdings (pvt) Ltd.','0716367633','nirolankaholdings@gmail.com','574/1/B,Kandy Road,Rammuthugala ,Kirillawala','N/A',0,0,1,0,0,0,0,1,0,0),
 (10,'Petty Cash (Sivilima Kirindiwela)','0000000000','N/A','N/A','N/A',0,0,0,1,0,0,0,1,0,0),
 (11,'Deepika','0776540269','N/A','Palahara,Dompe.','N/A',0,1,0,0,0,0,0,1,0,187228);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;


--
-- Definition of table `branch`
--

DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `idbranch` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idbranch`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `branch`
--

/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` (`idbranch`,`name`,`status`) VALUES 
 (1,'SHOP',1),
 (2,'Sivilima Kirindiwela',1),
 (3,'Senula Lighting',1);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;


--
-- Definition of table `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `idbrand` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idbrand`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brand`
--

/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` (`idbrand`,`name`,`status`) VALUES 
 (3,'I Panel',1),
 (4,'I Plus',1),
 (5,'I Grid',1),
 (6,'I Roof',1),
 (7,'Veera',1),
 (8,'Eco Timber',1);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;


--
-- Definition of table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `idcategory` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcategory`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`idcategory`,`name`,`status`) VALUES 
 (7,'Ceiling',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


--
-- Definition of table `customer_type`
--

DROP TABLE IF EXISTS `customer_type`;
CREATE TABLE `customer_type` (
  `customer_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_type`
--

/*!40000 ALTER TABLE `customer_type` DISABLE KEYS */;
INSERT INTO `customer_type` (`customer_type_id`,`name`,`status`) VALUES 
 (1,'DEFAULT',1),
 (2,'Normal customer',1),
 (3,'Sivilima showroom',1),
 (4,'Fabricater',1);
/*!40000 ALTER TABLE `customer_type` ENABLE KEYS */;


--
-- Definition of table `customer_type_customer`
--

DROP TABLE IF EXISTS `customer_type_customer`;
CREATE TABLE `customer_type_customer` (
  `idcustomer_type_customer` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL,
  `customer` int(11) NOT NULL,
  `customer_type_id` int(11) NOT NULL,
  PRIMARY KEY (`idcustomer_type_customer`),
  KEY `fk_customer_type_customer_account1_idx` (`customer`),
  KEY `fk_customer_type_customer_customer_type1_idx` (`customer_type_id`),
  CONSTRAINT `fk_customer_type_customer_account1` FOREIGN KEY (`customer`) REFERENCES `account` (`idaccount`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_type_customer_customer_type1` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`customer_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_type_customer`
--

/*!40000 ALTER TABLE `customer_type_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_type_customer` ENABLE KEYS */;


--
-- Definition of table `item_sub`
--

DROP TABLE IF EXISTS `item_sub`;
CREATE TABLE `item_sub` (
  `iditem_sub` int(11) NOT NULL AUTO_INCREMENT,
  `items_item_id` int(5) NOT NULL,
  `sub_category_subcategory_id` int(11) NOT NULL,
  PRIMARY KEY (`iditem_sub`),
  KEY `fk_item_sub_items1_idx` (`items_item_id`),
  KEY `fk_item_sub_sub_category1_idx` (`sub_category_subcategory_id`),
  CONSTRAINT `fk_item_sub_items1` FOREIGN KEY (`items_item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_sub_sub_category1` FOREIGN KEY (`sub_category_subcategory_id`) REFERENCES `sub_category` (`subcategory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_sub`
--

/*!40000 ALTER TABLE `item_sub` DISABLE KEYS */;
INSERT INTO `item_sub` (`iditem_sub`,`items_item_id`,`sub_category_subcategory_id`) VALUES 
 (2,12,7),
 (3,13,7),
 (4,14,7),
 (5,15,7),
 (6,16,7),
 (7,17,7),
 (8,18,7),
 (9,19,7),
 (10,20,7),
 (11,21,7),
 (12,22,7),
 (13,23,7),
 (14,24,7),
 (15,25,7),
 (16,26,7),
 (17,27,7),
 (18,28,7),
 (19,29,7),
 (20,30,7),
 (21,31,7),
 (22,32,7),
 (23,33,7),
 (24,34,7),
 (25,35,7),
 (26,36,7),
 (27,37,7),
 (28,38,7),
 (29,39,8),
 (30,40,8),
 (31,41,8),
 (32,42,8),
 (33,43,8),
 (34,44,8),
 (35,45,8),
 (36,46,8),
 (37,47,8),
 (38,48,8),
 (39,49,7),
 (40,50,7),
 (41,51,7),
 (42,52,8),
 (43,53,8),
 (44,54,8),
 (45,55,8),
 (46,56,8),
 (47,57,8),
 (48,58,8),
 (49,59,8),
 (50,60,8),
 (51,61,8),
 (52,62,8),
 (53,63,8),
 (54,64,8),
 (55,65,8),
 (56,66,8),
 (57,67,8),
 (58,68,8),
 (59,69,8),
 (60,70,8),
 (61,71,8),
 (62,72,8),
 (63,73,8),
 (64,74,8),
 (65,75,8),
 (66,76,8),
 (67,77,8),
 (68,78,8),
 (69,79,8),
 (70,80,8),
 (71,81,8),
 (72,82,8),
 (73,83,8),
 (74,84,8),
 (75,85,8),
 (76,86,8),
 (77,87,8),
 (78,88,8),
 (79,89,8),
 (80,90,8),
 (81,91,8),
 (82,92,8),
 (83,93,8),
 (84,94,8),
 (85,95,8),
 (86,96,8),
 (87,97,8),
 (88,98,8),
 (89,99,8),
 (90,100,8),
 (91,101,8),
 (92,102,8),
 (93,103,8),
 (94,104,8),
 (95,105,8),
 (96,106,8),
 (97,107,8),
 (98,108,8),
 (99,109,8),
 (100,110,8),
 (101,111,8),
 (102,112,8),
 (103,113,8),
 (104,114,8),
 (105,115,8),
 (106,116,8),
 (107,117,8),
 (108,118,8),
 (109,119,8),
 (110,120,8),
 (111,121,8),
 (112,122,8),
 (113,123,8),
 (114,124,8),
 (115,125,8),
 (116,126,8),
 (117,127,8),
 (118,128,8),
 (119,129,8),
 (120,130,8),
 (121,131,8),
 (122,132,8);
/*!40000 ALTER TABLE `item_sub` ENABLE KEYS */;


--
-- Definition of table `item_third`
--

DROP TABLE IF EXISTS `item_third`;
CREATE TABLE `item_third` (
  `iditem_third` int(11) NOT NULL AUTO_INCREMENT,
  `items_item_id` int(5) NOT NULL,
  `third_category_thirdcategory_id` int(11) NOT NULL,
  PRIMARY KEY (`iditem_third`),
  KEY `fk_item_third_items1_idx` (`items_item_id`),
  KEY `fk_item_third_third_category1_idx` (`third_category_thirdcategory_id`),
  CONSTRAINT `fk_item_third_items1` FOREIGN KEY (`items_item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_third_third_category1` FOREIGN KEY (`third_category_thirdcategory_id`) REFERENCES `third_category` (`thirdcategory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_third`
--

/*!40000 ALTER TABLE `item_third` DISABLE KEYS */;
INSERT INTO `item_third` (`iditem_third`,`items_item_id`,`third_category_thirdcategory_id`) VALUES 
 (2,12,5),
 (3,13,5),
 (4,14,5),
 (5,15,5),
 (6,16,5),
 (7,17,5),
 (8,18,5),
 (9,19,5),
 (10,20,5),
 (11,21,5),
 (12,22,5),
 (13,23,5),
 (14,24,5),
 (15,25,5),
 (16,26,5),
 (17,27,5),
 (18,28,5),
 (19,29,6),
 (20,30,6),
 (21,31,6),
 (22,32,6),
 (23,33,6),
 (24,34,6),
 (25,35,6),
 (26,36,6),
 (27,37,6),
 (28,38,6),
 (29,39,7),
 (30,40,7),
 (31,41,7),
 (32,42,7),
 (33,43,7),
 (34,44,7),
 (35,45,7),
 (36,46,7),
 (37,47,7),
 (38,48,7),
 (39,49,6),
 (40,50,6),
 (41,51,6),
 (42,52,7),
 (43,53,7),
 (44,54,7),
 (45,55,7),
 (46,56,7),
 (47,57,7),
 (48,58,7),
 (49,59,7),
 (50,60,7),
 (51,61,7),
 (52,62,7),
 (53,63,7),
 (54,64,7),
 (55,65,7),
 (56,66,7),
 (57,67,7),
 (58,68,7),
 (59,69,7),
 (60,70,7),
 (61,71,7),
 (62,72,7),
 (63,73,7),
 (64,74,7),
 (65,75,7),
 (66,76,7),
 (67,77,7),
 (68,78,7),
 (69,79,7),
 (70,80,7),
 (71,81,7),
 (72,82,7),
 (73,83,7),
 (74,84,7),
 (75,85,7),
 (76,86,7),
 (77,87,7),
 (78,88,7),
 (79,89,7),
 (80,90,7),
 (81,91,7),
 (82,92,7),
 (83,93,7),
 (84,94,7),
 (85,95,7),
 (86,96,7),
 (87,97,7),
 (88,98,7),
 (89,99,7),
 (90,100,7),
 (91,101,7),
 (92,102,7),
 (93,103,7),
 (94,104,7),
 (95,105,7),
 (96,106,7),
 (97,107,8),
 (98,108,8),
 (99,109,8),
 (100,110,8),
 (101,111,8),
 (102,112,8),
 (103,113,8),
 (104,114,8),
 (105,115,8),
 (106,116,8),
 (107,117,8),
 (108,118,8),
 (109,119,8),
 (110,120,8),
 (111,121,8),
 (112,122,8),
 (113,123,8),
 (114,124,8),
 (115,125,8),
 (116,126,8),
 (117,127,8),
 (118,128,8),
 (119,129,8),
 (120,130,8),
 (121,131,8),
 (122,132,8);
/*!40000 ALTER TABLE `item_third` ENABLE KEYS */;


--
-- Definition of table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item_id` int(5) NOT NULL AUTO_INCREMENT,
  `barcode_id` varchar(45) NOT NULL,
  `name` varchar(150) NOT NULL,
  `date` varchar(45) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `idbrand` int(11) NOT NULL,
  `idcategory` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `he` double DEFAULT NULL,
  `wi` double DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_items_type1_idx` (`type_id`),
  KEY `fk_items_brand1_idx` (`idbrand`),
  KEY `fk_items_category1_idx` (`idcategory`),
  KEY `fk_items_account1_idx` (`account`),
  CONSTRAINT `fk_items_account1` FOREIGN KEY (`account`) REFERENCES `account` (`idaccount`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_brand1` FOREIGN KEY (`idbrand`) REFERENCES `brand` (`idbrand`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_category1` FOREIGN KEY (`idcategory`) REFERENCES `category` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`item_id`,`barcode_id`,`name`,`date`,`type_id`,`status`,`idbrand`,`idcategory`,`account`,`he`,`wi`,`image`) VALUES 
 (12,'IPCD0019','IPCD0019','2019-03-02',1,1,3,7,5,24,24,'N/A'),
 (13,'Design 01','Design 01','2019-03-02',1,1,4,7,4,24,24,'N/A'),
 (14,'Design 06','Design 06','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (15,'Design 05','Design 05','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (16,'Design 02','Design 02','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (17,'F - 170','F - 170','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (18,'F - 182','F - 182','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (19,'F005 - 18','F005 - 18','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (20,'F005 - 26','F005 - 26','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (21,'WS 12','WS 12','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (22,'IPCD 0022','IPCD 0022','2019-03-02',1,1,3,7,5,24,24,'N/A'),
 (23,'IPCD 0026','IPCD 0026','2019-03-02',1,1,3,7,5,24,24,'N/A'),
 (24,'IPCD 0025','IPCD 0025','2019-03-02',1,1,3,7,5,24,24,'N/A'),
 (25,'White','White','2019-03-02',1,1,3,7,5,24,24,'N/A'),
 (26,'6122','6122','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (27,'I Plus 002','I Plus 002','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (28,'I Plus 004','I Plus 004','2019-03-02',1,1,4,7,5,24,24,'N/A'),
 (29,'Main T White','Main T White','2019-03-02',1,1,5,7,5,144,0,'N/A'),
 (30,'Main T Black','Main T Black','2019-03-02',1,1,5,7,5,144,0,'N/A'),
 (31,'Main T Wood','Main T Wood','2019-03-02',1,1,5,7,5,144,0,'N/A'),
 (32,'Wall Angle White','Wall Angle White','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (33,'Wall Angle Wood','Wall Angle Wood','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (34,'Cross 2T White','Cross 2T White','2019-03-02',1,1,5,7,5,24,0,'N/A'),
 (35,'Cross 2T Black','Cross 2T Black','2019-03-02',1,1,5,7,5,24,0,'N/A'),
 (36,'Cross 2T Wood','Cross 2T Wood','2019-03-02',1,1,5,7,5,24,0,'N/A'),
 (37,'Cross 4T White','Cross 4T White','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (38,'Cross 4T Black','Cross 4T Black','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (39,'01','Teak 4\"','2019-03-02',1,1,3,7,5,48,4,'N/A'),
 (40,'02','Burma Teak 4\"','2019-03-02',1,1,3,7,5,48,4,'N/A'),
 (41,'03','Kithul 4\"','2019-03-02',1,1,3,7,5,48,4,'N/A'),
 (42,'04','Apple Wood (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (43,'05','Urben Teak (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (44,'06','Samoa Teak (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (45,'07','Wall Nut (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (46,'08','Siam Teak (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (47,'09','Teak (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (48,'10','Burma Teak (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (49,'Main T Teak','Main T Teak','2019-03-02',1,1,5,7,5,144,0,'N/A'),
 (50,'Cross 2T Teak','Cross 2T Teak','2019-03-02',1,1,5,7,5,24,0,'N/A'),
 (51,'Wall Angle Teak','Wall Angle Teak','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (52,'IP04','Apple Wood (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (53,'IP05','Urben Teak (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (54,'IP06','Samoa Teak (8\"X 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (55,'IP07','Wall Nut (8\"X 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (56,'IP08','Siam Teak (8\"X 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (57,'IP09','Teak (8\"X 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (58,'IP10','Burma Teak ( 8\"X 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (59,'11','Antique Brown (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (60,'IP11','Antique Brown (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (61,'12','Smoke (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (62,'IP12','Smoke (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (63,'13','Buttermilk (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (64,'IP13','Buttermilk (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (65,'14','Diamond (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (66,'IP14','Diamond (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (67,'15','Cool Line (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (68,'IP15','Cool Line (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (69,'16','Moon Wood (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (70,'IP16','Moon Wood (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (71,'17','Rich Brown (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (72,'IP17','Rich Brown (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (73,'18','Cool Brown (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (74,'IP18','Cool Brown (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (75,'19','Silver Line White (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (76,'IP19','Silver Line White (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (77,'20','Silver Line Black (8\"x 8\')','2019-03-02',1,1,3,7,5,96,8,'N/A'),
 (78,'IP20','Silver Line Black (8\"x 10\')','2019-03-02',1,1,3,7,5,120,8,'N/A'),
 (79,'21','Sand Stone (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (80,'IP21','Sand Stone (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (81,'22','Morning White (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (82,'IP22','Morning White (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (83,'23','Fresh Line (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (84,'IP23','Fresh Line (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (85,'24','Grey Milk (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (86,'IP24','Grey Milk (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (87,'25','Burma Teak (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (88,'IP25','Burma Teak (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (89,'26','Teak(10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (90,'IP26','Teak (10\"X 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (91,'27','Glossy Siam Teak (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (92,'IP27','Glossy Siam Teak (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (93,'28','Glossy Apple Wood (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (94,'IP28','Glossy Apple Wood (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (95,'29','White Wave (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (96,'IP29','White Wave (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (97,'30','Brown Leather (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (98,'IP30','Brown Leather (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (99,'31','Light Wood (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (100,'IP31','Light Wood (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (101,'32','Drak Wood (10\"x 8\')','2019-03-02',1,1,3,7,5,96,10,'N/A'),
 (102,'IP32','Drak Wood (10\"x 10\')','2019-03-02',1,1,3,7,5,120,10,'N/A'),
 (103,'Burma Teak (12\"x10\')','Burma Teak (12\"x10\')','2019-03-02',1,1,4,7,5,120,12,'N/A'),
 (104,'Teak (12\"X 10\')','Teak (12\"X 10\')','2019-03-02',1,1,4,7,5,120,12,'N/A'),
 (105,'Economic 003','Economic 003','2019-03-02',1,1,8,7,5,108,8,'N/A'),
 (106,'Economic 004','Economic 004','2019-03-02',1,1,8,7,5,108,8,'N/A'),
 (107,'GI Wall Angle 8\'','GI Wall Angle 8\'','2019-03-02',1,1,5,7,5,96,2,'N/A'),
 (108,'GI C Chanel','GI C Chanel','2019-03-02',1,1,5,7,5,96,2,'N/A'),
 (109,'Molding Burma Teak 10\'','Molding Burma Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (110,'Molding Burma Teak 4\'','Molding Burma Teak 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (111,'Molding Teak 10\'','Molding Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (112,'Molding Teak 4\'','Molding Teak 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (113,'Molding White 10\'','Molding White 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (114,'Molding White 4\'','Molding White 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (115,'U Corner Burma Teak 10\'','U Corner Burma Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (116,'U Corner Teak 10\'','U Corner Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (117,'U Corner White 10\'','U Corner White 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (118,'L Corner Burma Teak 10\'','L Corner Burma Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (119,'L Corner Teak 10\'','L Corner Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (120,'L Corner White 10\'','L Corner White 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (121,'H Corner Burma Teak 10\'','H Corner Burma Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (122,'H Corner Burma Teak 4\'','H Corner Burma Teak 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (123,'H Corner Teak 10\'','H Corner Teak 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (124,'H Corner Teak 4\'','H Corner Teak 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (125,'H Corner White 10\'','H Corner White 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (126,'H Corner White 4\'','H Corner White 4\'','2019-03-02',1,1,5,7,5,48,0,'N/A'),
 (127,'Molding Dark 10\'','Molding Dark 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (128,'Molding Dark 10\'','Molding Dark 10\'','2019-03-02',1,0,5,7,5,120,0,'N/A'),
 (129,'U Corner Dark 10\'','U Corner Dark 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (130,'L Corner Dark 10\'','L Corner Dark 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A'),
 (131,'U Dark 10\'','U Dark 10\'','2019-03-02',1,0,5,7,5,120,0,'N/A'),
 (132,'H Corner Dark 10\'','H Corner Dark 10\'','2019-03-02',1,1,5,7,5,120,0,'N/A');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;


--
-- Definition of table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
CREATE TABLE `payment_type` (
  `idpayment_type` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpayment_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_type`
--

/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` (`idpayment_type`,`name`,`status`) VALUES 
 (1,'CREDIT',1),
 (2,'CASH',1),
 (3,'CHEQUE',1);
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;


--
-- Definition of table `purchase_invoice_order`
--

DROP TABLE IF EXISTS `purchase_invoice_order`;
CREATE TABLE `purchase_invoice_order` (
  `idpurchase_invoice_order` int(11) NOT NULL AUTO_INCREMENT,
  `total` double DEFAULT NULL,
  `po_date` varchar(45) DEFAULT NULL,
  `supplier` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `branch` int(11) NOT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpurchase_invoice_order`),
  KEY `fk_purchase_invoice_order_account1_idx` (`supplier`),
  KEY `fk_purchase_invoice_order_user1_idx` (`user_iduser`),
  KEY `fk_purchase_invoice_order_branch1_idx` (`branch`),
  CONSTRAINT `fk_purchase_invoice_order_account1` FOREIGN KEY (`supplier`) REFERENCES `account` (`idaccount`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_invoice_order_branch1` FOREIGN KEY (`branch`) REFERENCES `branch` (`idbranch`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_invoice_order_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchase_invoice_order`
--

/*!40000 ALTER TABLE `purchase_invoice_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_invoice_order` ENABLE KEYS */;


--
-- Definition of table `purchus_invoice`
--

DROP TABLE IF EXISTS `purchus_invoice`;
CREATE TABLE `purchus_invoice` (
  `idpurchus_invoice` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(45) DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `descount` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `paid` double DEFAULT NULL,
  `paible` double DEFAULT NULL,
  `return_amount` double DEFAULT NULL,
  `branch` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `supplier` int(11) NOT NULL,
  `payment_type` int(11) NOT NULL,
  `purchase_invoice_order` int(11) NOT NULL,
  `time` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpurchus_invoice`),
  KEY `fk_purchus_invoice_branch1_idx` (`branch`),
  KEY `fk_purchus_invoice_user1_idx` (`user`),
  KEY `fk_purchus_invoice_account1_idx` (`supplier`),
  KEY `fk_purchus_invoice_payment_type1_idx` (`payment_type`),
  KEY `fk_purchus_invoice_purchase_invoice_order1_idx` (`purchase_invoice_order`),
  CONSTRAINT `fk_purchus_invoice_account1` FOREIGN KEY (`supplier`) REFERENCES `account` (`idaccount`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchus_invoice_branch1` FOREIGN KEY (`branch`) REFERENCES `branch` (`idbranch`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchus_invoice_payment_type1` FOREIGN KEY (`payment_type`) REFERENCES `payment_type` (`idpayment_type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchus_invoice_purchase_invoice_order1` FOREIGN KEY (`purchase_invoice_order`) REFERENCES `purchase_invoice_order` (`idpurchase_invoice_order`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchus_invoice_user1` FOREIGN KEY (`user`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchus_invoice`
--

/*!40000 ALTER TABLE `purchus_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchus_invoice` ENABLE KEYS */;


--
-- Definition of table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `idsettings` int(11) NOT NULL,
  `name` varchar(155) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `email` varchar(155) DEFAULT NULL,
  `address` varchar(155) DEFAULT NULL,
  `image` varchar(455) DEFAULT NULL,
  PRIMARY KEY (`idsettings`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--

/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`idsettings`,`name`,`mobile`,`fax`,`email`,`address`,`image`) VALUES 
 (1,'SK','0665854215','065241785','sk@gmail.com','Kiridiwela','https://www.socwall.com/images/wallpapers/47737-1920x1080.jpg');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;


--
-- Definition of table `shortcut`
--

DROP TABLE IF EXISTS `shortcut`;
CREATE TABLE `shortcut` (
  `idshortcut` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `url` varchar(455) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user` int(11) NOT NULL,
  PRIMARY KEY (`idshortcut`),
  KEY `fk_shortcut_user1_idx` (`user`),
  CONSTRAINT `fk_shortcut_user1` FOREIGN KEY (`user`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shortcut`
--

/*!40000 ALTER TABLE `shortcut` DISABLE KEYS */;
INSERT INTO `shortcut` (`idshortcut`,`name`,`url`,`status`,`user`) VALUES 
 (1,'ITEM SETUP','itemlist.jsp',0,1);
/*!40000 ALTER TABLE `shortcut` ENABLE KEYS */;


--
-- Definition of table `sub_category`
--

DROP TABLE IF EXISTS `sub_category`;
CREATE TABLE `sub_category` (
  `subcategory_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL,
  PRIMARY KEY (`subcategory_id`),
  KEY `fk_sub_category_category1_idx` (`category`),
  CONSTRAINT `fk_sub_category_category1` FOREIGN KEY (`category`) REFERENCES `category` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sub_category`
--

/*!40000 ALTER TABLE `sub_category` DISABLE KEYS */;
INSERT INTO `sub_category` (`subcategory_id`,`name`,`status`,`category`) VALUES 
 (7,'2x2 Ceiling',1,7),
 (8,'Panel Ceiling',1,7);
/*!40000 ALTER TABLE `sub_category` ENABLE KEYS */;


--
-- Definition of table `text_list`
--

DROP TABLE IF EXISTS `text_list`;
CREATE TABLE `text_list` (
  `idtext_list` int(11) NOT NULL AUTO_INCREMENT,
  `test` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idtext_list`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `text_list`
--

/*!40000 ALTER TABLE `text_list` DISABLE KEYS */;
INSERT INTO `text_list` (`idtext_list`,`test`) VALUES 
 (2,'Comercial Bank'),
 (3,'People bank'),
 (4,'Peoples bank'),
 (5,'Sampath Bank'),
 (6,'NDB Bank'),
 (7,'Kirindiwela');
/*!40000 ALTER TABLE `text_list` ENABLE KEYS */;


--
-- Definition of table `third_category`
--

DROP TABLE IF EXISTS `third_category`;
CREATE TABLE `third_category` (
  `thirdcategory_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `sub_category` int(11) NOT NULL,
  PRIMARY KEY (`thirdcategory_id`),
  KEY `fk_third_category_sub_category1_idx` (`sub_category`),
  CONSTRAINT `fk_third_category_sub_category1` FOREIGN KEY (`sub_category`) REFERENCES `sub_category` (`subcategory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `third_category`
--

/*!40000 ALTER TABLE `third_category` DISABLE KEYS */;
INSERT INTO `third_category` (`thirdcategory_id`,`name`,`status`,`sub_category`) VALUES 
 (5,'2x2 Sheets',1,7),
 (6,'2x2 Grid',1,7),
 (7,'Sheets',1,8),
 (8,'Accessories',1,8);
/*!40000 ALTER TABLE `third_category` ENABLE KEYS */;


--
-- Definition of table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type`
--

/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` (`id`,`name`,`status`) VALUES 
 (1,'PIECE',1),
 (2,'TEST',1);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;


--
-- Definition of table `type_calc`
--

DROP TABLE IF EXISTS `type_calc`;
CREATE TABLE `type_calc` (
  `idtype_calc` int(11) NOT NULL AUTO_INCREMENT,
  `formula` varchar(250) DEFAULT NULL,
  `type_1` int(11) NOT NULL,
  `type_2` int(11) NOT NULL,
  `item` int(5) NOT NULL,
  PRIMARY KEY (`idtype_calc`),
  KEY `fk_type_calc_type1_idx` (`type_1`),
  KEY `fk_type_calc_type2_idx` (`type_2`),
  KEY `fk_type_calc_items1_idx` (`item`),
  CONSTRAINT `fk_type_calc_items1` FOREIGN KEY (`item`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_calc_type1` FOREIGN KEY (`type_1`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_calc_type2` FOREIGN KEY (`type_2`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type_calc`
--

/*!40000 ALTER TABLE `type_calc` DISABLE KEYS */;
/*!40000 ALTER TABLE `type_calc` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(155) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `branch` int(11) NOT NULL,
  PRIMARY KEY (`iduser`),
  KEY `fk_user_branch1_idx` (`branch`),
  CONSTRAINT `fk_user_branch1` FOREIGN KEY (`branch`) REFERENCES `branch` (`idbranch`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`iduser`,`name`,`contact`,`username`,`password`,`status`,`level`,`branch`) VALUES 
 (1,'Mayura Lakshan Ariyadasa','0714525487','admin','1234',1,1,1),
 (2,'Usha','703555355','Usha','U1234',1,1,2),
 (3,'Dilrukshi','0703558081','Dilrukshi','dil@chathu',1,1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
