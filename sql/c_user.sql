-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 14, 2020 at 03:47 PM
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
-- Table structure for table `c_user`
--

CREATE TABLE `c_user` (
  `id` int(11) NOT NULL,
  `current` varchar(255) NOT NULL,
  `period_start` varchar(255) NOT NULL,
  `period_end` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `c_user`
--

INSERT INTO `c_user` (`id`, `current`, `period_start`, `period_end`, `type`) VALUES
(5, 'suwit thongraar', '2020-07-09', '2020-07-19', '3rd'),
(6, 'sdfdsf', '2020-07-19', '2020-07-26', 'sit');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `c_user`
--
ALTER TABLE `c_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `c_user`
--
ALTER TABLE `c_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
