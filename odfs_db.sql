/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.24-MariaDB : Database - odfs_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`odfs_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `odfs_db`;

/*Table structure for table `category_list` */

DROP TABLE IF EXISTS `category_list`;

CREATE TABLE `category_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `category_list` */

insert  into `category_list`(`id`,`name`,`description`,`status`,`delete_flag`,`date_created`,`date_updated`) values 
(1,'PHP','PHP is an open-source server-side scripting language that many devs use for web development. It is also a general-purpose language that you can use to make lots of projects, including Graphical User Interfaces (GUIs).',1,1,'2022-05-16 10:02:41','2023-01-25 18:10:18'),
(2,'VB.NET','Visual Basic, originally called Visual Basic .NET, is a multi-paradigm, object-oriented programming language, implemented on .NET, Mono, and the .NET Framework. Microsoft launched VB.NET in 2002 as the successor to its original Visual Basic language.',1,1,'2022-05-16 10:03:27','2023-01-25 18:10:27'),
(3,'Python','Python is a high-level, interpreted, general-purpose programming language. Its design philosophy emphasizes code readability with the use of significant indentation. Python is dynamically-typed and garbage-collected.',1,1,'2022-05-16 10:03:48','2023-01-25 18:10:23'),
(4,'JavaScript','JavaScript, often abbreviated JS, is a programming language that is one of the core technologies of the World Wide Web, alongside HTML and CSS. Over 97% of websites use JavaScript on the client side for web page behavior, often incorporating third-party libraries.',1,1,'2022-05-16 10:04:11','2023-01-25 18:09:37'),
(5,'test','test',1,1,'2022-05-16 10:04:54','2022-05-16 10:04:59'),
(6,'Sesak Nafas','Sebuah Kondisi yang terjadi saat pernapasan terasa sulit, tidak nyaman, atau cepat',1,0,'2023-01-25 18:09:29','2023-01-25 18:09:29'),
(7,'Paru Paru Basah','Kondisi yang terjadi akibat peradangan pada salah satu atau kedua paru-paru. Umumnya, kondisi tersebut bisa terjadi karena terdapat infeksi, baik infeksi bakteri, virus, maupun jamur, pada paru-paru.',1,0,'2023-01-25 18:14:27','2023-01-25 18:14:27');

/*Table structure for table `comment_list` */

DROP TABLE IF EXISTS `comment_list`;

CREATE TABLE `comment_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `user_id` int(30) NOT NULL,
  `post_id` int(30) NOT NULL,
  `comment` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `post_id_fk_cl` FOREIGN KEY (`post_id`) REFERENCES `post_list` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk_cl` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `comment_list` */

insert  into `comment_list`(`id`,`user_id`,`post_id`,`comment`,`date_created`) values 
(1,4,2,'Test Comment 123','2022-05-16 12:05:21'),
(2,4,2,'<p>This is a sample comment only</p>','2022-05-16 13:00:42'),
(4,4,3,'<p>test 123</p>','2022-05-16 13:54:01'),
(6,4,2,'<p>is that real?</p>','2022-12-09 19:14:26'),
(9,1,5,'<p>Mungkin Berbeda, dilihat dari namanya juga berbeda</p>','2023-01-25 18:13:39'),
(10,6,5,'<p>masa si?</p>','2023-02-09 22:22:03');

/*Table structure for table `post_list` */

DROP TABLE IF EXISTS `post_list`;

CREATE TABLE `post_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `user_id` int(30) NOT NULL,
  `category_id` int(30) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `category_id_fk_tl` FOREIGN KEY (`category_id`) REFERENCES `category_list` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk_tl` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `post_list` */

