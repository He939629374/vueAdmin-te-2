-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.21-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 test.list 结构
CREATE TABLE IF NOT EXISTS `list` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'list的ID',
  `author` varchar(50) DEFAULT NULL COMMENT '处理人',
  `display_time` date DEFAULT NULL COMMENT '开始时间',
  `status` varchar(50) DEFAULT 'draft' COMMENT '处理状态',
  `title` varchar(500) DEFAULT NULL COMMENT '任务名',
  `pageviews` varchar(50) DEFAULT NULL COMMENT '考查点',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='列表数据';

-- 正在导出表  test.list 的数据：~24 rows (大约)
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` (`ID`, `author`, `display_time`, `status`, `title`, `pageviews`) VALUES
	(1, '于杰2', '2015-06-27', 'published', '内京放二12阿斯达斯', '抚州市'),
	(2, '于杰11', '2018-03-05', 'draft', '内京放二22', '禅城'),
	(3, '袁洋1', '1982-02-17', 'deleted', '受术状划南2', '厦门市\r\n'),
	(4, '袁洋2', '1982-02-17', 'draft', '1', '南海'),
	(5, '袁洋3', '1982-02-17', 'published', '噶圣诞颂歌', '南海'),
	(6, '2', '2006-06-03', 'published', 'self', '南海'),
	(7, '1', '1982-02-17', 'published', '3', '4'),
	(86, '我', '2018-03-05', 'published', '请问', '南海'),
	(87, '321', '2018-03-05', 'published', '12', '南海'),
	(89, '2', '2018-03-05', 'published', '21', '南海'),
	(90, '2', '2018-03-05', 'published', '2', '南海'),
	(91, 'undefined', '2018-03-05', 'published', '', '南海'),
	(92, 'undefined', '2018-03-05', 'published', '', '南海'),
	(93, 'undefined', '2018-03-05', 'published', '', '南海'),
	(94, 'undefined', '2018-03-05', 'published', '', '南海'),
	(95, 'undefined', '2018-03-05', 'published', '', '南海'),
	(96, 'undefined', '2018-03-05', 'published', '', '南海'),
	(97, 'undefined', '2018-03-05', 'published', '', '南海'),
	(98, 'undefined', '2018-03-05', 'published', '', '南海'),
	(99, '2', '2018-03-05', 'published', '2', '南海'),
	(100, 'undefined', '2018-03-05', 'published', '', '南海'),
	(101, '3', '2018-03-05', 'published', '23', '南海'),
	(102, '2', '2018-03-05', 'published', '1', '南海'),
	(105, '3333', '2018-03-06', 'published', '2', '南海'),
	(106, 'undefined', '2018-03-19', 'published', '213', '南海');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;

-- 导出  表 test.login 结构
CREATE TABLE IF NOT EXISTS `login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户的id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户的帐号',
  `password` varchar(50) DEFAULT NULL COMMENT '用户的密码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='登录表';

-- 正在导出表  test.login 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`ID`, `user_name`, `password`) VALUES
	(1, 'admin', 'admin1'),
	(2, 'sa', 'sa'),
	(3, '123', '123456'),
	(4, 'CN', 'cn');
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
INSERT INTO `msgform` (`ID`, `user_id`, `account`, `name`, `phone`, `mailbox`, `date1`, `resource`, `desc`, `imageUrl`) VALUES
	(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, _binary 0x7075626C69632F75706C6F6164732F5151E59BBEE7898732303138303130333131333532382E6A7067),
	(2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, _binary 0x7075626C69632F75706C6F6164732F5151E59BBEE7898732303138303130333131333532382E6A7067);
/*!40000 ALTER TABLE `msgform` ENABLE KEYS */;

-- 导出  表 test.question 结构
CREATE TABLE IF NOT EXISTS `question` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `qtitle` varchar(50) NOT NULL DEFAULT '0',
  `qanswer` int(11) NOT NULL DEFAULT '0',
  `bz` int(11) DEFAULT '0',
  `caseid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='题目';

-- 正在导出表  test.question 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`ID`, `qtitle`, `qanswer`, `bz`, `caseid`) VALUES
	(1, '测试', 1, 0, 0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
