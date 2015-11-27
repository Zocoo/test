/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50133
Source Host           : localhost:3306
Source Database       : oms2.1

Target Server Type    : MYSQL
Target Server Version : 50133
File Encoding         : 65001

Date: 2015-11-27 10:13:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for batches
-- ----------------------------
DROP TABLE IF EXISTS `batches`;
CREATE TABLE `batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '批次ID',
  `main_batch_id` int(11) DEFAULT NULL COMMENT '主批次ID',
  `office_id` int(11) DEFAULT NULL COMMENT '办事处ID',
  `number` varchar(45) NOT NULL COMMENT '编号',
  `start_at` int(11) DEFAULT NULL COMMENT '批次日期',
  `name` varchar(45) DEFAULT NULL COMMENT '批次名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='批次信息';

-- ----------------------------
-- Table structure for business_types
-- ----------------------------
DROP TABLE IF EXISTS `business_types`;
CREATE TABLE `business_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '业务类型名称',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司业务类型';

-- ----------------------------
-- Table structure for configs
-- ----------------------------
DROP TABLE IF EXISTS `configs`;
CREATE TABLE `configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统配置ID',
  `key` varchar(30) DEFAULT NULL COMMENT '系统配置Key',
  `value` varchar(50) DEFAULT NULL COMMENT '系统配置Value',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置常量';

-- ----------------------------
-- Table structure for device_annexs
-- ----------------------------
DROP TABLE IF EXISTS `device_annexs`;
CREATE TABLE `device_annexs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_process_id` int(11) DEFAULT NULL COMMENT '订单流水ID',
  `device_detail_id` int(11) DEFAULT NULL COMMENT '设备详情ID',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `name` varchar(120) DEFAULT NULL COMMENT '名称',
  `url` text COMMENT '路径',
  `order_status` int(11) DEFAULT NULL COMMENT '订单当前状态',
  `status` int(11) DEFAULT NULL COMMENT '设备状态',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `device_detail_id` (`device_detail_id`),
  CONSTRAINT `device_annexs_ibfk_1` FOREIGN KEY (`device_detail_id`) REFERENCES `device_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备图片';

-- ----------------------------
-- Table structure for device_categories
-- ----------------------------
DROP TABLE IF EXISTS `device_categories`;
CREATE TABLE `device_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备分类ID',
  `name` varchar(30) DEFAULT NULL COMMENT '设备分类名称',
  `intro` varchar(200) DEFAULT NULL COMMENT '设备分类描述',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='设备种类';

-- ----------------------------
-- Table structure for device_details
-- ----------------------------
DROP TABLE IF EXISTS `device_details`;
CREATE TABLE `device_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单设备详细信息ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `device_category_id` int(11) DEFAULT NULL COMMENT '设备分类ID',
  `device_type_id` int(11) DEFAULT NULL COMMENT '设备型号ID',
  `unique_code` varchar(30) DEFAULT NULL COMMENT '设备唯一标识码',
  `sno` varchar(64) DEFAULT NULL COMMENT '设备序列号',
  `esn` varchar(30) DEFAULT NULL COMMENT '设备ESN码',
  `mac` varchar(64) DEFAULT NULL COMMENT '设备系统mac',
  `status` int(11) DEFAULT NULL COMMENT '设备状态',
  `type` int(11) DEFAULT NULL COMMENT '设备类型,正常安装或者更换设备',
  `open_at` int(11) DEFAULT NULL,
  `close_at` int(11) DEFAULT NULL,
  `main` tinyint(1) DEFAULT NULL COMMENT '是否为主设备[显示屏]',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  `scene_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `device_category_id` (`device_category_id`),
  KEY `device_type_id` (`device_type_id`),
  CONSTRAINT `device_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `device_details_ibfk_2` FOREIGN KEY (`device_category_id`) REFERENCES `device_categories` (`id`),
  CONSTRAINT `device_details_ibfk_3` FOREIGN KEY (`device_type_id`) REFERENCES `device_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='订单设备详细信息';

-- ----------------------------
-- Table structure for device_processes
-- ----------------------------
DROP TABLE IF EXISTS `device_processes`;
CREATE TABLE `device_processes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_detail_id` int(11) NOT NULL COMMENT '设备ID',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人',
  `status` int(11) DEFAULT NULL COMMENT '设备状态',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `device_detail_id` (`device_detail_id`),
  CONSTRAINT `device_processes_ibfk_1` FOREIGN KEY (`device_detail_id`) REFERENCES `device_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for device_types
