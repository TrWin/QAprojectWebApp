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
-- Table structure for table `env`
--

CREATE TABLE `env` (
  `system` varchar(255) NOT NULL,
  `database` varchar(255) NOT NULL,
  `set` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `user_pass_app` varchar(255) NOT NULL,
  `user_pass_db` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `env`
--

INSERT INTO `env` (`system`, `database`, `set`, `url`, `ip`, `user_pass_app`, `user_pass_db`, `remark`, `status`) VALUES
('sdsD', 'ASDASDAS', 'DASDdsfsdf', 'dsfsd', 'fdsfsdf', 'dsfsdf', 'dsfsdf', 'sdfsdfds', 'Disable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `env`
--
ALTER TABLE `env`
  ADD PRIMARY KEY (`system`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