insert  into `post_list`(`id`,`user_id`,`category_id`,`title`,`content`,`status`,`delete_flag`,`date_created`,`date_updated`) values 
(1,4,1,'Sample Topic Title','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur fringilla bibendum urna ac eleifend. Quisque in est eu ipsum blandit accumsan ultrices nec tortor. Aliquam lacinia, ex sit amet iaculis sollicitudin, urna odio tempor nulla, eu lacinia augue mi a felis. Quisque finibus in arcu sed ultricies. Duis eleifend metus consectetur vulputate bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut interdum libero vitae nisi finibus, non varius quam volutpat. Cras non iaculis neque. Integer bibendum sagittis dignissim. Ut aliquet suscipit velit sit amet hendrerit. Sed mattis pellentesque augue id bibendum. Phasellus quis justo ornare, faucibus arcu at, ullamcorper lectus.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Nulla a nisl quis tellus volutpat lacinia. Nullam et eros ac mi dapibus ornare. Suspendisse sit amet purus mattis, ullamcorper nulla sit amet, euismod urna. Fusce ac pulvinar velit. Vivamus tellus nibh, pretium eu consectetur et, hendrerit eu elit. Proin et augue ultricies, euismod augue a, varius nibh. Donec condimentum justo erat, non cursus mi pharetra vel. Cras pretium nulla quis justo venenatis, vitae aliquet justo dapibus. Maecenas efficitur viverra tellus, vestibulum pharetra est dictum at. Aenean mauris tellus, luctus vitae odio sit amet, sagittis faucibus nisl. Aliquam in dignissim sapien, nec sagittis lorem. Donec facilisis vulputate purus vitae congue. Nunc eros risus, congue id nisi nec, hendrerit tristique sem. Phasellus sodales nunc arcu, nec ultricies tellus tincidunt et.</p>',1,1,'2022-05-16 11:13:02','2023-01-25 18:09:56'),
(2,4,1,'Topic 2 - Updateds','<p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Quisque et commodo sem, sed aliquam justo. In varius erat purus, sit amet fermentum sapien semper sed. Quisque consequat blandit est eget gravida. Aliquam venenatis, libero eget hendrerit auctor, arcu dui interdum diam, ac hendrerit lacus eros ut sapien. Aenean commodo luctus metus eget vestibulum. Vestibulum nec convallis nulla, porttitor aliquet justo. In quis augue non ligula commodo tempus. Fusce ex ex, blandit sit amet lorem quis, pharetra aliquam leo. Mauris consequat vel mauris vitae consequat. Donec a enim ac erat malesuada varius non eget erat. Aliquam erat volutpat.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Fusce quis nisi at libero sodales pretium. Proin interdum, nisl quis ornare malesuada, nisi erat vestibulum nisi, nec egestas leo orci vel mauris. Ut quis varius orci. Vivamus nec vulputate purus. Sed ut magna euismod, accumsan arcu non, sagittis purus. Ut tempor elit at scelerisque eleifend. Morbi pharetra est in nibh eleifend, nec sagittis orci posuere. In malesuada, libero sit amet rutrum accumsan, quam leo ultricies augue, a maximus leo massa sit amet diam. Nunc dictum orci dui, vitae condimentum ex porta in. Ut sodales posuere mollis. Sed at sem pellentesque ligula commodo blandit. Ut sem velit, vulputate at porttitor vel, rutrum sit amet velit. Nunc ultrices, felis lacinia lobortis pharetra, purus quam porta massa, sed hendrerit arcu mi in magna. In dignissim urna sit amet mi pharetra, eu molestie libero rhoncus. Sed sit amet ipsum accumsan libero ullamcorper egestas.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Aliquam et tincidunt eros. Pellentesque ut luctus leo, nec fermentum velit. Vestibulum a justo et ligula hendrerit laoreet vitae et nunc. Pellentesque commodo dignissim justo, rutrum dictum est euismod vel. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc convallis arcu nec ullamcorper gravida. Phasellus ullamcorper nisi euismod tellus convallis, a aliquet ex commodo. Vivamus cursus elit purus, eu tristique lorem congue nec. Suspendisse tincidunt commodo purus, eget pharetra ipsum.</p><p style=\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px;\">Morbi cursus tincidunt ex vel elementum. Suspendisse et suscipit quam, vel interdum elit. Nullam mollis massa nisi, id consectetur nibh sodales vel. Pellentesque lobortis dignissim odio, vitae hendrerit dolor sollicitudin sit amet. Suspendisse ut leo id ex interdum ornare eget eu ex. Fusce laoreet erat in leo venenatis scelerisque. Aliquam laoreet sem ipsum, ac euismod justo egestas a. Ut facilisis posuere ante, sit amet tincidunt augue pretium vitae. Curabitur ullamcorper venenatis felis, ac pharetra velit varius vitae. Quisque et dignissim orci. Mauris non felis nec ligula posuere dignissim. Vivamus semper lacinia magna sed mollis. Maecenas a euismod lectus.</p>',1,1,'2022-05-16 11:25:21','2023-01-25 18:09:52'),
(3,4,2,'test','<p>Data to delete</p>',1,1,'2022-05-16 13:52:36','2022-05-16 13:54:05'),
(4,1,1,'test','<p>test</p>',1,1,'2022-05-16 14:11:24','2022-05-16 14:12:10'),
(5,1,6,'Saya Sedang Mengalami Sesak Nafas','<p>Saya mengalami sesak nafas sejak 2 minggu lalu, apakah gejalanya sama dengan TBC?</p>',1,0,'2023-01-25 18:11:57','2023-01-25 18:11:57'),
(6,6,7,'Sakit Dada','<p>Dada saya sakit, kira kira kenapa yaa?</p>',1,1,'2023-01-25 22:27:12','2023-01-25 22:28:51');