-- ----------------------------
DROP TABLE IF EXISTS `device_types`;
CREATE TABLE `device_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备型号ID',
  `device_category_id` int(11) DEFAULT NULL COMMENT '设备分类ID',
  `name` varchar(30) DEFAULT NULL COMMENT '设备型号名称',
  `intro` varchar(200) DEFAULT NULL COMMENT '设备型号描述',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `device_category_id` (`device_category_id`),
  CONSTRAINT `device_types_ibfk_1` FOREIGN KEY (`device_category_id`) REFERENCES `device_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='每种类别的设备有多种型号';

-- ----------------------------
-- Table structure for dispatch_orders
-- ----------------------------
DROP TABLE IF EXISTS `dispatch_orders`;
CREATE TABLE `dispatch_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `main_batch_id` int(11) DEFAULT NULL COMMENT '总批次ID',
  `party_a` varchar(120) DEFAULT NULL COMMENT '甲方',
  `party_b` varchar(120) DEFAULT NULL COMMENT '乙方',
  `manager` varchar(45) DEFAULT NULL COMMENT '片区经理',
  `manager_mobile` varchar(13) DEFAULT NULL COMMENT '经理联系电话',
  `charge` varchar(45) DEFAULT NULL COMMENT '负责人',
  `charge_mobile` varchar(20) DEFAULT NULL COMMENT '现场负责人电话',
  `description` text COMMENT '派工单描述',
  `duration` int(11) DEFAULT NULL COMMENT '工期时间,单位秒',
  `start_at` int(11) DEFAULT NULL COMMENT '开工时间',
  `province_id` int(11) DEFAULT NULL COMMENT '省',
  `city_id` int(11) DEFAULT NULL COMMENT '市',
  `district_id` int(11) DEFAULT NULL COMMENT '区',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `main_batch_id` (`main_batch_id`),
  CONSTRAINT `dispatch_orders_ibfk_1` FOREIGN KEY (`main_batch_id`) REFERENCES `main_batches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='派工单';

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `name` varchar(20) DEFAULT NULL COMMENT '组名称',
  `profile` varchar(300) DEFAULT NULL COMMENT '组简介',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='组';

-- ----------------------------
-- Table structure for group_regions
-- ----------------------------
DROP TABLE IF EXISTS `group_regions`;
CREATE TABLE `group_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组区域ID',
  `group_id` int(11) DEFAULT NULL COMMENT '组ID',
  `province_id` int(11) DEFAULT NULL COMMENT '省',
  `city_id` int(11) DEFAULT NULL COMMENT '市',
  `dstrict_id` int(11) DEFAULT NULL COMMENT '区',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_regions_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组区域关系';

-- ----------------------------
-- Table structure for group_resources
-- ----------------------------
DROP TABLE IF EXISTS `group_resources`;
CREATE TABLE `group_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组资源ID',
  `group_id` int(11) NOT NULL COMMENT '组ID',
  `resource_id` int(11) NOT NULL COMMENT '资源ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `group_resources_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `group_resources_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组所拥有的资源';

