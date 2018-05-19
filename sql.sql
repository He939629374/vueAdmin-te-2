-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.21-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.5.0.5264
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 test 的数据库结构
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test`;

-- 导出  表 test.list 结构
CREATE TABLE IF NOT EXISTS `list` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'list的ID',
  `author` varchar(50) DEFAULT NULL COMMENT '处理人',
  `exauthor` varchar(50) DEFAULT 'admin',
  `display_time` date DEFAULT NULL COMMENT '开始时间',
  `status` varchar(50) NOT NULL DEFAULT 'draft' COMMENT '处理状态',
  `title` varchar(500) DEFAULT NULL COMMENT '任务名',
  `pageviews` varchar(50) DEFAULT NULL COMMENT '考查点',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COMMENT='任务数据';

-- 正在导出表  test.list 的数据：~19 rows (大约)
DELETE FROM `list`;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` (`ID`, `author`, `exauthor`, `display_time`, `status`, `title`, `pageviews`) VALUES
	(1, 'admin', 'admin', '2015-06-27', 'published', '内京放二12阿斯达斯12', '南海'),
	(2, 'admin', 'sa,admin', '2018-03-05', 'draft', '内京放二22', '禅城'),
	(6, '123451', 'CN,123,123451', '2006-06-03', 'published', 'self', '南海'),
	(86, '123451', '123,sa,CN,我', '2018-03-05', 'published', '请问', '南海'),
	(87, '123451', 'CN,sa,123,321', '2018-03-05', 'published', '12', '南海'),
	(89, '2', '123,CN,sa', '2018-03-05', 'published', '21', '南海'),
	(90, '2', 'sa,CN,123', '2018-03-05', 'draft', '2', '南海'),
	(107, 'sa', 'admin,sa', '2018-05-14', 'published', 'ces', '南海'),
	(108, 'sa', 'admin,sa', '2018-05-14', 'published', 'sss', '南海'),
	(109, 'sa', 'admin', '2018-05-14', 'draft', 'sdada', '南海'),
	(110, 'sa', 'admin,sa', '2018-05-14', 'draft', 'dazxczc', '南海'),
	(111, '123451', 'admin,123451', '2018-05-17', 'published', 'cs', '南海'),
	(112, 'cn', 'admin', '2018-05-17', 'deleted', '321', '南海'),
	(113, 'aaa', 'admin', '2018-05-17', 'published', '123', '南海'),
	(114, 'admin', 'admin', '2018-05-17', 'draft', '123', '南海'),
	(115, 'sa', 'admin,sa', '2018-05-17', 'published', '12313', '南海'),
	(117, 'admin', 'admin', '2018-05-17', 'published', '1', '南海'),
	(118, '123451', 'admin,123451', '2018-05-17', 'published', '1', '南海'),
	(119, '123451', 'admin,123451', '2018-05-17', 'published', '3', '南海'),
	(120, 'admin', 'admin', '2018-05-18', 'draft', '1', '南海');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;

-- 导出  表 test.login 结构
CREATE TABLE IF NOT EXISTS `login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户的id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户的帐号',
  `password` varchar(50) DEFAULT NULL COMMENT '用户的密码',
  `permission` int(11) NOT NULL DEFAULT '1',
  `name` int(11) DEFAULT NULL,
  `phone` int(20) DEFAULT NULL,
  `mailbox` varchar(50) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `resource` char(10) DEFAULT '男',
  `descc` varchar(500) DEFAULT NULL,
  `imageUrl` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COMMENT='登录表';

-- 正在导出表  test.login 的数据：~6 rows (大约)
DELETE FROM `login`;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`ID`, `user_name`, `password`, `permission`, `name`, `phone`, `mailbox`, `date1`, `resource`, `descc`, `imageUrl`) VALUES
	(1, 'admin', 'admin1', 0, 0, NULL, NULL, '2018-05-24', '男', NULL, 'public/uploads/微信图片_20180426102414.jpg'),
	(2, 'sa', 'sa', 1, 0, 12306, '123qq.com', '2018-05-15', '女', '2222', NULL),
	(3, 'cn', 'CN', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'aaa', 'aaa', 0, 111, 1, '2', '2018-05-30', '女', '23112', NULL),
	(6, 'hjp', '111', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(400, '123451', '1', 0, 1, 312, '1232', '2018-05-31', '男', '阿斯达斯啊', 'public/uploads/QQ图片20180509110053.jpg');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- 导出  表 test.msgform 结构
CREATE TABLE IF NOT EXISTS `msgform` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` int(11) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` int(20) DEFAULT NULL,
  `mailbox` varchar(50) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `imageUrl` mediumblob,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人信息表';

-- 正在导出表  test.msgform 的数据：~0 rows (大约)
DELETE FROM `msgform`;
/*!40000 ALTER TABLE `msgform` DISABLE KEYS */;
/*!40000 ALTER TABLE `msgform` ENABLE KEYS */;

-- 导出  表 test.question 结构
CREATE TABLE IF NOT EXISTS `question` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `selfid` int(11) NOT NULL,
  `title` varchar(500) DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `radio` varchar(500) DEFAULT '0',
  `ceck` varchar(50) DEFAULT NULL,
  `caseid` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8 COMMENT='题目';

-- 正在导出表  test.question 的数据：~26 rows (大约)
DELETE FROM `question`;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`ID`, `selfid`, `title`, `type`, `radio`, `ceck`, `caseid`) VALUES
	(21, 0, '标题', 3, '', '', 86),
	(22, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 86),
	(23, 0, '标题', 1, '0', '', 86),
	(24, 0, '标题qwe', 0, '', '', 86),
	(57, 0, '标题', 3, '', '', 99),
	(58, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 99),
	(59, 0, '标题', 1, '0', '', 99),
	(60, 0, '标题', 0, '', '', 99),
	(61, 0, '标题', 3, '', '', 99),
	(62, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 99),
	(63, 0, '标题', 1, '0', '', 99),
	(64, 0, '标题', 0, '', '', 99),
	(65, 0, '标题', 3, '', '', 99),
	(66, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 99),
	(67, 0, '标题', 1, '0', '', 99),
	(68, 0, '标题', 0, '', '', 99),
	(214, 0, '标题', 0, '0', '', 0),
	(224, 1, 'moren', 0, '', '', 87),
	(235, 0, '标题', 0, '', '', 90),
	(248, 0, '标题', 0, '1', '', 6),
	(262, 1, 'moren', 3, '', '', 2),
	(263, 1, 'moren', 2, '上海', '上海,北京,广州,深圳', 2),
	(281, 1, 'moren', 0, '', '', 1),
	(282, 2, 'moren', 0, '', '', 1),
	(283, 3, 'moren', 0, '', '', 1),
	(284, 4, 'moren', 0, '', '', 1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
