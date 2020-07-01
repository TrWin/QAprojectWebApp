-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2020 at 02:51 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

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
-- Table structure for table `automate_test_data`
--

CREATE TABLE `automate_test_data` (
  `id` int(11) NOT NULL,
  `thai_id` varchar(255) NOT NULL,
  `ban` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `test_env` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `automate_test_data`
--

INSERT INTO `automate_test_data` (`id`, `thai_id`, `ban`, `product_id`, `company`, `test_env`, `owner`, `remark`, `status`) VALUES
(2, 'CORP010', '200046789', '0938160131', 'RF', 'Set2', '', '', 'Enable'),
(3, '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', 'Enable'),
(4, 'CORP010', '200046789', '0938160131', 'RF', 'Set2', '', '', ''),
(5, '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', 'Enable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `automate_test_data`
--
ALTER TABLE `automate_test_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `automate_test_data`
--
ALTER TABLE `automate_test_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