-- ----------------------------
-- Table structure for inpowers
-- ----------------------------
DROP TABLE IF EXISTS `inpowers`;
CREATE TABLE `inpowers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `privilege_id` int(11) NOT NULL COMMENT '权限ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `privilege_id` (`privilege_id`),
  CONSTRAINT `inpowers_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `inpowers_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限';

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL COMMENT '日志ID',
  `operator_id` varchar(30) DEFAULT NULL COMMENT '操作人ID',
  `operator_ip` varchar(50) DEFAULT NULL COMMENT '操作人IP',
  `type` varchar(200) DEFAULT NULL COMMENT '操作类型修改，删除等',
  `target_id` int(11) DEFAULT NULL COMMENT '操作对象ID',
  `target_value` varchar(50) DEFAULT NULL COMMENT '对象当前值，修改前的值',
  `remark` varchar(45) DEFAULT NULL COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Table structure for main_batches
-- ----------------------------
DROP TABLE IF EXISTS `main_batches`;
CREATE TABLE `main_batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(45) NOT NULL COMMENT '批次号',
  `start_at` int(11) DEFAULT NULL COMMENT '开始时间',
  `name` varchar(45) DEFAULT NULL COMMENT '批次名称',
  `office_id` int(11) DEFAULT NULL COMMENT '办事处ID',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='总批次';

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `father_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(128) DEFAULT NULL COMMENT '菜单URL',
  `cls` varchar(30) DEFAULT NULL COMMENT 'div class',
  `brief` varchar(200) DEFAULT NULL COMMENT '描述',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='功能菜单';

-- ----------------------------
-- Table structure for offices
-- ----------------------------
DROP TABLE IF EXISTS `offices`;
CREATE TABLE `offices` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '办事处ID',
  `name` varchar(45) NOT NULL COMMENT '办事处名称',
  `father_id` int(11) DEFAULT NULL COMMENT '父级办事处',
  `province_id` int(11) DEFAULT NULL COMMENT '省',
  `city_id` int(11) DEFAULT NULL COMMENT '市',
  `district_id` int(11) DEFAULT NULL COMMENT '区',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `manager` varchar(20) DEFAULT NULL COMMENT '负责人姓名',
  `manager_mobile` varchar(20) DEFAULT NULL COMMENT '负责人手机号码',
  `address` text COMMENT '办事处地址',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='办事处信息';

-- ----------------------------
-- Table structure for office_project_teams
-- ----------------------------
DROP TABLE IF EXISTS `office_project_teams`;
CREATE TABLE `office_project_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `project_teams_id` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operates
-- ----------------------------
DROP TABLE IF EXISTS `operates`;
CREATE TABLE `operates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作ID',
  `name` varchar(10) DEFAULT NULL COMMENT '操作名称',
  `profile` varchar(300) DEFAULT NULL COMMENT '操作简介',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作';

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `main_batch_id` int(11) DEFAULT NULL COMMENT '总批次',
  `batch_id` int(11) DEFAULT NULL COMMENT '批次ID',
  `project_team_id` int(11) DEFAULT NULL COMMENT '工程队ID',
  `scene_id` int(11) DEFAULT NULL COMMENT '场景ID',
  `order_no` varchar(20) DEFAULT NULL COMMENT '订单号',
  `contract_no` varchar(64) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL COMMENT '区域ID',
  `city_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '订单类型',
  `project_name` varchar(128) DEFAULT NULL COMMENT '订单所属项目',
  `status` int(11) DEFAULT NULL COMMENT '订单状态',
  `start_at` int(11) DEFAULT NULL COMMENT '开始时间',
  `complete_date` int(11) DEFAULT NULL COMMENT '完成时间',
  `duration` int(11) DEFAULT NULL COMMENT '工期时间,单位秒',
  `total_fee` int(11) DEFAULT NULL COMMENT '金额，单位分',
  `deadline` int(11) DEFAULT NULL COMMENT '截止有效期',
  `count` int(11) DEFAULT NULL COMMENT '设备总量',
  `priority` int(11) DEFAULT NULL COMMENT '优先级,1:低,2:中,3:高',
  `publish` int(11) DEFAULT NULL COMMENT '1:总批次导入\\n2:下发未确认\\n3:下发完成',
  `uploaded` tinyint(1) DEFAULT NULL COMMENT '是否提交资料',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `main_batche_id` (`main_batch_id`),
  KEY `batch_id` (`batch_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`main_batch_id`) REFERENCES `main_batches` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COMMENT='订单';

-- ----------------------------
-- Table structure for order_annexs
-- ----------------------------
DROP TABLE IF EXISTS `order_annexs`;
CREATE TABLE `order_annexs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单附件ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `name` varchar(30) DEFAULT NULL COMMENT '附件名称',
  `url` varchar(128) DEFAULT NULL COMMENT '附件URL',
  `thumbnailUrl` varchar(128) DEFAULT NULL COMMENT '附件缩略图URL',
  `annex_no` varchar(20) DEFAULT NULL COMMENT '附件序号',
  `intro` varchar(500) DEFAULT NULL COMMENT '附件描述',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_annexs_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='订单附件';

-- ----------------------------
-- Table structure for order_processes
-- ----------------------------
DROP TABLE IF EXISTS `order_processes`;
CREATE TABLE `order_processes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单流向ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人',
  `assigner_id` int(11) DEFAULT NULL COMMENT '下发人ID',
  `type` int(11) DEFAULT NULL COMMENT '1.办事处\n2.工程队',
  `owner_id` int(11) DEFAULT NULL COMMENT '属主ID',
  `remark` text COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `created_at` int(11) DEFAULT NULL COMMENT '操作时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_processes_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8 COMMENT='订单流程';

-- ----------------------------
-- Table structure for patrol_logs
-- ----------------------------
DROP TABLE IF EXISTS `patrol_logs`;
CREATE TABLE `patrol_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene_id` int(11) NOT NULL COMMENT '场景ID',
  `user_id` int(11) NOT NULL COMMENT '巡检人ID',
  `pass` tinyint(1) DEFAULT NULL COMMENT '是否巡检',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `patrol_logs_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='巡查记录';

-- ----------------------------
-- Table structure for privileges
-- ----------------------------
DROP TABLE IF EXISTS `privileges`;
CREATE TABLE `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Privilege_ID',
  `operate_id` int(11) NOT NULL COMMENT '操作人ID',
  `resource_id` int(11) NOT NULL COMMENT '资源ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `operate_resource_id` (`operate_id`,`resource_id`) USING BTREE,
  KEY `operate_id` (`operate_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `privileges_ibfk_1` FOREIGN KEY (`operate_id`) REFERENCES `operates` (`id`),
  CONSTRAINT `privileges_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
-- Table structure for project_teams
-- ----------------------------
DROP TABLE IF EXISTS `project_teams`;
CREATE TABLE `project_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工程队ID',
  `name` varchar(45) NOT NULL COMMENT '工程队名称',
  `address` text COMMENT '工程队地址',
  `province_id` int(11) NOT NULL COMMENT '省',
  `city_id` int(11) NOT NULL COMMENT '市',
  `district_id` int(11) DEFAULT NULL COMMENT '区',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `licence` varchar(128) DEFAULT NULL COMMENT '许可证号',
  `licence_image` varchar(128) DEFAULT NULL COMMENT '许可正照片',
  `manager_mobile` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `income` int(11) DEFAULT NULL COMMENT '收入金额',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话座机',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='工程队';

-- ----------------------------
-- Table structure for project_team_replace_logs
-- ----------------------------
DROP TABLE IF EXISTS `project_team_replace_logs`;
CREATE TABLE `project_team_replace_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工程队更换日志ID',
  `project_team_id` int(11) NOT NULL COMMENT '原工程队ID',
  `replace_project_team_id` int(11) NOT NULL COMMENT '更换工程队ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `status` int(11) DEFAULT NULL COMMENT '更换时的状态',
  `remark` text COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工程队更换记录';

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域编号',
  `name` varchar(20) NOT NULL COMMENT '区域名称',
  `level` smallint(6) NOT NULL COMMENT '区域等级',
  `father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父区域ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=820001 DEFAULT CHARSET=utf8 COMMENT='地区';

-- ----------------------------
-- Table structure for replace_logs
-- ----------------------------
DROP TABLE IF EXISTS `replace_logs`;
CREATE TABLE `replace_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备更换ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `device_detail_id` int(11) NOT NULL COMMENT '设备详情ID',
  `replace_device_detail_id` int(11) NOT NULL COMMENT '被更换设备的ID',
  `order_status` int(11) DEFAULT NULL COMMENT '订单当前状态',
  `status` int(11) DEFAULT NULL COMMENT '设备状态',
  `remark` varchar(45) DEFAULT NULL COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `replace_logs_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备更换记录';

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '资源ID',
  `name` varchar(50) DEFAULT NULL COMMENT '资源名称',
  `type` varchar(45) DEFAULT NULL COMMENT '资源类型',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `profile` varchar(300) DEFAULT NULL COMMENT '角色简介',
  `type` int(1) DEFAULT NULL COMMENT '0系统角色,1总部角色,2办事处角色,3工程队角色',
  `level` int(1) DEFAULT NULL COMMENT '角色等级,0最高级[老板、系统管理员]、1负责人、2普通成员',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Table structure for role_menus
-- ----------------------------
DROP TABLE IF EXISTS `role_menus`;
CREATE TABLE `role_menus` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `role_menus_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `role_menus_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for samples
-- ----------------------------
DROP TABLE IF EXISTS `samples`;
CREATE TABLE `samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '抽检结果ID',
  `office_id` int(11) DEFAULT NULL COMMENT '办事处ID',
  `batch_id` int(11) NOT NULL COMMENT '批次ID',
  `batch_number` varchar(45) NOT NULL COMMENT '批次编号',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `scene_id` int(11) DEFAULT NULL COMMENT '场景Id',
  `user_id` int(11) DEFAULT NULL COMMENT '抽检人',
  `number` varchar(45) NOT NULL COMMENT '抽检批次编号',
  `pass` tinyint(1) DEFAULT NULL COMMENT '验收是否通过',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `batch_id` (`batch_id`),
  KEY `order_id` (`order_id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `samples_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`id`),
  CONSTRAINT `samples_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `samples_ibfk_3` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抽检结果';

-- ----------------------------
-- Table structure for scenes
-- ----------------------------
DROP TABLE IF EXISTS `scenes`;
CREATE TABLE `scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '场景ID',
  `province_id` int(11) DEFAULT NULL COMMENT '省',
  `city_id` int(11) DEFAULT NULL COMMENT '市',
  `district_id` int(11) DEFAULT NULL COMMENT '区',
  `place` varchar(30) DEFAULT NULL COMMENT '所',
  `contract_no` varchar(50) DEFAULT NULL COMMENT '合同号',
  `email` varchar(80) DEFAULT NULL COMMENT '邮箱地址',
  `registered_name` varchar(100) DEFAULT NULL COMMENT '企业注册名称',
  `registered_address` varchar(200) DEFAULT NULL COMMENT '企业注册地址',
  `business_name` varchar(100) DEFAULT NULL COMMENT '企业经营名称',
  `business_address` varchar(200) DEFAULT NULL COMMENT '企业经营地址',
  `biz_type` int(11) DEFAULT NULL COMMENT '业务类型，餐饮，网吧等',
  `biz_area` varchar(20) DEFAULT NULL COMMENT '经营面积',
  `biz_scope` text COMMENT '经营范围',
  `legal_person` varchar(30) DEFAULT NULL COMMENT '企业法人',
  `legal_person_phone` varchar(20) DEFAULT NULL COMMENT '企业法人联系方式',
  `responsible_person` varchar(30) DEFAULT NULL COMMENT '店面负责人',
  `responsible_person_phone` varchar(20) DEFAULT NULL COMMENT '店面负责人联系方式',
  `phone` varchar(20) DEFAULT NULL,
  `biz_licence_no` varchar(45) DEFAULT NULL COMMENT '经营许可证号',
  `longitude` varchar(50) DEFAULT NULL COMMENT '精度',
  `latitude` varchar(50) DEFAULT NULL COMMENT '纬度',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否可用',
  `responsible_person_tel` varchar(20) DEFAULT NULL,
  `biz_type_parent` int(11) DEFAULT NULL,
  `shop_account` varchar(50) DEFAULT NULL,
  `biz_owner_account` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COMMENT='设备安装的场景[一家高档餐厅、一家小餐馆、一个小当铺]';

-- ----------------------------
-- Table structure for scene_annexs
-- ----------------------------
DROP TABLE IF EXISTS `scene_annexs`;
CREATE TABLE `scene_annexs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene_id` int(11) DEFAULT NULL COMMENT '场景ID',
  `url` varchar(128) DEFAULT NULL COMMENT '图片地址',
  `type` int(11) DEFAULT NULL COMMENT '图片类型',
  `name` varchar(45) DEFAULT NULL COMMENT '图片名称',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `scene_annexs_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '1',
  `updated_at` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1.订单状态\n2.设备状态',
  `required` tinyint(1) DEFAULT '1' COMMENT '是否必选',
  `app_display` tinyint(1) DEFAULT '1' COMMENT 'app是否显示',
  `priority` int(11) DEFAULT NULL COMMENT '优先级，排序用，备用',
  `father_id` int(11) DEFAULT NULL COMMENT '设备所属订单状态的id',
  `code` varchar(10) DEFAULT NULL COMMENT '标识码',
  `intro` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='订单状态';

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(20) NOT NULL COMMENT '用户名称',
  `password` varchar(64) NOT NULL COMMENT '用户密码',
  `is_lock` tinyint(1) DEFAULT '0' COMMENT '用户锁定',
  `real_name` varchar(30) DEFAULT NULL COMMENT '用户实名',
  `gender` int(11) DEFAULT NULL COMMENT '性别',
  `age` int(3) DEFAULT NULL COMMENT '年龄',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `mobile_phone` varchar(20) NOT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `avatar` text COMMENT '头像',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `id_card_positive` varchar(128) DEFAULT NULL COMMENT '身份证正面',
  `id_card_negative` varchar(128) DEFAULT NULL COMMENT '身份证反面',
  `verify_code` varchar(8) DEFAULT NULL COMMENT '验证码',
  `verify_code_effective_time` int(11) DEFAULT NULL COMMENT '验证码生效时间',
  `province_id` int(11) DEFAULT NULL COMMENT '省',
  `city_id` int(11) DEFAULT NULL COMMENT '市',
  `district_id` int(11) DEFAULT NULL COMMENT '区',
  `address` varchar(300) DEFAULT NULL COMMENT '详情地址',
  `salt` varchar(32) DEFAULT NULL COMMENT '盐',
  `type` int(11) DEFAULT NULL COMMENT '0总部，1办事处，2工程队，3系统用户,默认null(无归属)',
  `owner_id` int(11) DEFAULT NULL COMMENT '属主ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  `role` int(11) DEFAULT NULL COMMENT '1[系统管理员、老板、负责人],2普通成员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_phone_UNIQUE` (`mobile_phone`),
  UNIQUE KEY `User_Name_UNIQUE` (`name`),
  UNIQUE KEY `User_Email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for user_group_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_group_roles`;
CREATE TABLE `user_group_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户-组-角色ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `group_id` int(11) NOT NULL COMMENT '组ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`,`group_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_group_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_group_roles_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_group_roles_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户在该组所扮演的角色';

-- ----------------------------
-- Table structure for user_office_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_office_roles`;
CREATE TABLE `user_office_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户-组-角色ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `office_id` int(11) NOT NULL COMMENT '组ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_office_id` (`user_id`,`office_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  KEY `office_id` (`office_id`) USING BTREE,
  CONSTRAINT `user_office_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_office_roles_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `offices` (`id`),
  CONSTRAINT `user_office_roles_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户在该组所扮演的角色';

-- ----------------------------
-- Table structure for user_project_team_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_project_team_roles`;
CREATE TABLE `user_project_team_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户-组-角色ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `project_team_id` int(11) NOT NULL COMMENT '组ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`,`project_team_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  KEY `project_team_id` (`project_team_id`) USING BTREE,
  CONSTRAINT `user_project_team_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_project_team_roles_ibfk_2` FOREIGN KEY (`project_team_id`) REFERENCES `project_teams` (`id`),
  CONSTRAINT `user_project_team_roles_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='用户在该组所扮演的角色';
