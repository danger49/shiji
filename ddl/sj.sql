/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : sj

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-12-03 20:56:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticekt_id` int(11) NOT NULL DEFAULT '0' COMMENT '票据id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '评论人',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '评论的内容',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Table structure for t_helps
-- ----------------------------
DROP TABLE IF EXISTS `t_helps`;
CREATE TABLE `t_helps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `categories_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `editor` varchar(191) NOT NULL,
  `summary` text NOT NULL,
  `content` text NOT NULL,
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮助信息表';

-- ----------------------------
-- Table structure for t_helps_categories
-- ----------------------------
DROP TABLE IF EXISTS `t_helps_categories`;
CREATE TABLE `t_helps_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮助信息分类表';

-- ----------------------------
-- Table structure for t_image
-- ----------------------------
DROP TABLE IF EXISTS `t_image`;
CREATE TABLE `t_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticekt_id` int(11) NOT NULL DEFAULT '0' COMMENT '票据id',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片url',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '图片类型',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据图片表';

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `sub_title` text NOT NULL,
  `author` varchar(191) NOT NULL,
  `summary` text NOT NULL,
  `content` text NOT NULL,
  `tags` text NOT NULL,
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻表';

-- ----------------------------
-- Table structure for t_ticket_base
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_base`;
CREATE TABLE `t_ticket_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '发行码',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '票名',
  `pyname` varchar(50) NOT NULL DEFAULT '' COMMENT '全拼',
  `rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '发行汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据基础数据表';

-- ----------------------------
-- Table structure for t_ticket_ext
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_ext`;
CREATE TABLE `t_ticket_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticekt_id` int(11) NOT NULL DEFAULT '0' COMMENT '票据id',
  `brief` varchar(255) NOT NULL DEFAULT '' COMMENT '简要-副标题',
  `resume` text NOT NULL COMMENT '名人简历',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据基础扩展表';

-- ----------------------------
-- Table structure for t_ticket_info
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_info`;
CREATE TABLE `t_ticket_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `end_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据当日信息表';

-- ----------------------------
-- Table structure for t_ticket_service
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_service`;
CREATE TABLE `t_ticket_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticekt_id` int(11) NOT NULL DEFAULT '0' COMMENT '票据id',
  `service_name` varchar(100) NOT NULL DEFAULT '' COMMENT '服务名字',
  `price` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '默认价格',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '总份数',
  `used_count` int(11) NOT NULL DEFAULT '0' COMMENT '已消耗份数',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务表';

