-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 30, 2020 at 12:02 PM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qa`
--

-- --------------------------------------------------------

--
-- Table structure for table `env`
--

CREATE TABLE `env` (
  `id` int(11) NOT NULL,
  `oursystem` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `db` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ourset` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(255) NOT NULL,
  `user_pass_app` varchar(255) NOT NULL,
  `user_pass_db` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `env`
--

INSERT INTO `env` (`id`, `oursystem`, `db`, `ourset`, `path`, `ip`, `user_pass_app`, `user_pass_db`, `remark`, `status`) VALUES
(2, 'CRM', '', 'Set2', '\"DB Authen  >> http://truecrmuatset2.true.th:8080/adm/ SSO >> http://truecrmuatset2.true.th:8080/ecommunications_SET2/ \"', '', '', '', 'User/Pass Aplication  เป็นของแต่ละทีม', 'Enable'),
(3, 'CCBS', 'trueapp9', 'Set2', '\"CMO : http://ccbapts1:15201/cm?APP_ID=CM RMO : http://ccbapts1:15201/rm?APP_ID=RM ARO : http://ccbapts1:15201/ar?APP_ID=AR \"', '\"tnsname: test02.test.th=(description=(address=(protocol=tcp)(host=172.19.192.186)(port=1565))(connect_data=(sid=TEST02))) \"', 'tru9/Unix11', 'truapp9/truapp9', '', 'Enable'),
(4, 'ICC', 'UAT62', 'Set3', '', '\"tnsname :   UAT62 =   (DESCRIPTION =     (ADDRESS = (PROTOCOL = TCP)(HOST = 172.19.235.61)(PORT = 1530))     (CONNECT_DATA =       (SID = UAT62)     )   ) \"', '', '', '', 'Enable'),
(5, 'TVSCC', '', 'Set2', 'http://smsappd02/TVGWEB/login_revamp.aspx', '', 'bk-21/test11', '', '', 'Enable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `env`
--
ALTER TABLE `env`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `env`
--
ALTER TABLE `env`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
