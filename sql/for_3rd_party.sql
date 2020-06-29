-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 29, 2020 at 11:00 AM
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
  `pattern_code` varchar(255) NOT NULL,
  `pattern_name` varchar(255) NOT NULL,
  `thai_id` varchar(255) NOT NULL,
  `ban` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `enquiry` varchar(255) NOT NULL,
  `test_env` varchar(255) NOT NULL,
  `current_user` varchar(255) NOT NULL,
  `period` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `for_3rd_party`
--

INSERT INTO `for_3rd_party` (`pattern_code`, `pattern_name`, `thai_id`, `ban`, `product_id`, `company`, `enquiry`, `test_env`, `current_user`, `period`, `remark`, `status`) VALUES
('sdfsdf', 'sfasdas', 'asdasd', 'asdasd', 'asdasd', 'sdasd', 'asdasd', 'sdasd', 'asdsad', 'asdasd', 'asdasdsadasdsadas', 'Disable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `for_3rd_party`
--
ALTER TABLE `for_3rd_party`
  ADD PRIMARY KEY (`pattern_code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