/*Table structure for table `system_info` */

DROP TABLE IF EXISTS `system_info`;

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `system_info` */

insert  into `system_info`(`id`,`meta_field`,`meta_value`) values 
(1,'name','Forum Diskusi TBC'),
(6,'short_name','Forum Diskusi TBC'),
(11,'logo','uploads/logo-tbc.png'),
(13,'user_avatar','uploads/user_avatar.jpg'),
(14,'cover','uploads/670_446_simak-begini-gaya-hidup-terbaik-penderita-tb-biar-cepat-sembuh_m_198788-560x352.jpeg');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='2';

/*Data for the table `users` */

insert  into `users`(`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`avatar`,`last_login`,`type`,`date_added`,`date_updated`) values 
(1,'Adminstrator','','Admin','admin','0192023a7bbd73250516f069df18b500','uploads/avatars/1.png?v=1649834664',NULL,1,'2021-01-20 14:02:37','2022-05-16 14:17:49'),
(4,'Mark','D','Cooper','mcooper','c7162ff89c647f444fcaa5c635dac8c3','uploads/avatars/4.png?v=1652667135',NULL,2,'2022-05-16 10:12:15','2022-05-16 13:44:49'),
(5,'John','D','Smith','jsmith','1254737c076cf867dc53d60a0364f38e',NULL,NULL,2,'2022-05-16 14:19:03','2022-05-16 14:19:03'),
(6,'ef','','hi','firman','a237ce27f9443772f9e6a810447454a2',NULL,NULL,2,'2023-01-10 21:55:51','2023-01-25 01:21:57'),
(7,'A','B','C','123','202cb962ac59075b964b07152d234b70',NULL,NULL,2,'2023-02-12 21:26:29','2023-02-12 21:26:29'),
(8,'A','B','C','firman123','7eda9a0d45d4dbfa99e06d4f402c2e67',NULL,NULL,2,'2023-02-12 21:26:49','2023-02-12 21:26:49'),
(9,'aa','bbb','cccc','firman1234','0827f1a9ef916a96d49dbd161f054cf6',NULL,NULL,2,'2023-02-12 21:27:36','2023-02-12 21:27:36'),
(10,'chan','dra','abdul','chandra123','b4a3f7314b7b5096b920a3a8c1ef0ac2',NULL,NULL,2,'2023-02-12 21:29:21','2023-02-12 21:29:21'),
(11,'ma','ma','ttt','mamattt123','a7c42c2920b734041a8e1ea38ce71c33',NULL,NULL,2,'2023-02-12 21:34:25','2023-02-12 21:34:25'),
(12,'su','lis','tyo','sulistyo','ea1d427f2a0bfdc5e448d0b2c1301ab0',NULL,NULL,2,'2023-02-12 21:36:27','2023-02-12 21:36:27'),
(13,'su','tar','man','sutarman','8d410ac552b55a7ddf020c475f99296d',NULL,NULL,2,'2023-02-12 21:37:04','2023-02-12 21:37:04');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