-- ----------------------------
-- Table structure for t_trade_0
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_0`;
CREATE TABLE `t_trade_0` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_0
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_0`;
CREATE TABLE `t_trade_0_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_0
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_0`;
CREATE TABLE `t_trade_0_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_0
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_0`;
CREATE TABLE `t_trade_0_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_1
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_1`;
CREATE TABLE `t_trade_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_10
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_10`;
CREATE TABLE `t_trade_10` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_10
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_10`;
CREATE TABLE `t_trade_10_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_10
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_10`;
CREATE TABLE `t_trade_10_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_10
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_10`;
CREATE TABLE `t_trade_10_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_11
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_11`;
CREATE TABLE `t_trade_11` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_11
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_11`;
CREATE TABLE `t_trade_11_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_11
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_11`;
CREATE TABLE `t_trade_11_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_11
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_11`;
CREATE TABLE `t_trade_11_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_12
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_12`;
CREATE TABLE `t_trade_12` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_12
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_12`;
CREATE TABLE `t_trade_12_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_12
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_12`;
CREATE TABLE `t_trade_12_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_12
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_12`;
CREATE TABLE `t_trade_12_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_13
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_13`;
CREATE TABLE `t_trade_13` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_13
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_13`;
CREATE TABLE `t_trade_13_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_13
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_13`;
CREATE TABLE `t_trade_13_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_13
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_13`;
CREATE TABLE `t_trade_13_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_14
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_14`;
CREATE TABLE `t_trade_14` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_14
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_14`;
CREATE TABLE `t_trade_14_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_14
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_14`;
CREATE TABLE `t_trade_14_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_14
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_14`;
CREATE TABLE `t_trade_14_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_15
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_15`;
CREATE TABLE `t_trade_15` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_15
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_15`;
CREATE TABLE `t_trade_15_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_15
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_15`;
CREATE TABLE `t_trade_15_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_15
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_15`;
CREATE TABLE `t_trade_15_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_detail_1
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_1`;
CREATE TABLE `t_trade_1_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_1
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_1`;
CREATE TABLE `t_trade_1_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_1
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_1`;
CREATE TABLE `t_trade_1_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_2
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_2`;
CREATE TABLE `t_trade_2` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_2
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_2`;
CREATE TABLE `t_trade_2_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_2
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_2`;
CREATE TABLE `t_trade_2_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_2
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_2`;
CREATE TABLE `t_trade_2_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_3
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_3`;
CREATE TABLE `t_trade_3` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_3
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_3`;
CREATE TABLE `t_trade_3_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_3
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_3`;
CREATE TABLE `t_trade_3_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_3
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_3`;
CREATE TABLE `t_trade_3_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_4
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_4`;
CREATE TABLE `t_trade_4` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_4
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_4`;
CREATE TABLE `t_trade_4_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_4
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_4`;
CREATE TABLE `t_trade_4_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_4
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_4`;
CREATE TABLE `t_trade_4_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_5
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_5`;
CREATE TABLE `t_trade_5` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_5
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_5`;
CREATE TABLE `t_trade_5_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_5
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_5`;
CREATE TABLE `t_trade_5_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_5
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_5`;
CREATE TABLE `t_trade_5_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_6
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_6`;
CREATE TABLE `t_trade_6` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_6
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_6`;
CREATE TABLE `t_trade_6_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_6
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_6`;
CREATE TABLE `t_trade_6_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_6
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_6`;
CREATE TABLE `t_trade_6_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_7
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_7`;
CREATE TABLE `t_trade_7` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_7
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_7`;
CREATE TABLE `t_trade_7_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_7
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_7`;
CREATE TABLE `t_trade_7_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_7
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_7`;
CREATE TABLE `t_trade_7_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_8
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_8`;
CREATE TABLE `t_trade_8` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_8
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_8`;
CREATE TABLE `t_trade_8_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_8
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_8`;
CREATE TABLE `t_trade_8_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_8
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_8`;
CREATE TABLE `t_trade_8_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_trade_9
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_9`;
CREATE TABLE `t_trade_9` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `exchange_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '成交汇率',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易总量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据交易信息表';

-- ----------------------------
-- Table structure for t_trade_detail_9
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_detail_9`;
CREATE TABLE `t_trade_9_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '交易流水',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量(单位:sj)',
  `up_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看多人id',
  `down_userid` int(11) NOT NULL DEFAULT '0' COMMENT '看空人id',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='票据详情表';

-- ----------------------------
-- Table structure for t_trade_history_9
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_history_9`;
CREATE TABLE `t_trade_9_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '时间类型：1:1分,2:5分,3:15分,4:30分,5:1小时,6:4小时,7:日,8:周,9:月',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '阴阳线',
  `start_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '开盘汇率',
  `cur_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '收盘汇率',
  `max_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最高汇率',
  `min_rate` decimal(11,5) NOT NULL DEFAULT '0.00000' COMMENT '当前最低汇率',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易记录历史信息表';

-- ----------------------------
-- Table structure for t_trade_order_9
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_order_9`;
CREATE TABLE `t_trade_9_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_code` varchar(50) NOT NULL DEFAULT '' COMMENT '关联的发行码',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1看多，2看空',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '挂单量(单位:sj)',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂单表';

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `pwd` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  `nick` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `type` tinyint(2) NOT NULL COMMENT '用户类型，0 普通会员，1 经理',
  `mobile_no` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `identity_number` varchar(50) NOT NULL DEFAULT '' COMMENT '身份证号',
  `real_name` varchar(255) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `delete_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '辑逻删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';
