-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 14, 2020 at 03:43 PM
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
-- Table structure for table `for_sit`
--

CREATE TABLE `for_sit` (
  `id` int(11) NOT NULL,
  `pattern_code` varchar(255) NOT NULL,
  `thai_id` varchar(255) NOT NULL,
  `ban` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `test_env` varchar(255) NOT NULL,
  `current` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `period_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `for_sit`
--

INSERT INTO `for_sit` (`id`, `pattern_code`, `thai_id`, `ban`, `product_id`, `company`, `test_env`, `current`, `period_start`, `remark`, `status`) VALUES
(3, 'A001', 'CORP010', '200046759', '0938160131', 'RF', '  Set2  ', '                   . sdfdsf', '   2020-07-19  to  2020-07-26', '', 'Enable'),
(4, 'A001', 'BBB', '200043976', '0938160166', 'RF', 'Set2', '', '', '', 'Enable'),
(5, 'A001', '4545646676787', '200050636', '0938160931', 'RF', 'Set2', '', '', '', 'Enable'),
(6, 'A001', '1132133333333', '200052598', '0938160919', 'RF', 'Set2', '', '', '', 'Enable'),
(7, 'A001', '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', '', 'Enable'),
(8, 'A001', '3872218209141', '200080883', '0968731420', 'RM', 'Set7', '', '', '', 'Enable'),
(9, 'A001', '1602120200664', '200086628', '0968732134', 'RM', 'Set7', '', '', '', 'Enable'),
(10, 'A002', 'CORP010', '200046759', '0938160131', 'RF', 'Set2', '', '', '', 'Enable'),
(11, 'A002', '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', '', 'Enable'),
(12, 'A002', '1602120200664', '200086628', '0968732134', 'RM', 'Set7', '', '', '', 'Enable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `for_sit`
--
ALTER TABLE `for_sit`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `for_sit`
--
ALTER TABLE `for_sit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
