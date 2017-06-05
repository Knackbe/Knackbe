-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2017 at 07:14 PM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `talentdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddComment`(IN `postitemid` INT, IN `comments` VARCHAR(100), IN `userId` INT, IN `userip` INT)
    NO SQL
INSERT INTO `timelinepostscomments`(`postitemid`, `comments`, `userId`, `datecreated`, `userip`, `isdeleted`)
VALUES (postitemid,comments, userId,CURDATE() , userip,0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddTimelinePost`(IN `UserId` INT(9), IN `Description` VARCHAR(1000), IN `UserIp` INT(9))
    NO SQL
BEGIN

INSERT INTO `timelineposts`
(`description`, `userId`, `datecreated`, `userip`, `isdelete`)
VALUES (Description,UserId,CURDATE(),UserIp,0);


select  LAST_INSERT_ID() PostId ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddTimelinePostItem`(IN `timelinepostsid` INT(9), IN `posttypeid` INT(9), IN `filepath` VARCHAR(4000), IN `decription` VARCHAR(4000))
    NO SQL
INSERT INTO `timelinepostsitems` 
(`timelinepostsid`, `posttypeid`,`filepath`, `decription`, `isdelete`)
VALUES ( timelinepostsid, posttypeid, filepath, decription, 1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddUser`(IN `FirstName` VARCHAR(4000), IN `EmailId` VARCHAR(1000), IN `Mobile` VARCHAR(12), IN `Password` VARCHAR(1000), IN `Gender` VARCHAR(10))
    NO SQL
    COMMENT 'Add User for Register user/New Signup user'
Insert into users (FirstName,Mobile,EmailId,Password,gender)
values (FirstName,Mobile,EmailId,Password,gender);$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spCheckIsEmailIdExists`(IN `PEmailId` VARCHAR(50))
    COMMENT 'Userd For Check email id exists or not'
BEGIN

select count(id) rowCount from users where EmailId=PEmailId ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spCheckIsMobileNoExists`(IN `Mobile` INT)
BEGIN

if exists (select id from users where Mobile=Mobile LIMIT 1) then
		select 1 as rowCount;
else
	 	select 0 as rowCount;
end if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spCheckIsUserNameExists`(IN `UserName` INT)
BEGIN

if exists (select id from users where UserName=UserName LIMIT 1) then
		select 1 as result;
else
	 	select 0 as result;
end if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAllUser`()
    NO SQL
    DETERMINISTIC
    COMMENT 'Get All User list Details'
SELECT 
         u.Id, 
         u.FirstName,
         u.MiddleName,
         u.LastName, 
         u.Address1, 
         u.Address2, 
         u.City, 
         u.State,
         u.Country,
         u.PinCode, 
         u.Mobile,
         u.LandLine,
         u.EmailId, 
         u.EmailId1, 
         u.Gender, 
         u.DateOfBirth, 
         u.Active,
         r.Id as RoleId,
         r.Name as RoleName,
         r.Description as RoleDesc,
         IFNULL(upp.Path,'uploads/profile/default_user.jpg') as ProfilePicPath
         
from users u	
	 left join userrole on userrole.UserId = u.Id	
     left join roles as r on userrole.UserId = r.Id 
     left join userprofilepic as upp on upp.UserId = u.Id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetTimelinePost`()
    NO SQL
SELECT * 
from timelineposts inner JOIN users on timelineposts.userId=users.Id
     inner join userprofilepic on userprofilepic.UserId=users.Id
order by timelineposts.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetTimelinePostItem`(IN `timelinepostsid` INT)
    NO SQL
BEGIN

SELECT * 
from timelinepostsitems  WHERE timelinepostsitems.timelinepostsid=timelinepostsid;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetTimelinePostItemComment`(IN `postitemid` INT)
    NO SQL
SELECT * 
from timelinepostscomments 
INNER join userprofilepic on timelinepostscomments.userId=userprofilepic.UserId
INNER join users on timelinepostscomments.userId=users.Id
where timelinepostscomments.postitemid=postitemid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUser`(IN `Id` INT)
    NO SQL
SELECT 
         u.Id, 
         u.FirstName,
         u.MiddleName,
         u.LastName, 
         u.Address1, 
         u.Address2, 
         u.City, 
         u.State,
         u.Country,
         u.PinCode, 
         u.Mobile,
         u.LandLine,
         u.EmailId, 
         u.EmailId1, 
         u.Gender, 
         u.DateOfBirth, 
         u.Active,
         r.Id as RoleId,
         r.Name as RoleName,
         r.Description as RoleDesc,
         IFNULL(upp.Path,'uploads/profile/default_user.jpg') as ProfilePicPath
         
from users u	
	 left join userrole on userrole.UserId = u.Id	
     left join roles as r on userrole.UserId = r.Id 
     left join userprofilepic as upp on upp.UserId = u.Id
where u.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spValidateUser`(IN `UserName` VARCHAR(100), IN `Password` VARCHAR(100))
    NO SQL
BEGIN


SELECT 
         u.Id, 
         u.FirstName,
         u.MiddleName,
         u.LastName, 
         u.Address1, 
         u.Address2, 
         u.City, 
         u.State,
         u.Country,
         u.PinCode, 
         u.Mobile,
         u.LandLine,
         u.EmailId, 
         u.EmailId1, 
         u.Gender, 
         u.DateOfBirth, 
         u.Active,
         r.Id as RoleId,
         r.Name as RoleName,
         r.Description as RoleDesc,
         IFNULL(upp.Path,'uploads/profile/default_user.jpg') as ProfilePicPath
         
from users u	
	 left join userrole on userrole.UserId = u.Id	
     left join roles as r on userrole.UserId = r.Id 
     left join userprofilepic as upp on upp.UserId = u.Id
where u.EmailId=UserName and u.Password=Password;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accounttype`
--

CREATE TABLE IF NOT EXISTS `accounttype` (
  `ID` int(11) NOT NULL,
  `AccountName` varchar(50) NOT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounttype`
--

INSERT INTO `accounttype` (`ID`, `AccountName`, `Description`) VALUES
(1, 'Individual', 'Individual'),
(2, 'Fan', 'Fan'),
(3, 'Business', 'Business'),
(4, 'Band or Group', 'Band or Group');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `ID` int(11) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `UserName`, `Password`) VALUES
(1, 'admin', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `adminuser`
--

CREATE TABLE IF NOT EXISTS `adminuser` (
  `ID` int(11) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `UserTypeID` int(50) NOT NULL,
  `IsActive` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser`
--

INSERT INTO `adminuser` (`ID`, `UserName`, `Password`, `UserTypeID`, `IsActive`) VALUES
(1, 'suraj', '12345', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('e2a62e780bd3ba4322331860194c472228347670', '::1', 1491685962, 0x5f5f63695f6c6173745f726567656e65726174657c693a313439313638353936323b),
('1bfd5f1ad0944950ada7133ca00e8ccbc9aef845', '::1', 1491686842, 0x5f5f63695f6c6173745f726567656e65726174657c693a313439313638363834323b),
('bf684c6e831aa75b34e3822264ecbc99d0f51a71', '::1', 1491718479, 0x5f5f63695f6c6173745f726567656e65726174657c693a313439313731383437393b),
('9b283ad6b596ccd21648d4147587a2c823721f22', '::1', 1491719519, 0x5f5f63695f6c6173745f726567656e65726174657c693a313439313731393531393b),
('bd09fde1cb6f6b2668bc1d4c6ad0205006848229', '::1', 1491719883, 0x5f5f63695f6c6173745f726567656e65726174657c693a313439313731393838333b);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL,
  `country` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country`) VALUES
(1, 'Albania'),
(2, 'Algeria'),
(3, 'Andorra'),
(4, 'Angola'),
(5, 'Anguilla'),
(6, 'Antarctica'),
(7, 'Antigua'),
(8, 'Antilles'),
(9, 'Argentina'),
(10, 'Armenia'),
(11, 'Aruba'),
(12, 'Australia'),
(13, 'Austria'),
(14, 'Azerbaijan'),
(15, 'Bahamas'),
(16, 'Bangladesh'),
(17, 'Barbados'),
(18, 'Belarus'),
(19, 'Belgium'),
(20, 'Belize'),
(21, 'Benin'),
(22, 'Bermuda'),
(23, 'Bhutan'),
(24, 'Bolivia'),
(25, 'Bosnia'),
(26, 'Botswana'),
(27, 'Brazil'),
(28, 'Brunei'),
(29, 'Bulgaria'),
(30, 'Burkina Faso'),
(31, 'Burundi'),
(32, 'Cambodia'),
(33, 'Cameroon'),
(34, 'Canada'),
(35, 'Cape Verde'),
(36, 'Cayman Islands'),
(37, 'Central Africa'),
(38, 'Chad'),
(39, 'Chile'),
(40, 'China'),
(41, 'Colombia'),
(42, 'Comoros'),
(43, 'Congo'),
(44, 'Cook Islands'),
(45, 'Costa Rica'),
(46, 'Cote D''Ivoire'),
(47, 'Croatia'),
(48, 'Cuba'),
(49, 'Cyprus'),
(50, 'Czech Republic'),
(51, 'Denmark'),
(52, 'Djibouti'),
(53, 'Dominica'),
(54, 'Dominican Rep.'),
(55, 'Ecuador'),
(56, 'Egypt'),
(57, 'El Salvador'),
(58, 'Eritrea'),
(59, 'Estonia'),
(60, 'Ethiopia'),
(61, 'Fiji'),
(62, 'Finland'),
(63, 'Falkland Islands'),
(64, 'France'),
(65, 'Gabon'),
(66, 'Gambia'),
(67, 'Georgia'),
(68, 'Germany'),
(69, 'Ghana'),
(70, 'Gibraltar'),
(71, 'Greece'),
(72, 'Greenland'),
(73, 'Grenada'),
(74, 'Guam'),
(75, 'Guatemala'),
(76, 'Guiana'),
(77, 'Guinea'),
(78, 'Guyana'),
(79, 'Haiti'),
(80, 'Hondoras'),
(81, 'Hong Kong'),
(82, 'Hungary'),
(83, 'Iceland'),
(84, 'India'),
(85, 'Indonesia'),
(86, 'Iran'),
(87, 'Iraq'),
(88, 'Ireland'),
(89, 'Israel'),
(90, 'Italy'),
(91, 'Jamaica'),
(92, 'Japan'),
(93, 'Jordan'),
(94, 'Kazakhstan'),
(95, 'Kenya'),
(96, 'Kiribati'),
(97, 'Korea'),
(98, 'Kyrgyzstan'),
(99, 'Lao'),
(100, 'Latvia'),
(101, 'Lesotho'),
(102, 'Liberia'),
(103, 'Liechtenstein'),
(104, 'Lithuania'),
(105, 'Luxembourg'),
(106, 'Macau'),
(107, 'Macedonia'),
(108, 'Madagascar'),
(109, 'Malawi'),
(110, 'Malaysia'),
(111, 'Maldives'),
(112, 'Mali'),
(113, 'Malta'),
(114, 'Marshal Islands'),
(115, 'Martinique'),
(116, 'Mauritania'),
(117, 'Mauritius'),
(118, 'Mayotte'),
(119, 'Mexico'),
(120, 'Micronesia'),
(121, 'Moldova'),
(122, 'Monaco'),
(123, 'Mongolia'),
(124, 'Montserrat'),
(125, 'Morocco'),
(126, 'Mozambique'),
(127, 'Myanmar'),
(128, 'Namibia'),
(129, 'Nauru'),
(130, 'Nepal'),
(131, 'Netherlands'),
(132, 'New Caledonia'),
(133, 'New Guinea'),
(134, 'New Zealand'),
(135, 'Nicaragua'),
(136, 'Nigeria'),
(137, 'Niue'),
(138, 'Norfolk Island'),
(139, 'Norway'),
(140, 'Palau'),
(141, 'Panama'),
(142, 'Paraguay'),
(143, 'Peru'),
(144, 'Puerto'),
(145, 'Philippines'),
(146, 'Poland'),
(147, 'Polynesia'),
(148, 'Portugal'),
(149, 'Romania'),
(150, 'Russia'),
(151, 'Rwanda'),
(152, 'Saint Lucia'),
(153, 'Samoa'),
(154, 'San Marino'),
(155, 'Senegal'),
(156, 'Seychelles'),
(157, 'Sierra Leone'),
(158, 'Singapore'),
(159, 'Slovakia'),
(160, 'Slovenia'),
(161, 'Somalia'),
(162, 'South Africa'),
(163, 'Spain'),
(164, 'Sri Lanka'),
(165, 'St. Helena'),
(166, 'Sudan'),
(167, 'Suriname'),
(168, 'Swaziland'),
(169, 'Sweden'),
(170, 'Switzerland'),
(171, 'Taiwan'),
(172, 'Tajikistan'),
(173, 'Tanzania'),
(174, 'Thailand'),
(175, 'Togo'),
(176, 'Tokelau'),
(177, 'Tonga'),
(178, 'Trinidad'),
(179, 'Tunisia'),
(180, 'Turkey'),
(181, 'Uganda'),
(182, 'Ukraine'),
(183, 'United Kingdom'),
(184, 'United States'),
(185, 'Uruguay'),
(186, 'Uzbekistan'),
(187, 'Vanuatu'),
(188, 'Venezuela'),
(189, 'Vietnam'),
(190, 'Virgin Islands'),
(191, 'Yugoslavia'),
(192, 'Zaire'),
(193, 'Zambia'),
(194, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `coverphoto`
--

CREATE TABLE IF NOT EXISTS `coverphoto` (
  `id` int(11) NOT NULL,
  `imgname` text NOT NULL,
  `doe` datetime NOT NULL,
  `userid` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coverphoto`
--

INSERT INTO `coverphoto` (`id`, `imgname`, `doe`, `userid`) VALUES
(1, '1457249728_img', '2016-03-06 08:35:00', '1'),
(2, '1457335230_img', '2016-03-07 08:20:00', '1'),
(3, '1457352872_img', '2016-03-07 01:14:00', '1'),
(4, '1457358738_img', '2016-03-07 02:52:00', '1'),
(5, '1457598492_img', '2016-03-10 09:28:00', '24'),
(6, '1457686264_img', '2016-03-11 09:51:00', '88'),
(7, '1457783287_img', '2016-03-12 12:48:00', '85'),
(8, '1458112701_img', '2016-03-16 08:18:00', '215');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login123`
--

CREATE TABLE IF NOT EXISTS `login123` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Login Master (Login123) ';

--
-- Dumping data for table `login123`
--

INSERT INTO `login123` (`ID`, `UserID`, `UserName`, `Password`, `Active`) VALUES
(1, 1, 'aa', 'aa', 1),
(2, 2, 'aa', 'aa', 1);

-- --------------------------------------------------------

--
-- Table structure for table `posttype`
--

CREATE TABLE IF NOT EXISTS `posttype` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `profilephoto`
--

CREATE TABLE IF NOT EXISTS `profilephoto` (
  `id` int(11) NOT NULL,
  `imgname` text NOT NULL,
  `doe` datetime NOT NULL,
  `userid` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profilephoto`
--

INSERT INTO `profilephoto` (`id`, `imgname`, `doe`, `userid`) VALUES
(0, '1457249720_img', '2016-03-06 08:35:00', '1'),
(0, '1457249736_img', '2016-03-06 08:35:00', '1'),
(0, '1457335212_img', '2016-03-07 08:20:00', '1'),
(0, '1457358716_img', '2016-03-07 02:51:00', '1'),
(0, '1457523463_img', '2016-03-09 12:37:00', '1'),
(0, '1457598004_img', '2016-03-10 09:20:00', '24'),
(0, '1457686249_img', '2016-03-11 09:50:00', '88'),
(0, '1457765764_img', '2016-03-12 07:56:00', '85'),
(0, '1457877025_img', '2016-03-13 02:50:00', '186'),
(0, '1457877612_img', '2016-03-13 03:00:00', '188'),
(0, '1457877722_img', '2016-03-13 03:02:00', '190'),
(0, '1457877904_img', '2016-03-13 03:05:00', '191'),
(0, '1458111700_img', '2016-03-16 08:01:00', '215'),
(0, '1458165071_img', '2016-03-16 10:51:00', '85'),
(0, '1458502937_img', '2016-03-20 08:42:00', '85');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `Id` int(11) NOT NULL,
  `Name` varchar(1000) NOT NULL,
  `Description` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`Id`, `Name`, `Description`) VALUES
(1, 'Admin', 'Admin'),
(2, 'Staff', 'staff');

-- --------------------------------------------------------

--
-- Table structure for table `talent`
--

CREATE TABLE IF NOT EXISTS `talent` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `TypeId` int(11) DEFAULT NULL,
  `Description` varchar(2000) NOT NULL,
  `ImageUrl` varchar(200) DEFAULT NULL,
  `Active` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `talent`
--

INSERT INTO `talent` (`Id`, `Name`, `TypeId`, `Description`, `ImageUrl`, `Active`) VALUES
(1, 'Music', 1, 'testing Please as', '', 1),
(2, 'bike', 6, 'Description', '', 1),
(3, 'networking', 3, 'Description', '', 1),
(4, 'Educational', 8, 'Educational', '', 1),
(5, 'Test please', 1, 'test', '', 1),
(6, 'Test please', 7, 'testing Please s', '', 1),
(7, 'Test please ll', 6, 'testing Please', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `talenttype`
--

CREATE TABLE IF NOT EXISTS `talenttype` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(1000) NOT NULL,
  `ImageUrl` varchar(200) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `talenttype`
--

INSERT INTO `talenttype` (`Id`, `Name`, `Description`, `ImageUrl`, `Active`) VALUES
(1, 'Art And Culture', 'Description', 'Disha.jpg', 1),
(2, 'Agriculture', 'Description', '', 0),
(3, 'ITComputer', 'Description', '', 1),
(4, 'Sport', 'Sport', 'disha-patani-8a.jpg', 1),
(5, 'Mechanical', 'Description', '', 1),
(6, 'Automoblie', 'ds', '', 1),
(7, 'Transport', 'asasas', '', 1),
(8, 'Health & care', 'Description', '', 1),
(9, 'Education', 'Education', '2jySumD.jpg', 1),
(10, 'test 1', 'Sport', '', 1),
(11, 'we Can', 'we', '2jySumD.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `timelineposts`
--

CREATE TABLE IF NOT EXISTS `timelineposts` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `userId` int(11) NOT NULL,
  `datecreated` datetime NOT NULL,
  `userip` varchar(200) NOT NULL,
  `isdelete` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `timelineposts`
--

INSERT INTO `timelineposts` (`id`, `description`, `userId`, `datecreated`, `userip`, `isdelete`) VALUES
(1, '', 0, '2017-01-22 00:00:00', '2147483647', 0),
(2, '', 0, '2017-01-22 00:00:00', '2147483647', 0),
(3, '', 0, '2017-01-22 00:00:00', '2147483647', 0),
(4, '', 1, '2017-01-22 00:00:00', '2147483647', 0),
(5, '', 0, '2017-04-08 00:00:00', '2147483647', 0),
(6, '', 0, '2017-04-29 00:00:00', '2147483647', 0);

-- --------------------------------------------------------

--
-- Table structure for table `timelinepostscomments`
--

CREATE TABLE IF NOT EXISTS `timelinepostscomments` (
  `id` int(11) NOT NULL,
  `postitemid` int(11) DEFAULT NULL,
  `comments` text,
  `userId` int(11) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `userip` varchar(200) DEFAULT NULL,
  `isdeleted` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `timelinepostsitems`
--

CREATE TABLE IF NOT EXISTS `timelinepostsitems` (
  `id` int(11) NOT NULL,
  `timelinepostsid` int(11) NOT NULL,
  `posttypeid` int(11) NOT NULL,
  `decription` varchar(128) NOT NULL,
  `filepath` varchar(128) NOT NULL COMMENT 'file Name Must Combination of Id + userid',
  `isdelete` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `timelinepostsitems`
--

INSERT INTO `timelinepostsitems` (`id`, `timelinepostsid`, `posttypeid`, `decription`, `filepath`, `isdelete`) VALUES
(1, 0, 1, '', 'uploads/timeline/Lighthouse.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `timelinepostslike`
--

CREATE TABLE IF NOT EXISTS `timelinepostslike` (
  `id` int(11) NOT NULL,
  `postitemid` int(11) DEFAULT NULL,
  `Islike` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `userip` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user123`
--

CREATE TABLE IF NOT EXISTS `user123` (
  `ID` int(11) NOT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `MiddleName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Hometown` varchar(200) DEFAULT NULL,
  `currentCity` varchar(200) DEFAULT NULL,
  `Address3` varchar(200) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `PinCode` int(11) DEFAULT NULL,
  `Mobile` varchar(50) DEFAULT NULL,
  `LandLine` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `EmailId1` varchar(100) DEFAULT NULL,
  `Gender` varchar(11) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `EmailVerificationCode` varchar(45) DEFAULT NULL,
  `IsEmailVerified` tinyint(1) DEFAULT NULL,
  `IsFirstLogin` tinyint(1) DEFAULT NULL,
  `IsDeleted` tinyint(1) DEFAULT NULL,
  `domain` varchar(20) NOT NULL,
  `subdomain` varchar(40) NOT NULL,
  `Company` text NOT NULL,
  `Designition` text NOT NULL,
  `companyCity` text NOT NULL,
  `regdate` date NOT NULL,
  `profile_img` text NOT NULL,
  `cover_img` text NOT NULL,
  `account_type` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user123`
--

INSERT INTO `user123` (`ID`, `FirstName`, `MiddleName`, `LastName`, `Hometown`, `currentCity`, `Address3`, `City`, `State`, `Country`, `PinCode`, `Mobile`, `LandLine`, `EmailId`, `EmailId1`, `Gender`, `DateOfBirth`, `Active`, `EmailVerificationCode`, `IsEmailVerified`, `IsFirstLogin`, `IsDeleted`, `domain`, `subdomain`, `Company`, `Designition`, `companyCity`, `regdate`, `profile_img`, `cover_img`, `account_type`) VALUES
(85, 'Supriya', '', 'Patil', '', 'kfffffffffffff', NULL, NULL, NULL, NULL, NULL, '9876543210', NULL, '', NULL, NULL, '2007-05-26', 1, '6d1bb8ee1ab13c7582e2aaa61d1c6fb8', NULL, 1, NULL, '1', '3', 'kkkkkkkkkkkkkkkkkkkkkkkkkkkk', 'dxgdfse', 'dgfdgdg', '2016-03-11', '1458502937_img', '1457783287_img', '0'),
(96, 'Supriya', NULL, 'p', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9876543212', NULL, '', NULL, NULL, '0000-00-00', 1, '0f1abdc8620d9d56d010765f947f68a0', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(97, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9512364778', NULL, '', NULL, NULL, '2006-04-02', 1, '2ea3b3c9ff03b0f0394ebca4d0561ea9', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(98, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9512368745', NULL, '', NULL, NULL, '2002-00-00', 1, '1ec8b5703ab5a17fd0dcf977bcec024b', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(101, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7896543210', NULL, '', NULL, NULL, '1990-04-16', 1, '3d21ec0d38bc9cc206d0ce6c9a11e3b5', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(112, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7896541230', NULL, '', NULL, NULL, '0000-00-00', 1, 'b493c59459220ded593424c0fd484ffb', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(119, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9510000000', NULL, '', NULL, NULL, '0000-00-00', 1, 'b0f7f8f5da09776774f0c840cc0562c7', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(122, 'raviraj', NULL, 'salunkhe', NULL, NULL, NULL, '', '', '', NULL, '', NULL, 'ravirajsalunkhe111@gmail.com', NULL, 'Male', '2012-03-02', 1, '43d1149d2d87b5005fe2b7917288735c', NULL, 1, NULL, '2', '1', '', '', '', '2016-03-12', '', '', '0'),
(123, 'Ravindra', NULL, 'Salunkhe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ravirajsalunkhe111@gmail.co', NULL, NULL, '2002-02-14', 1, '44b4e29377a49d5fa6cb331f59a29869', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', ''),
(124, 'Ravindra', NULL, 'Salunkhe', NULL, NULL, NULL, '', '', '', NULL, '', NULL, 'ravirajsalunkhe11@gmail.com', NULL, '', '0000-00-00', 1, 'bc89d28229a288d916552dd2c75efe61', NULL, 1, NULL, '', '', '', '', '', '2016-03-12', '', '', '0'),
(132, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '95123612345', NULL, '', NULL, NULL, '0000-00-00', 1, 'e5bffaad9c3491479fa02496a44e2d87', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(141, 'qe', NULL, 'erff', NULL, NULL, NULL, '', '', '', NULL, '998887774445', NULL, '', NULL, 'Female', '1990-04-26', 1, 'a1692e4bf73e920d33a01d7f3cb71488', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', '0'),
(142, 'fddfd', NULL, 'dddddff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'f.ff@gmail.com', NULL, 'Male', '2002-07-18', 1, '2bfc06856ba28c2e3156bc6aefe7df87', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(143, 'Pooja', NULL, 'Mali', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '85225885225', NULL, '', NULL, 'Female', '2002-04-04', 1, 'dac9759ec5b79f7928dee3a1d5d33674', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(144, 'wgauri', NULL, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '85214774120', NULL, '', NULL, 'Female', '1990-04-26', 1, 'c4ffa78b7476f44c62e5e26b5df211e8', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(145, 'snehal', NULL, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9544444444', NULL, '', NULL, 'Female', '1990-04-26', 1, '2159a84c2a2e8f0e4531a516e9e7f854', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(146, 'sup', NULL, 'wer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9512522222', NULL, '', NULL, 'Female', '1990-04-26', 1, 'e77da3a4a74dd8658987751293f6541c', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(147, 'prajakta', NULL, 'P', NULL, NULL, NULL, 'karad', 'Maharashra', '84', NULL, '9658742310', NULL, '', NULL, 'Female', '2004-04-15', 1, '19ec1cafb1152034f331f7301a5f5382', NULL, 1, NULL, '1', '1', '', '', '', '2016-03-13', '', '', '0'),
(148, 'dsfdf', NULL, 'dgdg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8654444444', NULL, '', NULL, 'Female', '1999-04-26', 1, '5359c5730c2c25224b732de348a857f3', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(149, 'sadd', NULL, 'asdasd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'asd@sad.ghf', NULL, '0', '1988-05-15', 1, '7f661dd511707da800652e7697fac3c0', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(150, 'ssddssd', NULL, 'jsdfkjnf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'klasjkl@dklgjkld.com', NULL, 'Female', '0000-07-11', 1, '7e87e0ba76038498070a7eccd6ece83a', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(151, 'gygjh', NULL, 'hg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhg@jhgjh.com', NULL, 'Female', '1990-04-26', 1, '53d4785a9403b08783652a375b1cae37', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(152, 'sup', NULL, 'patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sp@ggg.com', NULL, 'Female', '1999-09-06', 1, '61da00d5a87495a7aa9b1c28296def8f', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(153, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9512666778', NULL, '', NULL, 'Female', '2003-06-17', 1, '100593fc30d375628de7f9047cee166f', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(154, 's', NULL, 'k', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sk@gmail.com', NULL, 'Female', '1999-04-29', 1, 'c71daf88768bf96b92cb71d992de11bd', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(155, 'Supriya', NULL, 'Patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ks@gmail.com', NULL, 'Female', '1998-04-18', 1, '03139c1887d59f129e18a83244d11524', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(156, 'sneha', NULL, 'patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sneha@gmail.con', NULL, 'Female', '1999-04-26', 1, '987ae4e2ae777faa8e95419b5ae7cf65', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(157, 'sup', NULL, 'o', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'oo@oo.com', NULL, '', '2016-02-06', 1, 'a1b44f7012e44778ef6f7cb64b0ce87b', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(158, 'yggh', NULL, 'hgjh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhg@jhh.com', NULL, 'Female', '1999-04-26', 1, 'd13835e9028970f81d75405776f441cf', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(159, 'likhjkhjk', NULL, 'kjhkj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhklihyjg@jhgjh.com', NULL, 'Female', '1999-04-26', 1, 'ecba655d18e5919cc401275490cfc4cd', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(160, 'ak', NULL, 'kaka', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kaka@jhj.kjh', NULL, 'Female', '1990-04-26', 1, '00e7618e8af70a44329273e58b28e9f9', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(161, 'sddsa', NULL, 'adsa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '96845665456', NULL, '', NULL, 'Female', '2016-09-26', 1, 'bdc3abf094aceb3a472e881c83adc4a8', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(162, 'uytghg', NULL, 'ikjuhgj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jkhjhj@ksjhf.com', NULL, '', '2016-09-05', 1, '9265200f32ee0165a261348e9bacaf8f', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(163, 'sddfsdkjh', NULL, 'kjhkjhkj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkj@gmail.ciou', NULL, 'Female', '1984-04-26', 1, 'b1ffcf169b9179c9b2ba1cb0fc4c28e4', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(164, 'tgrdfhgf', NULL, 'hgfhgf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'hgfhg@gmail.com', NULL, 'Female', '1998-04-26', 1, 'a547d2043a94bff25f795bc37fff6337', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(165, 'zsfchgbkj', NULL, 'jh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'dfgikhjkdlgjhkd3@fjhf.com', NULL, 'Female', '1989-05-26', 1, 'd7a36374eec4118d3471a7a2d27bb922', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(166, 'jhghhj', NULL, 'hjghjg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'hjgfds@jkduhgfdj.com', NULL, 'Female', '1990-04-26', 1, '376cfbf62f24fc46957e86326126fca7', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(167, 'fhfhfghg', NULL, 'fghfhgf', NULL, NULL, NULL, '', '', '', NULL, '', NULL, 'sfhjd@gmail.com', NULL, 'Female', '1990-04-26', 1, '08c9136f00abf67e2d13d30ec15da542', NULL, 1, NULL, '3', '', '', '', '', '2016-03-13', '', '', '0'),
(168, 'asdhjkhds', NULL, 'jhjkhjkh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkjhj@gmail.com', NULL, 'Female', '1990-03-13', 1, '441f06eb08f9f9a857f0f83ddf95fdff', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(169, 'sandeep', NULL, 'hajare', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sandeephajare162@gmail.com', NULL, '0', '1990-03-18', 1, 'dc0773aee0c5c0fc17bbe7d3107122b9', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(170, 'sup', NULL, 'patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'dfgikhlgjhkd3@fjhf.com', NULL, 'Female', '2000-05-04', 1, '973f7b68303bec1531682cb60cd9983e', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(171, 'sup', NULL, 'p', NULL, NULL, NULL, 'Karad', 'Maharashtra', '84', NULL, '', NULL, 'sp122@gmail.com', NULL, 'Female', '1990-02-26', 1, 'a04ace069c1acd57f8806b16a3d1257c', NULL, 1, NULL, '3', '', '', '', '', '2016-03-13', '', '', '0'),
(172, 'sup', NULL, 'poio', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhj@gmkjf.com', NULL, 'Female', '1999-04-26', 1, '307d9a4d6d2627f394cc3a836c354eb3', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(173, 'sfkjhkjh', NULL, 'kjhkjh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkjhjk@kjshf.com', NULL, 'Female', '1999-03-18', 1, '2d769d119c4da7de919cc5a6f253c942', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(174, 'sdfsfdfs', NULL, 'dfdfsds', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sps@gsdf.com', NULL, 'Female', '1998-04-26', 1, 'd8e8b305b747e086fd54fdecf011d6b7', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(175, 'dddddg', NULL, 's', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '87545577878', NULL, '', NULL, 'Female', '1999-04-26', 1, '8afeae9d06be25c1a29ab4ef6c36085a', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(176, 'jghjhgh', NULL, 'jhgjhg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhgjh@jkhg.com', NULL, 'Female', '1999-04-02', 1, 'b2a963c1cd81e06f1cb646f9158c3970', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(177, 'jhgjhg', NULL, 'jhgjhg', NULL, NULL, NULL, '', '', '', NULL, '45456454545', NULL, '', NULL, 'Female', '1999-09-01', 1, '6caeb52bd04bcd30427119251aa8c1e0', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', '0'),
(178, 'ygtyhghjg', NULL, 'jhgjhgh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhghf@gmail.com', NULL, 'Female', '1999-07-18', 1, '7de26a852b612adf346fa98ea3de387e', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(179, 'iutguiy', NULL, 'iuyiuyiu', NULL, NULL, NULL, '', '', '', NULL, '', NULL, 'iiuyuiy@kjdshgkdj.com', NULL, 'Female', '1999-04-15', 1, '5a40d01fd2bd348478fd2d52081e56ee', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', '0'),
(180, 'diuytuyh', NULL, 'kjhkjhk', NULL, NULL, NULL, '', '', '', NULL, '8476546554', NULL, '', NULL, 'Female', '1999-04-01', 1, '7b9ecdef7fd2524dc2933ef6478ad7d7', NULL, 1, NULL, '2', '', '', '', '', '2016-03-13', '', '', '0'),
(181, 'gjhg', NULL, 'jkhkjh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkj@jhgj.com', NULL, 'Female', '1999-04-02', 1, 'a131e541e5ab7bf1697d7a29c062eeb3', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(182, 'sxfujhskjfghjskg', NULL, 'kjhkjhkj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhk@jhghjgj.com', NULL, 'Female', '1999-04-26', 1, '753bb80010b15bbac23f3e9776cb1b11', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(183, 'hjs', NULL, 'kjhj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkj@gmail.com', NULL, 'Female', '2014-01-02', 1, '6b3c4686ffee710c38817bf7ef09d2b6', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(184, 'fdkgjhik', NULL, 'kjhkjh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhjk@kdujhrgdk.com', NULL, 'Female', '1999-04-26', 1, '8c8b0a8286de7f3f14241e5ff44d54e9', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(185, 'ak', NULL, 'dgdg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8654455544', NULL, '', NULL, 'Female', '1990-06-18', 1, '74fcb9ad4e5e169f1b99952f365cbe71', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(186, 'sup', NULL, 'ytgyhgh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhhg@gmai.lcom', NULL, 'Female', '2005-04-05', 1, 'dfd9ec916636ba162988485093e0aeee', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '1457877025_img', '', ''),
(187, 'yhgjhg', NULL, 'jhghjg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '654657987545458', NULL, '', NULL, 'Female', '1999-04-26', 1, 'eb3d3dfd9b63d0b19b05383dfca661fe', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(188, 'kujghj', NULL, 'jhgjhg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'jhg@hg.icu', NULL, 'Female', '1999-04-26', 1, '6b5fc29f64dcf08e2ad4240ac5342fde', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '1457877612_img', '', ''),
(189, 'flgkjkj', NULL, 'lkjkj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kj@kgjf.com', NULL, 'Female', '1990-04-26', 1, '044ca05f81278193b824a9a72cfd59d9', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(190, 'sdfsdf', NULL, 'dsfsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '52154755212', NULL, '', NULL, 'Female', '1999-04-01', 1, '670ddc6a4cfcf41b12d7c8d97c6c3163', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '1457877722_img', '', ''),
(191, 'dsfdf', NULL, 'patil', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8655544444', NULL, '', NULL, 'Female', '2000-05-17', 1, '67511717bd1e1bb903f199d1c0602a0b', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '1457877904_img', '', ''),
(192, 'ddd', NULL, 'ssss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ddd.sss@sda.asd', NULL, NULL, '0000-00-00', 1, 'bdcdba01897166801b1dbf6381b4d998', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(193, 'sadasd', NULL, 'asdasd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'asdas@sdsdf.jhk', NULL, 'Female', '0000-00-00', 1, 'ccd5f08c99aa71bf7e154fa397f03e84', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(194, 'sadasd', NULL, 'vbnvbn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'vbnfdsf@sad.fgh', NULL, 'Female', '0000-00-00', 1, '744e3db012995db61676265be0ea9e16', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(195, 'dsfsd', NULL, 'fdhfghf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sdfsdf@dfd.fg', NULL, 'Female', '1997-07-16', 1, '346b705019567e4781d4729f8105dd9e', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(196, 'asdfsdf', NULL, 'sdffdsg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ffdh@fd.fhf', NULL, NULL, '0000-00-00', 1, '3e3894c735d5a11e6d63ee94570f65d5', NULL, 1, NULL, '', '', '', '', '', '2016-03-13', '', '', ''),
(197, 'asdsad', NULL, 'asdadsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'asdasd@df.fdh', NULL, NULL, '1999-06-18', 1, 'a6b71a4d50b8ae49dfb8642db0b62297', NULL, 1, NULL, '', '', '', '', '', '2016-03-14', '', '', ''),
(198, 'sdfsf', NULL, 'sdfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'asd@fds.ghj', NULL, NULL, '1999-11-12', 1, '9ed19950689d84e66f545eaa36d31acc', NULL, 1, NULL, '', '', '', '', '', '2016-03-14', '', '', ''),
(199, 'vzxcvcv', NULL, 'zvzxcvzxvc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'dfsdfaf@dsff.fjjk', NULL, NULL, '1997-08-05', 1, '716c7bff8b3dce09da7e696641ec3d0b', NULL, 1, NULL, '', '', '', '', '', '2016-03-14', '', '', ''),
(200, 'bnmbnvmv', NULL, 'bnmbnm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'vbjkljl@sadj.asd', NULL, NULL, '1997-08-13', 1, '1a9811c95895b35c387d434a4f0fb065', NULL, 1, NULL, '', '', '', '', '', '2016-03-14', '', '', ''),
(201, 'Rv', NULL, 'vr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'rv@gm.gn', NULL, 'Male', '1964-06-13', 1, '84684368a4b152960c7bf69d095b8136', NULL, 1, NULL, '', '', '', '', '', '2016-03-14', '', '', ''),
(202, 'raviraj', NULL, 'salunkhe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ravi@raj.salunkhe', NULL, 'Male', '1999-01-15', 1, '8be1f85bb95501f5b73ec072adbf0a8c', NULL, 1, NULL, '', '', '', '', '', '2016-03-15', '', '', ''),
(203, 'sadfsdf', NULL, 'asfsadf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'czxvzxv@gmial.com', NULL, '0', '1993-09-08', 1, 'b94bddcff9bcfd2b3cba7fb600019925', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(204, 'sdcfdsfs', NULL, 'dsfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'zxcvxcv@sadf.cv', NULL, '0', '1990-07-15', 1, '2b5c73ea27ef5171312e48cec386e546', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(205, 'assad', NULL, 'asdasd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'asdasd@fh.sf', NULL, '0', '1987-06-19', 1, '1782beeea7336da8359afdb969d0c129', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(206, 'sdsds', NULL, 'dsfsdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '98745874587', NULL, '', NULL, 'Female', '2014-04-06', 1, '096e2950e27669d74bcb956f723c3e99', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(207, 'sdfdsf', NULL, 'sdfsdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'xcvxcv@fdsf.sdf', NULL, '0', '1986-11-19', 1, 'af1a4ac230775388658c069954a2e066', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(208, 'wses', NULL, 'esres', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'ggg@gg.com', NULL, 'Female', '1990-04-26', 1, 'c7b705e09041839dc80ce9e552a54ffe', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(209, 'jhghj', NULL, 'hgjhgh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'hgjhg@hgvhjzc.con', NULL, 'Female', '1990-04-26', 1, 'e50a7c46e784d9d31be10b55c1173d37', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(210, 'sdfsdf', NULL, 'sdfsdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sfhjdsss@gmail.com', NULL, 'Female', '1990-04-26', 1, '40994ac5e36733ccb8c4811d35dcb451', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(211, 'dsfdsf', NULL, 'dfsdfsff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'sjhfg@kigrh.com', NULL, 'Female', '1990-04-26', 1, 'b062a3793ad4a0a8494c82387a653a56', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(212, 'fsdfsdf', NULL, 'sdfsdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'dgkjhjk@skdujfhg.com', NULL, 'Female', '1990-04-26', 1, 'fee0c9d2b3ee2537ad146137a9b1ed83', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(213, 'sadad', NULL, 'sadsad', NULL, NULL, NULL, 'asdasd', 'sadad', '11', NULL, '', NULL, 'asdasd@sfds.hg', NULL, '0', '1995-12-10', 1, '9cef2bd1e15ac6a2f236cc5b0b1976d3', NULL, 1, NULL, '4', '2', '', '', '', '2016-03-16', '', '', '0'),
(214, 'kih', NULL, 'kjhkjh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'kjhkj@jhygf.com', NULL, 'Female', '1999-04-26', 1, 'e24b6e52f49bbe51d2924a640dae265a', NULL, 1, NULL, '', '', '', '', '', '2016-03-16', '', '', ''),
(215, 'dgkjuh', NULL, 'kjhkjh', NULL, NULL, NULL, 'Karad', 'Maharashtra', '4', NULL, '', NULL, 'kjhksf@kfjihfg.com', NULL, 'Female', '1990-04-26', 1, 'e47d3098c1064ad07995d0824fcde708', NULL, 1, NULL, '2', '', '', '', '', '2016-03-16', '1458111700_img', '1458112701_img', '0'),
(216, 'ujuhgjhg', NULL, 'hjgjh', NULL, NULL, NULL, 'Karad', 'Maharashtra', '84', NULL, '', NULL, 'gjhg.jkdhfdg@gmail.com', NULL, 'Female', '1999-04-26', 1, 'e8487368b90936408687f433cbb84b0a', NULL, 1, NULL, '1', '', '', '', '', '2016-03-20', '', '', '0'),
(217, 'kgjhghg', NULL, 'jhghjg', NULL, NULL, NULL, 'Karad', 'Maharashtra', '12', NULL, '9512368523', NULL, '', NULL, 'Female', '1990-04-26', 1, 'f931705c4f7cc49d2c385fdb797f0f61', NULL, 1, NULL, '1', '', '', '', '', '2016-03-20', '', '', '0');

-- --------------------------------------------------------

--
-- Table structure for table `userpreference`
--

CREATE TABLE IF NOT EXISTS `userpreference` (
  `UserID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `Sequence` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userprofilepic`
--

CREATE TABLE IF NOT EXISTS `userprofilepic` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Path` varchar(1000) NOT NULL,
  `UploadDate` date NOT NULL,
  `Active` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='User Profile Pic Detail';

--
-- Dumping data for table `userprofilepic`
--

INSERT INTO `userprofilepic` (`Id`, `UserId`, `Path`, `UploadDate`, `Active`) VALUES
(4, 1, 'uploads/profile\\a.jpg', '2016-11-09', 1),
(5, 37, 'uploads/profile\\56c435dd25a0b.jpeg', '0000-00-00', 1),
(6, 38, 'uploads/profile\\Disha-Patani-ap7am-468267.jpg', '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE IF NOT EXISTS `userrole` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Here we store User Role In System';

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`UserId`, `RoleId`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `Id` int(11) NOT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `MiddleName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Address1` varchar(200) DEFAULT NULL,
  `Address2` varchar(200) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `PinCode` int(11) DEFAULT NULL,
  `Mobile` varchar(50) DEFAULT NULL,
  `LandLine` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `EmailId1` varchar(100) DEFAULT NULL,
  `Gender` varchar(11) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `FirstName`, `MiddleName`, `LastName`, `Address1`, `Address2`, `City`, `State`, `Country`, `PinCode`, `Mobile`, `LandLine`, `EmailId`, `EmailId1`, `Gender`, `DateOfBirth`, `Password`, `Active`) VALUES
(1, 'Prashant', 'S', 'Disale', 'Lavanmachi', 'near Jothiba Mandir', 'Islampur', 'Maharastra', 'India', 415302, '9011110615', NULL, 'prashantdisale7@gmail.com', 'prashantdisale11@gmail.com', 'Male', '1988-10-01', 'as', 1),
(2, 'Suraj', 'S', 'Katwate', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(3, 'ravi', 'S', 'salunkhe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(4, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(5, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(6, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(7, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(8, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(9, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(10, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(11, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(12, 'ABC', 'S', 'Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL),
(13, 'vaibhav', '', 'K', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(14, 'vaibhav', '', 'Kokane', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(15, 'vaibhav', '', 'Kokane VK', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(16, 'vaibhav', '', 'Kokane kl', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(17, 'KAka', '', 'Patil', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(18, '12', '', '12', '', '', '', '', '', 0, '', '', 'aa@aa.com', '', '', '0000-00-00', '', 0),
(19, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(20, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravisalunkhe111@gmail.com', '', '', '0000-00-00', '', 0),
(21, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(22, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(23, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.com', '', '', '0000-00-00', '', 0),
(24, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.com', '', '', '0000-00-00', '', 0),
(25, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(26, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(27, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(28, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.aa', '', '', '0000-00-00', '', 0),
(29, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(30, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(31, 'Ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'aa@aa.com', '', '', '0000-00-00', '', 0),
(32, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(33, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(34, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(35, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', '', 0),
(36, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', NULL, 0),
(37, 'ravi', '', 'Salunkhe', '', '', '', '', '', 0, '', '', 'ravi@as.com', '', '', '0000-00-00', 'as', 0),
(38, 'suraj', '', 'Katwate', '', '', '', '', '', 0, '', '', 'suraj@as.com', '', '', '0000-00-00', 'as', 0),
(39, 'testing data', 'testing data', 'testing data', NULL, NULL, NULL, NULL, NULL, NULL, 'testing data', NULL, 'testing data', NULL, 'testing dat', NULL, 'testing data', 0),
(40, 'testing data', 'testing data', 'testing data', NULL, NULL, NULL, NULL, NULL, NULL, 'testing data', NULL, 'testing data', NULL, 'testing dat', NULL, 'testing data', 0),
(41, 'testing data', 'testing data', 'testing data', NULL, NULL, NULL, NULL, NULL, NULL, 'testing data', NULL, 'testing data', NULL, 'testing dat', NULL, 'testing data', 0),
(42, 'testing data', 'testing data', 'testing data', NULL, NULL, NULL, NULL, NULL, NULL, 'testing data', NULL, 'testing data', NULL, 'testing dat', NULL, 'testing data', 0),
(43, 'NewUser', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9767857934', NULL, 'pr@p.com', NULL, 'male', NULL, 'as', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounttype`
--
ALTER TABLE `accounttype`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `adminuser`
--
ALTER TABLE `adminuser`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coverphoto`
--
ALTER TABLE `coverphoto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login123`
--
ALTER TABLE `login123`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `posttype`
--
ALTER TABLE `posttype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `talent`
--
ALTER TABLE `talent`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `talenttype`
--
ALTER TABLE `talenttype`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `timelineposts`
--
ALTER TABLE `timelineposts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timelinepostscomments`
--
ALTER TABLE `timelinepostscomments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timelinepostsitems`
--
ALTER TABLE `timelinepostsitems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timelinepostslike`
--
ALTER TABLE `timelinepostslike`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user123`
--
ALTER TABLE `user123`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `userprofilepic`
--
ALTER TABLE `userprofilepic`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Id` (`Id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounttype`
--
ALTER TABLE `accounttype`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `adminuser`
--
ALTER TABLE `adminuser`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=195;
--
-- AUTO_INCREMENT for table `coverphoto`
--
ALTER TABLE `coverphoto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `login123`
--
ALTER TABLE `login123`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `posttype`
--
ALTER TABLE `posttype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `talent`
--
ALTER TABLE `talent`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `talenttype`
--
ALTER TABLE `talenttype`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `timelineposts`
--
ALTER TABLE `timelineposts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `timelinepostscomments`
--
ALTER TABLE `timelinepostscomments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `timelinepostsitems`
--
ALTER TABLE `timelinepostsitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `timelinepostslike`
--
ALTER TABLE `timelinepostslike`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user123`
--
ALTER TABLE `user123`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=218;
--
-- AUTO_INCREMENT for table `userprofilepic`
--
ALTER TABLE `userprofilepic`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
