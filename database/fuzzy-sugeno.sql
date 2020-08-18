/*
SQLyog Ultimate v9.50 
MySQL - 5.5.5-10.1.29-MariaDB : Database - sugeno
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sugeno` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `fuzzy-sugeno`;

/*Table structure for table `tb_admin` */

DROP TABLE IF EXISTS `tb_admin`;

CREATE TABLE `tb_admin` (
  `user` varchar(16) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `level` varchar(16) NOT NULL,
  PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_admin` */

insert  into `tb_admin`(`user`,`pass`,`level`) values ('admin','ADMIN','');

/*Table structure for table `tb_alternatif` */

DROP TABLE IF EXISTS `tb_alternatif`;

CREATE TABLE `tb_alternatif` (
  `kode_alternatif` varchar(16) NOT NULL,
  `nama_alternatif` varchar(255) NOT NULL,
  `keterangan` text NOT NULL,
  `total` double NOT NULL,
  `rank` int(11) NOT NULL,
  PRIMARY KEY (`kode_alternatif`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `tb_alternatif` */

insert  into `tb_alternatif`(`kode_alternatif`,`nama_alternatif`,`keterangan`,`total`,`rank`) values ('A1','Alternatif 1','',0,0),('A2','Alternatif 2','',0,0),('A3','Alternatif 3','',0,0);

/*Table structure for table `tb_himpunan` */

DROP TABLE IF EXISTS `tb_himpunan`;

CREATE TABLE `tb_himpunan` (
  `kode_himpunan` varchar(16) NOT NULL,
  `kode_kriteria` varchar(16) DEFAULT NULL,
  `nama_himpunan` varchar(255) DEFAULT NULL,
  `n1` double DEFAULT NULL,
  `n2` double DEFAULT NULL,
  `n3` double DEFAULT NULL,
  `n4` double DEFAULT NULL,
  PRIMARY KEY (`kode_himpunan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tb_himpunan` */

insert  into `tb_himpunan`(`kode_himpunan`,`kode_kriteria`,`nama_himpunan`,`n1`,`n2`,`n3`,`n4`) values ('C01-01','C01','Kurang',1,1,2,3),('C01-02','C01','Cukup',2,3,3,3.5),('C01-03','C01','Tinggi',3,3.5,4,4),('C02-01','C02','Sedikit',1000,1000,2000,2500),('C02-02','C02','Sedang',2000,2500,3000,3500),('C02-03','C02','Tinggi',3000,3500,4000,4500),('C02-04','C02','Sangat tinggi',4000,4500,5000,5000),('C03-01','C03','Kurang',60,60,65,70),('C03-02','C03','Cukup',65,70,70,80),('C03-03','C03','Rajin',75,80,100,100);

/*Table structure for table `tb_kriteria` */

DROP TABLE IF EXISTS `tb_kriteria`;

CREATE TABLE `tb_kriteria` (
  `kode_kriteria` varchar(16) NOT NULL,
  `nama_kriteria` varchar(255) NOT NULL,
  `batas_bawah` double NOT NULL,
  `batas_atas` double NOT NULL,
  PRIMARY KEY (`kode_kriteria`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `tb_kriteria` */

insert  into `tb_kriteria`(`kode_kriteria`,`nama_kriteria`,`batas_bawah`,`batas_atas`) values ('C01','IPK',1,4),('C02','Penghasilan Ortu (ribuan)',1000,5000),('C03','Presensi (%)',60,100);

/*Table structure for table `tb_rel_alternatif` */

DROP TABLE IF EXISTS `tb_rel_alternatif`;

CREATE TABLE `tb_rel_alternatif` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `kode_alternatif` varchar(16) DEFAULT NULL,
  `kode_kriteria` varchar(16) DEFAULT NULL,
  `nilai` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

/*Data for the table `tb_rel_alternatif` */

insert  into `tb_rel_alternatif`(`ID`,`kode_alternatif`,`kode_kriteria`,`nilai`) values (94,'A3','C02',3875),(93,'A2','C02',2200),(92,'A1','C02',2700),(89,'A3','C01',2.2),(88,'A2','C01',1.5),(87,'A1','C01',1),(99,'A3','C03',85),(98,'A2','C03',80),(97,'A1','C03',75);

/*Table structure for table `tb_rule` */

DROP TABLE IF EXISTS `tb_rule`;

CREATE TABLE `tb_rule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `aturan` longblob NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `tb_rule` */

insert  into `tb_rule`(`ID`,`aturan`) values (1,'a:36:{i:0;a:2:{s:5:\"nilai\";s:2:\"48\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-01\";}}i:1;a:2:{s:5:\"nilai\";s:2:\"49\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-02\";}}i:2;a:2:{s:5:\"nilai\";s:2:\"50\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-03\";}}i:3;a:2:{s:5:\"nilai\";s:2:\"51\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-01\";}}i:4;a:2:{s:5:\"nilai\";s:2:\"51\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-02\";}}i:5;a:2:{s:5:\"nilai\";s:2:\"52\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-03\";}}i:6;a:2:{s:5:\"nilai\";s:2:\"53\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-01\";}}i:7;a:2:{s:5:\"nilai\";s:2:\"54\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-02\";}}i:8;a:2:{s:5:\"nilai\";s:2:\"55\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-03\";}}i:9;a:2:{s:5:\"nilai\";s:2:\"56\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-01\";}}i:10;a:2:{s:5:\"nilai\";s:2:\"56\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-02\";}}i:11;a:2:{s:5:\"nilai\";s:2:\"57\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-01\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-03\";}}i:12;a:2:{s:5:\"nilai\";s:2:\"58\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-01\";}}i:13;a:2:{s:5:\"nilai\";s:2:\"59\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-02\";}}i:14;a:2:{s:5:\"nilai\";s:2:\"60\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-03\";}}i:15;a:2:{s:5:\"nilai\";s:2:\"61\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-01\";}}i:16;a:2:{s:5:\"nilai\";s:2:\"61\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-02\";}}i:17;a:2:{s:5:\"nilai\";s:2:\"62\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-03\";}}i:18;a:2:{s:5:\"nilai\";s:2:\"63\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-01\";}}i:19;a:2:{s:5:\"nilai\";s:2:\"64\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-02\";}}i:20;a:2:{s:5:\"nilai\";s:2:\"65\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-03\";}}i:21;a:2:{s:5:\"nilai\";s:2:\"66\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-01\";}}i:22;a:2:{s:5:\"nilai\";s:2:\"66\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-02\";}}i:23;a:2:{s:5:\"nilai\";s:2:\"67\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-02\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-03\";}}i:24;a:2:{s:5:\"nilai\";s:2:\"68\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-01\";}}i:25;a:2:{s:5:\"nilai\";s:2:\"69\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-02\";}}i:26;a:2:{s:5:\"nilai\";s:2:\"70\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-01\";s:3:\"C03\";s:6:\"C03-03\";}}i:27;a:2:{s:5:\"nilai\";s:2:\"71\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-01\";}}i:28;a:2:{s:5:\"nilai\";s:2:\"71\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-02\";}}i:29;a:2:{s:5:\"nilai\";s:2:\"72\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-02\";s:3:\"C03\";s:6:\"C03-03\";}}i:30;a:2:{s:5:\"nilai\";s:2:\"73\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-01\";}}i:31;a:2:{s:5:\"nilai\";s:2:\"74\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-02\";}}i:32;a:2:{s:5:\"nilai\";s:2:\"75\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-03\";s:3:\"C03\";s:6:\"C03-03\";}}i:33;a:2:{s:5:\"nilai\";s:2:\"76\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-01\";}}i:34;a:2:{s:5:\"nilai\";s:2:\"76\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-02\";}}i:35;a:2:{s:5:\"nilai\";s:2:\"77\";s:4:\"item\";a:3:{s:3:\"C01\";s:6:\"C01-03\";s:3:\"C02\";s:6:\"C02-04\";s:3:\"C03\";s:6:\"C03-03\";}}}');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
