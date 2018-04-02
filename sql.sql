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
  `status` varchar(50) DEFAULT 'draft' COMMENT '处理状态',
  `title` varchar(500) DEFAULT NULL COMMENT '任务名',
  `pageviews` varchar(50) DEFAULT NULL COMMENT '考查点',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='任务数据';

-- 正在导出表  test.list 的数据：~25 rows (大约)
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
REPLACE INTO `list` (`ID`, `author`, `exauthor`, `display_time`, `status`, `title`, `pageviews`) VALUES
	(1, 'admin', 'admin,CN', '2015-06-27', 'published', '内京放二12阿斯达斯', '抚州市'),
	(2, 'admin', 'admin', '2018-03-05', 'draft', '内京放二22', '禅城'),
	(3, '袁洋1', 'admin', '1982-02-17', 'published', '受术状划南2', '厦门市\r\n'),
	(4, 'admin', 'sa', '1982-02-17', 'published', '1', '南海'),
	(5, '袁洋3', '123', '1982-02-17', 'draft', '噶圣诞颂歌', '南海'),
	(6, '2', 'CN,123', '2006-06-03', 'published', 'self', '南海'),
	(7, '1', '123,CN', '1982-02-17', 'published', '3', '4'),
	(86, '我', '123,sa,CN', '2018-03-05', 'published', '请问', '南海'),
	(87, '321', 'CN,sa,123', '2018-03-05', 'draft', '12', '南海'),
	(89, '2', '123,CN,sa', '2018-03-05', 'published', '21', '南海'),
	(90, '2', 'sa,CN,123', '2018-03-05', 'published', '2', '南海'),
	(91, 'CN', 'admin', '2018-03-05', 'published', 'undefined', '南海'),
	(92, 'undefined', 'admin', '2018-03-05', 'published', '1', '南海'),
	(93, 'sa', 'admin', '2018-03-05', 'published', '123', '南海'),
	(94, 'sa', 'admin', '2018-03-05', 'published', '123', '南海'),
	(95, 'undefined', 'admin', '2018-03-05', 'draft', '', '南海'),
	(96, 'undefined', 'admin', '2018-03-05', 'draft', '', '南海'),
	(101, '3', 'admin', '2018-03-05', 'draft', '23', '南海'),
	(102, '2', 'admin', '2018-03-05', 'draft', '1', '南海'),
	(105, '3333', 'admin', '2018-03-06', 'draft', '2', '南海'),
	(106, 'undefined', 'admin', '2018-03-19', 'draft', '213', '南海');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;

-- 导出  表 test.login 结构
CREATE TABLE IF NOT EXISTS `login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户的id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户的帐号',
  `password` varchar(50) DEFAULT NULL COMMENT '用户的密码',
  `permission` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='登录表';

-- 正在导出表  test.login 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
REPLACE INTO `login` (`ID`, `user_name`, `password`, `permission`) VALUES
	(1, 'admin', 'admin1', 0),
	(2, 'sa', 'sa', 1),
	(3, '123', '123456', 1),
	(4, 'CN', 'cn', 1);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- 导出  表 test.msgform 结构
CREATE TABLE IF NOT EXISTS `msgform` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `mailbox` varchar(50) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `imageUrl` mediumblob,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='个人信息表';

-- 正在导出表  test.msgform 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `msgform` DISABLE KEYS */;
REPLACE INTO `msgform` (`ID`, `user_id`, `account`, `name`, `phone`, `mailbox`, `date1`, `resource`, `desc`, `imageUrl`) VALUES
	(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, _binary 0x7075626C69632F75706C6F6164732F5151E59BBEE7898732303138303130333131333532382E6A7067),
	(2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, _binary 0x7075626C69632F75706C6F6164732F5151E59BBEE7898732303138303130333131333532382E6A7067);
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='题目';

-- 正在导出表  test.question 的数据：~68 rows (大约)
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
REPLACE INTO `question` (`ID`, `selfid`, `title`, `type`, `radio`, `ceck`, `caseid`) VALUES
	(1, 0, '标题', 3, '', '', 1),
	(2, 0, '标题', 2, '北京,广州', '上海,北京,广州,深圳', 1),
	(3, 0, '标题', 1, '0', '', 1),
	(4, 0, '标题', 0, '', '', 1),
	(5, 0, '标题4', 3, '113123', '', 2),
	(6, 0, '标题3', 2, '北京', '上海,北京,广州,深圳', 2),
	(7, 0, '标题2', 1, '3', '', 2),
	(8, 0, '标题1', 0, '0', '', 2),
	(9, 0, '标题', 3, '', '', 3),
	(10, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 3),
	(11, 0, '标题', 1, '2', '', 3),
	(12, 0, '标题', 0, '1', '', 3),
	(13, 0, '标题', 3, '', '', 4),
	(14, 0, '标题', 2, '北京,深圳', '上海,北京,广州,深圳', 4),
	(15, 0, '标题', 1, '0', '', 4),
	(16, 0, '标题', 0, '', '', 4),
	(17, 0, '标题', 3, '', '', 90),
	(18, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 90),
	(19, 0, '标题', 1, '0', '', 90),
	(20, 0, '标题', 0, '', '', 90),
	(21, 0, '标题', 3, '', '', 86),
	(22, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 86),
	(23, 0, '标题', 1, '0', '', 86),
	(24, 0, '标题qwe', 0, '', '', 86),
	(25, 0, '标题', 3, '', '', 89),
	(26, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 89),
	(27, 0, '标题', 1, '0', '', 89),
	(28, 0, '标题', 0, '', '', 89),
	(29, 0, '标题', 3, '', '', 6),
	(30, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 6),
	(31, 0, '标题', 1, '0', '', 6),
	(32, 0, '标题', 0, '0', '', 6),
	(33, 0, '标题', 3, '', '', 91),
	(34, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 91),
	(35, 0, '标题', 1, '4', '', 91),
	(36, 0, '标题', 0, '0', '', 91),
	(37, 0, '标题', 3, '', '', 92),
	(38, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 92),
	(39, 0, '标题', 1, '0', '', 92),
	(40, 0, '标题', 0, '', '', 92),
	(41, 0, '标题', 3, '', '', 93),
	(42, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 93),
	(43, 0, '标题', 1, '0', '', 93),
	(44, 0, '标题', 0, '', '', 93),
	(45, 0, '标题', 3, '', '', 94),
	(46, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 94),
	(47, 0, '标题', 1, '0', '', 94),
	(48, 0, '标题', 0, '', '', 94),
	(49, 0, '标题', 3, '', '', 94),
	(50, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 94),
	(51, 0, '标题', 1, '0', '', 94),
	(52, 0, '标题', 0, '', '', 94),
	(53, 0, '标题', 3, '', '', 94),
	(54, 0, '标题', 2, '北京', '上海,北京,广州,深圳', 94),
	(55, 0, '标题', 1, '0', '', 94),
	(56, 0, '标题', 0, '', '', 94),
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
	(73, 1, 'moren4', 3, '', '', 7),
	(74, 1, 'moren3', 2, '上海', '上海,北京,广州,深圳', 7),
	(75, 1, 'moren2', 1, '0', '', 7),
	(76, 1, 'moren1', 0, '', '', 7);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
