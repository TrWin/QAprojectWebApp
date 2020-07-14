-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 14, 2020 at 03:37 PM
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
(2, 'CORP010', '200046759', '0938160131', 'RF', 'Set2', '', '', 'Enable'),
(3, '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', 'Disable'),
(4, 'CORP010', '200046759', '0938160131', 'RF', 'Set2', '', '', 'Enable'),
(5, '3101000023609', '200052123', '0902350946', 'RM', 'Set2', '', '', 'Enable');

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

-- --------------------------------------------------------

--
-- Table structure for table `data_pattern`
--

CREATE TABLE `data_pattern` (
  `pattern_code` varchar(10) NOT NULL,
  `pattern_name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sql_code` varchar(10000) NOT NULL,
  `system_detail` varchar(255) NOT NULL,
  `confidentscore` varchar(255) NOT NULL,
  `relate` varchar(255) NOT NULL,
  `sequence` varchar(10) NOT NULL,
  `frequency` varchar(10) NOT NULL,
  `automate_path` varchar(1000) NOT NULL,
  `manual_path` varchar(1000) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `data_pattern`
--

INSERT INTO `data_pattern` (`pattern_code`, `pattern_name`, `type`, `sql_code`, `system_detail`, `confidentscore`, `relate`, `sequence`, `frequency`, `automate_path`, `manual_path`, `tag`, `remark`, `status`) VALUES
('A001', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract', 'Standard', '\"select soc_cd,soc_name,sale_exp_date\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)-1) as TR_CONTRACT_IND\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)-1) as TR_OFFER_GROUP\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)-1) as TR_CUSTOMER\r\n  from csm_offer\r\n  where soc_type = \'U\' and sale_exp_date > sysdate and product_type in (\'RR\',\'RF\',\'RM\')\"', 'CCBS', '0.5', '', '', '5', '\\\\true.th\\infocenter$\\T\\TestProject', '\\\\true.th\\infocenter$\\T\\TestProject', '', '', 'Enable'),
('A002', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract ที่มีค่า Fee', 'Standard', '\"select soc_cd,soc_name,sale_exp_date\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)-1) as TR_CONTRACT_IND\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)-1) as TR_OFFER_GROUP\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)-1) as TR_CUSTOMER\r\n  from csm_offer\r\n  where soc_type = \'U\' and sale_exp_date > sysdate and product_type in (\'RR\',\'RF\',\'RM\')\r\n  and soc_properties like \'%TR_CONTRACT_IND=%Y%\'\"', 'CCBS', '0.5', '', '', '3', '', '', '', '', 'Disable'),
('A003', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract ที่มีค่า Fee และเมื่อยกเลิกจะต้องมีค่าปรับ', 'Standard', '\"select soc_cd,soc_name,sale_exp_date\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)-1) as TR_CONTRACT_IND\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_OFFER_GROUP=\')),\'=\',1)-1) as TR_OFFER_GROUP\r\n  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\r\n  instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)+1\r\n  ,instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CUSTOMER=\')),\'=\',1)-1) as TR_CUSTOMER\r\n  from csm_offer\r\n  where soc_type = \'U\' and sale_exp_date > sysdate and product_type in (\'RR\',\'RF\',\'RM\')\r\n  and soc_properties like \'%TR_CONTRACT_IND=%Y%\'\r\n  and SOC_NAME in (select distinct PROPOSITION_CODE from TRUE9_PENALTY_CONTRACT)\"', 'CCBS', '0.5', '', '', '3', '', '', '', '', 'Disable'),
('A004', 'หา Thai ID ลูกค้า Individual ลูกค้าที่ติด Max Allow', 'Standard', '\"select * from\r\n (select l9_identification, count(subscriber_no) total_sub\r\n from subscriber a, customer b\r\n where a.customer_id = b.customer_id\r\n and a.subscriber_type in (\'RF\',\'RM\')\r\n and a.sub_Status not in (\'C\',\'L\',\'T\')\r\n and b.customer_type =\'I\'\r\n group by l9_identification) where total_sub > \'6\'\r\n order by total_sub\"', 'CCBS', '0.7', '', '', '6', '', '', '', '', 'Enable'),
('A005', 'หาเบอร์ Status Active', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req\r\n ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind\r\n ,init_act_date,effective_Date,orig_act_date,sub_status_date\r\n from subscriber\r\n where sub_status = \'A\' \r\n and l9_crd_status = \'NONE\'\r\n and l9_col_status = \'NONE\'\r\n and l9_barring_by_req is null\r\n and l9_installation_type is null\r\n and l9_multi_sim_ind is null\r\n and subscriber_type in (\'RF\',\'RM\')\"', 'CCBS', '0.7', '', '', '3', '', '', '', '', 'Enable'),
('A006', 'หาเบอร์ Soft Suspend by Request', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where subscriber_type in (\'RM\',\'RF\')  and sub_Status = \'A\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_barring_by_req = \'Y\'\"', 'CCBS', '0.7', '', '', '0', '', '', '', '', 'Enable'),
('A007', 'หา Soc Contract สำหรับ Knox Service', 'Standard', '\"select b.soc_name, a.*   from csm_offer_param a, csm_offer b  where a.soc_cd = b.soc_cd  and param_name =\'KNOX\'\"', 'CCBS', '1', '', '', '5', '', '', '', '', 'Enable'),
('A008', 'หา Soc Resource สำหรับ Multisim กรณี Physical SIM', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=RES%\'\"', 'CCBS', '1', '', '', '1', '', '', '', '', 'Enable'),
('A009', 'หา Soc Resource สำหรับ Multisim กรณี eSIM', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=REE%\'\"', 'CCBS', '1', '', '', '1', '', '', '', '', 'Enable'),
('A010', 'หา Soc RC สำหรับ Multisim', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=RCM%\'\"', 'CCBS', '1', '', '', '1', '', '', '', '', 'Enable'),
('A011', 'หา Soc CUG (Additional)', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and sale_context = \'S\'  and soc_properties LIKE \'%CUG_IND=Y%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Disable'),
('A012', 'หา Soc CUG (Build-in)', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and sale_context = \'R\'  and soc_properties LIKE \'%CUG_IND=Y%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Disable'),
('A013', 'หา Price Plan สำหรับ Hybrid', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and soc_type = \'P\'  and soc_properties like \'%TR_PRODUCT_SUB_TYPE=H%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A014', 'หาเบอร์ลูกค้า NB-IoT', 'Standard', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and subscriber_type in (\'INB\',\'ICA\')\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A015', 'หาเบอร์ที่ใช้ eSIM (Apple Watch - Non QR Code)', 'Standard', '\"select b.subscriber_no,b.sys_creation_date,b.prim_resource_val,b.sub_status,b.subscriber_type,b.language  ,a.sys_creation_date sys_create_res, a.resource_type, a.resource_prm_cd,a.resource_Value,a.effective_date,a.expiration_Date,a.offer_instance_id  from agreement_resource a, subscriber b  where a.agreement_no = b.subscriber_no  and a.expiration_date is null  and a.resource_type = \'MID\'  and a.resource_value like \'NONE%\'\"', 'CCBS', '0.9', '', '', '0', '', '', '', '', 'Enable'),
('A016', 'หาเบอร์ที่ใช้ eSIM (iPhone - QR Code)', 'Standard', '\"select b.subscriber_no,b.sys_creation_date,b.prim_resource_val,b.sub_status,b.subscriber_type,b.language  ,a.sys_creation_date sys_create_res, a.resource_type, a.resource_prm_cd,a.resource_Value,a.effective_date,a.expiration_Date,a.offer_instance_id  from agreement_resource a, subscriber b  where a.agreement_no = b.subscriber_no  and a.expiration_date is null  and a.resource_type = \'MID\'  and a.resource_value not like \'NONE%\'\"', 'CCBS', '0.9', '', '', '0', '', '', '', '', 'Enable'),
('A017', 'หา Thai ID ที่มี Share Plan มากกว่า 1 กลุ่ม', 'Complex', '\"select * from  (select l9_identification,l9_related_subscriber,l9_installation_type, count(subscriber_no) count_group  from   (select subscriber_no,sub_status,a.customer_id,l9_identification,customer_type  ,a.ch_node_id,a.sys_creation_date,a.sys_update_date  ,link_prev_sub_no,link_next_sub_no  ,init_act_date,l9_installation_type,l9_related_subscriber,prim_resource_val  from subscriber a, customer b  where a.customer_id = b.customer_id   and l9_installation_type is not null  and customer_type = \'I\'  and l9_related_subscriber = \'0\') fsim  group by l9_identification,l9_related_subscriber,l9_installation_type) count_profile  where count_group > 1\"', 'CCBS', '0.7', '', '', '0', '', '', '', '', 'Enable'),
('A018', 'หาเบอร์ที่เป็น MNP Port In External (ต่างค่าย)', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_port_ind =\'I\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_installation_type is null  and l9_multi_sim_ind is null  --and l9_rec_operator = \'06\'  and l9_donor_operator not in (\'02\',\'06\')   and customer_id in (select customer_id from customer where customer_type =\'I\')\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable'),
('A019', 'หาเบอร์ที่เป็น MNP Port In Internal (ค่ายเดียวกัน)', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_port_ind =\'I\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_installation_type is null  and l9_multi_sim_ind is null  --and l9_rec_operator = \'06\'  and l9_donor_operator in (\'02\',\'06\')   and customer_id in (select customer_id from customer where customer_type =\'I\')\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `pattern_code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`id`, `pattern_code`, `type`, `path`, `file_name`, `topic`, `remark`, `status`) VALUES
(2, 'A001', 'Automate', '\\\\true.th\\infocenter$\\T\\TestProject', 'Automate for cancel', 'Cancel by collection', '', 'Disable'),
(3, 'A001', 'Manual', '\\\\true.th\\infocenter$\\T\\TestProject', 'Manual for cancel', 'Cancel by collection', '', 'Enable'),
(4, 'A002', 'Manual', 'Http://wedocumentary', 'money incress', 'money incress', '', 'Enable'),
(5, 'A003', 'Manual', 'Http://wedocumentary', 'suspend', 'suspend by collection', '', 'Enable'),
(6, 'A004', 'Manual', '', '', '', '', 'Enable');

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
(3, 'CCBS', 'trueapp9', 'Set2', '\"CMO : http://ccbapts1:15201/cm?APP_ID=CM RMO : http://ccbapts1:15201/rm?APP_ID=RM ARO : http://ccbapts1:15201/ar?APP_ID=AR \"', '\"tnsname: test02.test.th=(description=(address=(protocol=tcp)(host=172.19.192.186)(port=1565))(connect_data=(sid=TEST02))) \"', 'tru9/Unix11', 'truapp9/truapp9', '', 'Disable'),
(4, 'ICC', 'UAT62', 'Set3', '', '\"tnsname :   UAT62 =   (DESCRIPTION =     (ADDRESS = (PROTOCOL = TCP)(HOST = 172.19.235.61)(PORT = 1530))     (CONNECT_DATA =       (SID = UAT62)     )   ) \"', '', '', '', 'Enable'),
(5, 'TVSCC', '', 'Set2', 'http://smsappd02/TVGWEB/login_revamp.aspx', '', 'bk-21/test11', '', '', 'Enable');

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

-- --------------------------------------------------------

--
-- Table structure for table `update_log`
--

CREATE TABLE `update_log` (
  `updated_table` varchar(225) NOT NULL,
  `updated_by` varchar(225) NOT NULL,
  `updated_date` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `update_log`
--

INSERT INTO `update_log` (`updated_table`, `updated_by`, `updated_date`) VALUES
('auto', '<User: admin>', '2020-07-10 17:17:36.000000'),
('env', '<User: admin>', '2020-07-10 17:17:47.000000'),
('qa', '<User: admin>', '2020-07-09 16:17:20.000000'),
('sit', '<User: admin>', '2020-07-10 17:16:45.000000'),
('third', '<User: 3situser>', '2020-07-14 16:28:47.000000');

-- --------------------------------------------------------

--
-- Table structure for table `user_password`
--

CREATE TABLE `user_password` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_password`
--

INSERT INTO `user_password` (`id`, `username`, `password`, `type`) VALUES
(1, 'qauser', '12345678', 'qa'),
(2, '3situser', '12345678', '3rdsit');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `automate_test_data`
--
ALTER TABLE `automate_test_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `c_user`
--
ALTER TABLE `c_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pattern`
--
ALTER TABLE `data_pattern`
  ADD PRIMARY KEY (`pattern_code`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `env`
--
ALTER TABLE `env`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `for_3rd_party`
--
ALTER TABLE `for_3rd_party`
  ADD PRIMARY KEY (`id`,`pattern_code`);

--
-- Indexes for table `for_sit`
--
ALTER TABLE `for_sit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `update_log`
--
ALTER TABLE `update_log`
  ADD PRIMARY KEY (`updated_table`),
  ADD UNIQUE KEY `updated_table` (`updated_table`);

--
-- Indexes for table `user_password`
--
ALTER TABLE `user_password`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `automate_test_data`
--
ALTER TABLE `automate_test_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `c_user`
--
ALTER TABLE `c_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `env`
--
ALTER TABLE `env`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `for_3rd_party`
--
ALTER TABLE `for_3rd_party`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `for_sit`
--
ALTER TABLE `for_sit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_password`
--
ALTER TABLE `user_password`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
