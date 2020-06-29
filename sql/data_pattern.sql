-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 24, 2020 at 04:19 AM
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
('A001', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract', 'Standard', '\"select soc_cd,soc_name,sale_exp_date  ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),  instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1  ,instr(substr(soc_properties,instr(soc_properties,\'TR_', 'CCBS', '0.5', '', '', '3', '', '', '', '', 'Disable'),
('A002', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract ที่มีค่า Fee', 'Standard', '\"select soc_cd,soc_name,sale_exp_date   ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)-1) as TR_CONTRACT_TERM   ,substr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\';\',1)-instr(substr(soc_properties,instr(soc_properties,\'TR_DEFAULT_CONTRACT_FEE=\')),\'=\',1)-1) as TR_DEFAULT_CONTRACT_FEE   ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_IND=\')),\';\',1)-instr(substr(soc_properties,instr(s', 'CCBS', '0.5', '', '', '3', '', '', '', '', 'Enable'),
('A003', 'หา Soc Contract เพื่อใช้ในกรณีที่ต้องการ Add Contract ที่มีค่า Fee และเมื่อยกเลิกจะต้องมีค่าปรับ', 'Standard', '\"select soc_cd,soc_name,sale_exp_date   ,substr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),   instr(substr(soc_properties,instr(soc_properties,\'TR_CONTRACT_TERM=\')),\'=\',1)+1   ,instr(substr(soc_properties,instr(soc_properties,\'TR_CON', 'CCBS', '0.5', '', '', '3', '', '', '', '', 'Disable'),
('A004', 'หา Thai ID ลูกค้า Individual ลูกค้าที่ติด Max Allow', 'Standard', '\"select * from  (select l9_identification, count(subscriber_no) total_sub  from subscriber a, customer b  where a.customer_id = b.customer_id  and a.subscriber_type in (\'RF\',\'RM\')  and a.sub_Status not in (\'C\',\'L\',\'T\')  and b.customer_type =\'I\'  group by l9_identification) where total_sub > \'6\'  order by total_sub\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable'),
('A005', 'หาเบอร์ Status Active', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_barring_by_req is null  and l9_installation_type is null  and l9_multi_sim_ind is null  and subscriber_type in (\'RF\',\'RM\')\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable'),
('A006', 'หาเบอร์ Soft Suspend by Request', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where subscriber_type in (\'RM\',\'RF\')  and sub_Status = \'A\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_barring_by_req = \'Y\'\"', 'CCBS', '0.7', '', '', '0', '', '', '', '', 'Enable'),
('A007', 'หา Soc Contract สำหรับ Knox Service', 'Standard', '\"select b.soc_name, a.*   from csm_offer_param a, csm_offer b  where a.soc_cd = b.soc_cd  and param_name =\'KNOX\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A008', 'หา Soc Resource สำหรับ Multisim กรณี Physical SIM', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=RES%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A009', 'หา Soc Resource สำหรับ Multisim กรณี eSIM', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=REE%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A010', 'หา Soc RC สำหรับ Multisim', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and soc_properties like \'%TR_MULTISIM_IND=RCM%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A011', 'หา Soc CUG (Additional)', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and sale_context = \'S\'  and soc_properties LIKE \'%CUG_IND=Y%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A012', 'หา Soc CUG (Build-in)', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and sale_context = \'R\'  and soc_properties LIKE \'%CUG_IND=Y%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A013', 'หา Price Plan สำหรับ Hybrid', 'Standard', '\"select soc_cd,sys_creation_date,soc_name,soc_description,sale_eff_date,sale_exp_date,soc_type,sale_context,service_level,deploy_group_ind,product_type,rc_ind,duration,duration_uom,dur_calc_level  ,soc_properties  from csm_offer  where sale_exp_date > sysdate  and product_type in (\'RM\',\'RF\',\'RR\')  and soc_type = \'P\'  and soc_properties like \'%TR_PRODUCT_SUB_TYPE=H%\'\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A014', 'หาเบอร์ลูกค้า NB-IoT', 'Standard', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and subscriber_type in (\'INB\',\'ICA\')\"', 'CCBS', '1', '', '', '0', '', '', '', '', 'Enable'),
('A015', 'หาเบอร์ที่ใช้ eSIM (Apple Watch - Non QR Code)', 'Standard', '\"select b.subscriber_no,b.sys_creation_date,b.prim_resource_val,b.sub_status,b.subscriber_type,b.language  ,a.sys_creation_date sys_create_res, a.resource_type, a.resource_prm_cd,a.resource_Value,a.effective_date,a.expiration_Date,a.offer_instance_id  from agreement_resource a, subscriber b  where a.agreement_no = b.subscriber_no  and a.expiration_date is null  and a.resource_type = \'MID\'  and a.resource_value like \'NONE%\'\"', 'CCBS', '0.9', '', '', '0', '', '', '', '', 'Enable'),
('A016', 'หาเบอร์ที่ใช้ eSIM (iPhone - QR Code)', 'Standard', '\"select b.subscriber_no,b.sys_creation_date,b.prim_resource_val,b.sub_status,b.subscriber_type,b.language  ,a.sys_creation_date sys_create_res, a.resource_type, a.resource_prm_cd,a.resource_Value,a.effective_date,a.expiration_Date,a.offer_instance_id  from agreement_resource a, subscriber b  where a.agreement_no = b.subscriber_no  and a.expiration_date is null  and a.resource_type = \'MID\'  and a.resource_value not like \'NONE%\'\"', 'CCBS', '0.9', '', '', '0', '', '', '', '', 'Enable'),
('A017', 'หา Thai ID ที่มี Share Plan มากกว่า 1 กลุ่ม', 'Complex', '\"select * from  (select l9_identification,l9_related_subscriber,l9_installation_type, count(subscriber_no) count_group  from   (select subscriber_no,sub_status,a.customer_id,l9_identification,customer_type  ,a.ch_node_id,a.sys_creation_date,a.sys_update_date  ,link_prev_sub_no,link_next_sub_no  ,init_act_date,l9_installation_type,l9_related_subscriber,prim_resource_val  from subscriber a, customer b  where a.customer_id = b.customer_id   and l9_installation_type is not null  and customer_type = \'I\'  and l9_related_subscriber = \'0\') fsim  group by l9_identification,l9_related_subscriber,l9_installation_type) count_profile  where count_group > 1\"', 'CCBS', '0.7', '', '', '0', '', '', '', '', 'Enable'),
('A018', 'หาเบอร์ที่เป็น MNP Port In External (ต่างค่าย)', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_port_ind =\'I\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_installation_type is null  and l9_multi_sim_ind is null  --and l9_rec_operator = \'06\'  and l9_donor_operator not in (\'02\',\'06\')   and customer_id in (select customer_id from customer where customer_type =\'I\')\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable'),
('A019', 'หาเบอร์ที่เป็น MNP Port In Internal (ค่ายเดียวกัน)', 'Complex', '\"select subscriber_no,sys_creation_date,sys_update_date,prim_resource_val,customer_id,subscriber_Type,sub_status,l9_crd_status,l9_col_status,l9_barring_by_req  ,l9_port_ind,l9_donor_operator,l9_rec_operator--,l9_installation_type,l9_multi_sim_ind  ,init_act_date,effective_Date,orig_act_date,sub_status_date  from subscriber  where sub_status = \'A\'   and l9_port_ind =\'I\'  and l9_crd_status = \'NONE\'  and l9_col_status = \'NONE\'  and l9_installation_type is null  and l9_multi_sim_ind is null  --and l9_rec_operator = \'06\'  and l9_donor_operator in (\'02\',\'06\')   and customer_id in (select customer_id from customer where customer_type =\'I\')\"', 'CCBS', '0.7', '', '', '1', '', '', '', '', 'Enable');

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
