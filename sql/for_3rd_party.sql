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
-- Table structure for table `for_3rd_party`
--

CREATE TABLE `for_3rd_party` (
  `id` int(11) NOT NULL,
  `pattern_code` varchar(255) NOT NULL,
  `pattern_name` varchar(255) NOT NULL,
  `thai_id` varchar(255) NOT NULL,
  `ban` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `enquiry` varchar(255) NOT NULL,
  `test_env` varchar(255) NOT NULL,
  `current` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `period_start` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `for_3rd_party`
--

INSERT INTO `for_3rd_party` (`id`, `pattern_code`, `pattern_name`, `thai_id`, `ban`, `product_id`, `company`, `enquiry`, `test_env`, `current`, `period_start`, `remark`, `status`) VALUES
(6, 'A002', '', '', '', '', '', 'Enquiry', '        Set3        ', '           . suwit thongraar', '   2020-07-09  to  2020-07-19', '', 'Enable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `for_3rd_party`
--
ALTER TABLE `for_3rd_party`
  ADD PRIMARY KEY (`id`,`pattern_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `for_3rd_party`
--
ALTER TABLE `for_3rd_party`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
