-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 23, 2020 at 12:24 PM
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
-- Table structure for table `data_pattern`
--

CREATE TABLE `data_pattern` (
  `pattern_code` varchar(10) NOT NULL,
  `pattern_name` varchar(255) NOT NULL,
  `sql_code` varchar(10000) NOT NULL,
  `system_detail` varchar(255) NOT NULL,
  `confidentscore` varchar(255) NOT NULL,
  `relate` varchar(255) NOT NULL,
  `sequence` varchar(10) NOT NULL,
  `frequency` varchar(10) NOT NULL,
  `automate_path` varchar(1000) NOT NULL,
  `manual_path` varchar(1000) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `data_pattern`
--

INSERT INTO `data_pattern` (`pattern_code`, `pattern_name`, `sql_code`, `system_detail`, `confidentscore`, `relate`, `sequence`, `frequency`, `automate_path`, `manual_path`, `tag`, `status`) VALUES
('A001', 'Standard', '\"select soc_cd,soc_name,sale_exp_date\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)-1) as TR_CONTRACT_IND\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)-1) as TR_OFFER_GROUP\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)-1) as TR_CUSTOMER\r\n  from csm_offer\r\n  where soc_type = \'U\' and sale_exp_date > sysdate and product_type in (\'RR\',\'RF\',\'RM\')\"', 'CCBS', '0.5', '', '3', '3', '', '', '', 'Enable'),
('A002', 'Standard', '\"select soc_cd,soc_name,sale_exp_date   ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM   ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE   ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(s', 'CCBS', '0.5', '', '3', '3', '', '', '', 'Disable');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_pattern`
--
ALTER TABLE `data_pattern`
  ADD PRIMARY KEY (`pattern_code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
