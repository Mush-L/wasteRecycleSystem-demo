/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : waste_recycle

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 20/05/2022 19:03:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_auuser
-- ----------------------------
DROP TABLE IF EXISTS `sys_auuser`;
CREATE TABLE `sys_auuser`  (
  `au_id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'audit id',
  `u_id` int(0) NULL DEFAULT NULL COMMENT '用户id',
  `u_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `u_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `u_age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `u_phone` int(0) NULL DEFAULT NULL COMMENT '电话',
  `u_email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `au_reason` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户信息修改原因',
  `a_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理管理员',
  `au_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `au_state` enum('未完成','已完成') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未完成' COMMENT '审核状态',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`au_id`) USING BTREE,
  INDEX `用户id`(`u_id`) USING BTREE,
  CONSTRAINT `用户id` FOREIGN KEY (`u_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审核用户' ROW_FORMAT = Dynamic STATS_AUTO_RECALC = 1;

-- ----------------------------
-- Records of sys_auuser
-- ----------------------------
INSERT INTO `sys_auuser` VALUES (1, 6, NULL, '男', 22, NULL, NULL, '修改年龄', 'mush', '已通过', '已完成', '2022-05-02 16:10:15');
INSERT INTO `sys_auuser` VALUES (7, 6, NULL, NULL, NULL, NULL, NULL, '修改电话', 'mush', '已拒绝', '已完成', '2022-05-02 17:02:06');
INSERT INTO `sys_auuser` VALUES (8, 6, NULL, NULL, NULL, NULL, NULL, 'CES ', 'mush', '已拒绝', '已完成', '2022-05-02 17:02:02');
INSERT INTO `sys_auuser` VALUES (9, 6, '千羽', '保密', 22, 1731371737, NULL, 'test', 'mush', '已通过', '已完成', '2022-05-02 20:28:25');
INSERT INTO `sys_auuser` VALUES (10, 6, NULL, NULL, 21, NULL, NULL, NULL, 'mush', '已通过', '已完成', '2022-05-02 17:07:09');
INSERT INTO `sys_auuser` VALUES (11, 6, NULL, NULL, NULL, 123, NULL, '计划骨结核n', 'mush', '已拒绝', '已完成', '2022-05-02 20:50:54');
INSERT INTO `sys_auuser` VALUES (12, 23, '', '男', 23, 1737311713, NULL, '部分信息错误', NULL, NULL, '未完成', NULL);
INSERT INTO `sys_auuser` VALUES (13, 28, '罗帅程', '男', 22, NULL, NULL, '修改姓名、性别、年龄', NULL, NULL, '未完成', NULL);

-- ----------------------------
-- Table structure for sys_auwaste
-- ----------------------------
DROP TABLE IF EXISTS `sys_auwaste`;
CREATE TABLE `sys_auwaste`  (
  `au_id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'audit的id',
  `w_id` int(0) NULL DEFAULT NULL COMMENT '物品id',
  `u_id` int(0) NOT NULL COMMENT '用户id',
  `w_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称，可有可无',
  `w_type1` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大类',
  `w_type2` enum('废旧金属','废旧电子','废旧塑料','废旧橡胶','废旧纸张','纺织皮革','办公设备','废旧电器','废品处理设备','医疗设备','其他设备','废旧玻璃','工程拆除') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小类',
  `w_type3` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情',
  `w_w` double(6, 2) NULL DEFAULT NULL COMMENT '重量',
  `w_v` double(5, 2) NULL DEFAULT NULL COMMENT '体积',
  `w_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `t_date` date NULL DEFAULT NULL COMMENT '任务日期',
  `t_address1` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务地址1',
  `t_address2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务地址2',
  `t_photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务图片地址',
  `t_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务描述',
  `au_reason` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务修改原因',
  `a_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理管理员',
  `au_result` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `au_state` enum('未完成','已完成') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未完成' COMMENT '审核状态',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`au_id`) USING BTREE,
  INDEX `w_id`(`w_id`) USING BTREE,
  INDEX `u_id`(`u_id`) USING BTREE,
  CONSTRAINT `sys_auwaste_ibfk_1` FOREIGN KEY (`w_id`) REFERENCES `sys_waste` (`w_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `sys_auwaste_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务信息的修改审核' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auwaste
-- ----------------------------
INSERT INTO `sys_auwaste` VALUES (1, 2, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '没啥描述', '没啥原因', 'mush', '已通过', '已完成', '2022-05-02 17:32:43');
INSERT INTO `sys_auwaste` VALUES (2, 48, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ' ', NULL, '面交优先', '更改地址备注', 'mush', '已通过', '已完成', '2022-05-02 18:31:52');
INSERT INTO `sys_auwaste` VALUES (3, 49, 6, NULL, NULL, NULL, '撒旦', 2.20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '没有原因！', 'mush', '已拒绝', '已完成', '2022-05-02 18:35:35');
INSERT INTO `sys_auwaste` VALUES (4, NULL, 6, '大炮', '金属电子', '废旧金属', '废铁', 50.00, 2.10, '大炮轰蚊子', '2022-05-03', '北京市/市辖区/东城区', '如图所示', NULL, '蚊子没了', '发布新任务', 'mush', '已通过', '已完成', '2022-05-02 22:26:49');
INSERT INTO `sys_auwaste` VALUES (5, NULL, 6, 'sda hgvbyuj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '发布新任务', 'mush', '已拒绝', '已完成', '2022-05-02 23:02:04');
INSERT INTO `sys_auwaste` VALUES (6, NULL, 4, '哈皮罗', '工程玻璃', '工程拆除', '建筑违章', 80.00, 1.50, '傻逼罗', '2022-05-05', '江苏省/镇江市/丹阳市', '自寻死路', NULL, '废品哈皮罗一只', '发布新任务', 'mush', '已通过', '已完成', '2022-05-02 23:09:30');
INSERT INTO `sys_auwaste` VALUES (7, 46, 4, NULL, '塑料橡胶', '废旧塑料', '通用塑料', 0.01, 0.01, '小魔方', '2022-05-18', '江苏省/无锡市/锡山区', '默认', NULL, '没啥', '重新申请', 'mush', '已通过', '已完成', '2022-05-03 08:11:04');
INSERT INTO `sys_auwaste` VALUES (8, 19, 23, NULL, NULL, NULL, NULL, NULL, NULL, '虽然只是普通的纸箱，但他也有不普通之处：他是豆子戈用过的。', NULL, NULL, NULL, NULL, '难以言说', '修改了部分内容', NULL, NULL, '未完成', '2022-05-03 08:15:16');
INSERT INTO `sys_auwaste` VALUES (9, NULL, 28, '趴趴', '纸张皮革', '纺织皮革', '布偶', 0.20, 0.10, '这是一只趴趴子，并不是fufu。', '2022-05-11', '江苏省/镇江市/丹徒区', '江苏科技大学长山校区', NULL, '家里大米被吃空了，不得不把她卖了。', '发布新任务', NULL, NULL, '未完成', NULL);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'dict 字典对照表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(0) NULL DEFAULT NULL COMMENT '文件大小（kb）',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载连接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件md5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用连接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件存储' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (6, 'earth.webp', 'webp', 7, 'http://localhost:9090/file/269835985cb2438096e43545ae1cf5b3.webp', 'cd50bc745aedef85257cd0de954d6fd2', 0, 1);
INSERT INTO `sys_file` VALUES (7, '幽鬼兔.png', 'png', 871, 'http://localhost:9090/file/09fc173c1c8b47b19ccc9c58d7b6b93e.png', '71a923491729a6f6043655ad581641be', 0, 1);
INSERT INTO `sys_file` VALUES (8, 'tx_铳.jpg', 'jpg', 167, 'http://localhost:9090/file/01170741d0244204a577d9e14af3f069.jpg', 'f301c2dc8bb0261550948dfc1ca9bc79', 0, 1);
INSERT INTO `sys_file` VALUES (9, '重铠.png', 'png', 776, 'http://localhost:9090/file/328c389188184c968af568c175a33abf.png', '3373fab6df2843644bf4772ad3f42b30', 0, 0);
INSERT INTO `sys_file` VALUES (10, '幽鬼兔异画.webp', 'webp', 65, 'http://localhost:9090/file/ff6f395d3ba14d02938fbe972e1b7219.webp', '40e14c922841063f7176b45e8d7d1f13', 0, 1);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `user_password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '123456' COMMENT '密码',
  `user_state` enum('S','A','B','M','Z') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'B' COMMENT '用户状态：A管理员B用户Z禁用',
  `user_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '保密' COMMENT '性别',
  `user_age` int(0) NULL DEFAULT 1 COMMENT '年龄',
  `user_phone` int(0) NULL DEFAULT 1001001000 COMMENT '电话',
  `user_email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户，包含管理员、普通用户、注销用户' ROW_FORMAT = Dynamic STATS_AUTO_RECALC = 1;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '木生火', 'mush', 'mushuo', 'S', '保密', 333, 1001001000, 'mush@mush.com', '2021-08-15 22:20:24');
INSERT INTO `sys_user` VALUES (2, '楠红红', 'nanhonghong', 'nanhonghong', 'S', '保密', 666, 1001001000, 'mush@mush.com', '2021-09-14 22:23:33');
INSERT INTO `sys_user` VALUES (3, '呆呆罗', 'daidailuo', 'daidailuo', 'S', '保密', 999, 1001001000, 'mush@mush.com', '2022-01-12 22:23:59');
INSERT INTO `sys_user` VALUES (4, '嬴非', 'yingfei', 'yingfei', 'A', '男', 31, 1010110000, 'mush@mush.com', '2021-12-01 00:51:01');
INSERT INTO `sys_user` VALUES (5, '嬴秦仲', 'qinzhong', 'qinzhong', 'A', '男', 23, 1001001000, 'mush@mush.com', '2022-02-16 00:51:01');
INSERT INTO `sys_user` VALUES (6, '千羽', 'qianyu', 'qianyu', 'B', '保密', 21, 1731371737, 'mush@mush.com', '2022-03-01 00:51:01');
INSERT INTO `sys_user` VALUES (7, '木风', 'mufeng', 'mufeng', 'B', '男', 23, 1001001000, 'mush@mush.com', '2022-04-26 00:51:01');
INSERT INTO `sys_user` VALUES (8, '王有财', 'wangshoucai', '123456', 'B', '男', 40, 1991231457, 'mush@mush.com', '2022-05-01 20:13:11');
INSERT INTO `sys_user` VALUES (9, '楠红红', 'hapiniu', 'nmsl', 'B', '男', 24, 1221312345, 'mush@mush.com', '2022-04-13 02:32:53');
INSERT INTO `sys_user` VALUES (15, '楠木', 'nanhgs', '123456', 'B', '保密', 23, 1001001000, 'mush@mush.com', '2022-05-25 18:04:05');
INSERT INTO `sys_user` VALUES (18, '大米洗澡', 'mYtis', '123456', 'B', '女', 7, 1001001000, 'mush@mush.com', '2021-12-20 20:03:41');
INSERT INTO `sys_user` VALUES (19, '萨法', 'assad', '123456', 'Z', '保密', 3200, 1001001000, 'mush@mush.com', '2021-10-26 20:04:58');
INSERT INTO `sys_user` VALUES (20, '阿撒托斯', 'Azathon', '123456', 'B', '保密', 10000, 1001001000, 'mush@mush.com', '2021-09-22 20:06:33');
INSERT INTO `sys_user` VALUES (23, '豆子戈', 'beanSkr', '123456', 'B', '女', 6, 1001001000, 'mush@mush.com', '2021-10-26 22:46:02');
INSERT INTO `sys_user` VALUES (24, '牛囧', 'NiuJio', '123456', 'B', '男', 3, 1771661757, 'mush@mush.com', '2021-10-21 23:51:36');
INSERT INTO `sys_user` VALUES (25, '撒旦', 'Mzza', 'mzzass', 'B', '保密', 666, 1331231313, 'mush@mush.com', '2021-10-27 23:06:03');
INSERT INTO `sys_user` VALUES (26, '王启', 'AwaQ', 'wangqi', 'B', '保密', 1, 1001001000, 'mush@mush.com', '2021-12-27 23:10:38');
INSERT INTO `sys_user` VALUES (28, '哈皮罗', 'HappyL', '123456', 'B', '女', 6, 1001001000, 'mush@mush.com', '2021-11-28 00:13:10');
INSERT INTO `sys_user` VALUES (29, '哈皮牛', 'HappyNew', 'happyn', 'B', '女', 18, 1001001000, 'mush@mush.com', '2021-11-28 19:37:37');
INSERT INTO `sys_user` VALUES (30, 'QWERT', ' qwert', '123456', 'Z', '保密', 1, 1001001000, 'mush@mush.com', '2022-04-28 23:33:49');
INSERT INTO `sys_user` VALUES (31, '张启明', 'QMZhang', '123456', 'B', '男', 42, 1313231233, 'mush@mush.com', '2022-04-29 21:00:19');
INSERT INTO `sys_user` VALUES (32, '太微', 'TaiWei', '123456', 'B', '保密', 1852, 1001001000, 'mush@mush.com', '2022-04-21 23:32:55');
INSERT INTO `sys_user` VALUES (33, '', '', '123456', 'Z', '', 1, 1001001000, 'mush@mush.com', '2022-05-01 01:22:46');

-- ----------------------------
-- Table structure for sys_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `sys_warehouse`;
CREATE TABLE `sys_warehouse`  (
  `wa_id` int(0) NULL DEFAULT NULL COMMENT '仓库存储ID',
  `w_id` int(0) NULL DEFAULT NULL COMMENT '唯一ID',
  `w_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称，可有可无',
  `w_type1` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大类',
  `w_type2` enum('废旧金属','废旧电子','废旧塑料','废旧橡胶','废旧纸张','纺织皮革','办公设备','废旧电器','废品处理设备','医疗设备','其他设备','废旧玻璃','工程拆除') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小类',
  `w_type3` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情',
  `w_w` double(6, 2) NULL DEFAULT 1.00 COMMENT '重量',
  `w_v` double(5, 2) NULL DEFAULT 1.00 COMMENT '体积',
  `w_photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品图片',
  `w_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `wa_state` enum('入库','出库') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '入库' COMMENT '物品状态：入库、出库',
  `in_admin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入库管理员',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `out_admin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出库管理员',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '出库时间',
  INDEX `w_name`(`w_name`) USING BTREE,
  INDEX `sys_warehouse_FK`(`w_id`) USING BTREE,
  CONSTRAINT `sys_warehouse_FK` FOREIGN KEY (`w_id`) REFERENCES `sys_waste` (`w_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_warehouse
-- ----------------------------
INSERT INTO `sys_warehouse` VALUES (1, 1, '呆呆罗', '塑料橡胶', '废旧塑料', '通用塑料', 60.50, 1.80, NULL, '奇妙的生物，它将是镇站之宝。', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (2, 2, '呆罗兽', '纸张皮革', '纺织皮革', '皮革制品', 120.20, 2.85, NULL, '镇站之宝的衍生产物，它真的很重。', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (3, 3, '废电池', '金属电子', '废旧电子', '电池', 0.58, 0.23, NULL, '一节更比六节强', '出库', 'mush', '2022-04-26 00:52:01', 'qianyu', '2022-05-10 20:31:35');
INSERT INTO `sys_warehouse` VALUES (4, 4, '饮料瓶', '塑料橡胶', '废旧塑料', '通用塑料', 1.58, 0.56, NULL, '饮料瓶', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (5, 5, '旧鼠标', '废旧设备', '办公设备', '其他设备', 0.02, 0.01, NULL, '或许是被人摔坏的', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (6, 6, '废钢', '金属电子', '废旧金属', '废钢', 9891.60, 1.26, NULL, '星辰降于野', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (7, 7, '废铁', '金属电子', '废旧金属', '废铁', 9360.00, 1.20, NULL, '星辰降于野', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (8, 8, '废铝', '金属电子', '废旧金属', '废铝', 1512.20, 0.56, NULL, '星辰降于野', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (9, 9, '拖线板', '金属电子', '废旧电子', '线路板', 2.50, 0.55, NULL, '星辰降于野', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (10, 20, '旧书', '纸张皮革', '废旧纸张', '旧书', 10.50, 0.30, NULL, '众星环北辰', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (11, 21, '棉花', '纸张皮革', '纺织皮革', '天然纺织原料', 1.35, 3.58, NULL, '众星环北辰', '入库', 'mush', '2022-04-26 00:52:01', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (12, 47, '降智魔方', '塑料橡胶', '废旧塑料', '通用塑料', 0.01, 0.01, NULL, '使用之后智商会下降！', '入库', 'mush', '2022-05-01 16:07:34', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (13, 48, '千秋斩', '金属电子', '废旧金属', '废钢', 0.50, 0.30, NULL, '一刀斩千秋，可惜生锈了', '入库', 'mush', '2022-05-01 16:45:14', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (14, 49, '撒旦', '塑料橡胶', '废旧橡胶', '未知分类', 2.20, 1.00, NULL, '啥也没有', '入库', 'mush', '2022-05-02 18:28:50', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (15, 51, '镜子', '工程玻璃', '废旧玻璃', '镜子', 0.01, 0.01, NULL, '魔镜，可能是白雪公主的', '入库', 'mush', '2022-05-02 22:09:26', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (16, 52, '大炮', '金属电子', '废旧金属', '废铁', 50.00, 2.10, NULL, '大炮轰蚊子', '入库', 'mush', '2022-05-02 22:26:48', NULL, '2022-05-10 16:56:33');
INSERT INTO `sys_warehouse` VALUES (17, 56, '哈皮罗', '工程玻璃', '工程拆除', '建筑违章', 80.00, 1.50, NULL, '傻逼罗', '入库', 'mush', '2022-05-02 23:09:30', NULL, '2022-05-10 16:56:33');

-- ----------------------------
-- Table structure for sys_waste
-- ----------------------------
DROP TABLE IF EXISTS `sys_waste`;
CREATE TABLE `sys_waste`  (
  `w_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `u_id` int(0) NULL DEFAULT NULL COMMENT '用户ID',
  `w_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称，可有可无',
  `w_type1` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大类',
  `w_type2` enum('废旧金属','废旧电子','废旧塑料','废旧橡胶','废旧纸张','纺织皮革','办公设备','废旧电器','废品处理设备','医疗设备','其他设备','废旧玻璃','工程拆除') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小类',
  `w_type3` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情',
  `w_w` double(6, 2) NULL DEFAULT 1.00 COMMENT '重量',
  `w_v` double(6, 2) NULL DEFAULT 1.00 COMMENT '体积',
  `w_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `t_date` date NULL DEFAULT NULL COMMENT '任务日期',
  `t_address1` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务地址1',
  `t_address2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务地址2',
  `t_photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务图片地址',
  `t_state` enum('待审核','发布中','已接取','已完成','已取消') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '待审核' COMMENT '任务状态：待审核、发布中、已接取、已完成、已取消',
  `t_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务描述',
  PRIMARY KEY (`w_id`) USING BTREE,
  INDEX `w_name`(`w_name`) USING BTREE,
  INDEX `t_user`(`u_id`) USING BTREE,
  CONSTRAINT `sys_waste_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_waste
-- ----------------------------
INSERT INTO `sys_waste` VALUES (1, 1, '呆呆罗', '塑料橡胶', '废旧塑料', '通用塑料', 60.50, 1.80, '奇妙的生物，它将是镇站之宝。', '2022-04-26 00:52:01', '2022-04-29', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '已完成', '默认');
INSERT INTO `sys_waste` VALUES (2, 1, '呆罗兽', '纸张皮革', '纺织皮革', '皮革制品', 120.20, 2.85, '镇站之宝的衍生产物，它真的很重。', '2022-04-26 00:52:01', '2022-04-29', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '已完成', '没啥描述');
INSERT INTO `sys_waste` VALUES (3, 15, '废电池', '金属电子', '废旧电子', '电池', 0.58, 0.23, '一节更比六节强', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (4, 15, '饮料瓶', '塑料橡胶', '废旧塑料', '通用塑料', 1.58, 0.56, '饮料瓶', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (5, 26, '旧鼠标', '废旧设备', '办公设备', '其他设备', 0.02, 0.01, '或许是被人摔坏的', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (6, 26, '废钢', '金属电子', '废旧金属', '废钢', 9891.60, 1.26, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (7, 26, '废铁', '金属电子', '废旧金属', '废铁', 9360.00, 1.20, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (8, 26, '废铝', '金属电子', '废旧金属', '废铝', 1512.20, 0.56, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/京口区', '江苏科技大学', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (9, 26, '拖线板', '金属电子', '废旧电子', '线路板', 2.50, 0.55, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (10, 26, '二极管', '金属电子', '废旧电子', '二极管', 3.68, 0.79, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (11, 26, '电容电阻', '金属电子', '废旧电子', '电容、电阻', 1.85, 0.57, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (12, 26, '可乐瓶', '塑料橡胶', '废旧塑料', '通用塑料', 0.95, 1.58, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (13, 18, '尼龙绳', '塑料橡胶', '废旧塑料', '工程塑料', 1.25, 0.86, '星辰降于野', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (14, 18, '泡沫塑料', '塑料橡胶', '废旧塑料', '特种塑料', 1.23, 5.20, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (15, 18, '旧电线', '塑料橡胶', '废旧橡胶', '电线皮', 5.63, 0.98, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (16, 19, '汽车轮胎', '塑料橡胶', '废旧橡胶', '轮胎', 15.20, 0.89, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/润州区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (17, 19, '橡胶垫', '塑料橡胶', '废旧橡胶', '合成橡胶', 12.50, 0.05, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (18, 23, '旧报纸', '纸张皮革', '废旧纸张', '报纸', 0.78, 0.50, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (19, 23, '纸箱', '纸张皮革', '废旧纸张', '纸箱', 0.60, 0.85, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (20, 5, '旧书', '纸张皮革', '废旧纸张', '旧书', 10.50, 0.30, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (21, 5, '棉花', '纸张皮革', '纺织皮革', '天然纺织原料', 1.35, 3.58, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/扬中市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (22, 5, '蚊帐', '纸张皮革', '纺织皮革', '纱、线、丝', 0.02, 0.03, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (23, 5, '布匹', '纸张皮革', '纺织皮革', '纺织面料', 1.58, 0.12, '众星环北辰', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (24, 4, '皮鞋', '纸张皮革', '纺织皮革', '皮革制品', 0.05, 0.03, 'XX皮革厂倒闭啦！', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (25, 7, '打印机', '废旧设备', '办公设备', '打印机', 0.53, 0.40, '他也曾健全，直到很多人来打印毕设。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/扬中市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (26, 7, '电话机', '废旧设备', '办公设备', '电话传真机', 0.05, 0.02, '旧时代的产物，似乎不多见了。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/扬中市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (27, 6, '复印机', '废旧设备', '办公设备', '复印机', 0.62, 0.40, '并不能复印钱。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (28, 8, '电视', '废旧设备', '废旧电器', '电视机', 35.60, 1.70, '这是台很普通的电视机，但是连续播放了1000小时', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (29, 9, '洗衣机', '废旧设备', '废旧电器', '洗衣机', 56.85, 2.30, '似乎是从龙手中夺下的。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (30, 25, '空调', '废旧设备', '废旧电器', '空调', 15.60, 1.50, '这台空调满是优点，如果能吹风它将是完美的。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (31, 15, '吸尘器', '废旧设备', '废旧电器', '其他电器', 1.80, 0.50, '或许是熊用的吸尘器，它被塞满了毛发。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (32, 6, '注塑机', '废旧设备', '废品处理设备', '注塑机', 386.70, 5.60, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/市辖区', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (33, 30, '磨粉机', '废旧设备', '废品处理设备', '磨粉机', 400.25, 3.20, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/句容市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (34, 25, '离心机', '废旧设备', '废品处理设备', '分离设备', 214.50, 10.80, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/句容市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (35, 6, '输液瓶', '废旧设备', '医疗设备', '废输液瓶', 3.60, 5.80, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/句容市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (36, 6, '注射管', '废旧设备', '医疗设备', '注射设备', 0.02, 0.20, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/句容市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (37, 6, '医疗设备', '废旧设备', '医疗设备', '医疗设备', 10.50, 2.80, NULL, '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/句容市', '、', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (38, 6, '啤酒瓶', '工程玻璃', '废旧玻璃', '酒瓶', 2.20, 0.80, '院子里挖出来的一扎啤酒，如果没有疫情它将还在土里。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (39, 8, '鱼缸', '工程玻璃', '废旧玻璃', '鱼缸', 3.00, 2.50, '鱼缸炸了，两只雷龙抬着鱼缸如是说。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (40, 7, '玻璃杯', '工程玻璃', '废旧玻璃', '玻璃瓶罐', 0.10, 0.01, '或许是商周传下来的，也或许是上周的。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (41, 26, '建筑拆除', '工程玻璃', '工程拆除', '建筑拆除', 5.30, 6.00, '抵制豆腐渣工程，共建和谐土木。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (42, 4, '设备拆除', '工程玻璃', '工程拆除', '设备拆除', 1.25, 10.20, '甲方跑路，惨遭拆除', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (43, 5, '其他拆除', '工程玻璃', '工程拆除', '其他', 4.32, 1.50, '原本可以使用二十年，但是甲方跑路了。', '2022-04-26 00:52:01', '2022-04-30', '江苏省/镇江市/丹徒区', '江科大新校区', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (44, 4, '秦鼎', '金属电子', '废旧金属', '废铜', 9896.80, 2.40, '祖传大鼎，可惜生锈了。', '2022-04-26 00:52:01', '2022-04-30', '陕西省/西安市/临潼区', '秦陵', NULL, '发布中', '默认');
INSERT INTO `sys_waste` VALUES (46, 4, '魔方', '塑料橡胶', '废旧塑料', '通用塑料', 0.01, 0.01, '小魔方', '2022-05-01 01:28:56', '2022-05-18', '江苏省/无锡市/锡山区', '默认', NULL, '发布中', '没啥');
INSERT INTO `sys_waste` VALUES (47, 4, '降智魔方', '塑料橡胶', '废旧塑料', '通用塑料', 0.01, 0.01, '使用之后智商会下降！', '2022-05-01 16:07:34', '2022-05-02', '江苏省/镇江市/丹徒区', '江苏科技大学长山校区', NULL, '发布中', NULL);
INSERT INTO `sys_waste` VALUES (48, 6, '千秋斩', '金属电子', '废旧金属', '废钢', 0.50, 0.30, '一刀斩千秋，可惜生锈了', '2022-05-01 16:45:14', '2022-05-24', '江苏省/镇江市/市辖区', ' ', NULL, '发布中', '面交优先');
INSERT INTO `sys_waste` VALUES (49, 6, '撒旦', '塑料橡胶', '废旧橡胶', '未知分类', 2.20, 1.00, '啥也没有', '2022-05-02 18:28:50', '2022-06-12', '全部', '地狱', NULL, '发布中', NULL);
INSERT INTO `sys_waste` VALUES (50, 1, '镜子', NULL, NULL, NULL, 1.00, 1.00, NULL, '2022-05-02 22:08:23', NULL, NULL, NULL, NULL, '已取消', NULL);
INSERT INTO `sys_waste` VALUES (51, 1, '镜子', '工程玻璃', '废旧玻璃', '镜子', 0.01, 0.01, '魔镜，可能是白雪公主的', '2022-05-02 22:09:26', '2022-05-03', '江苏省/淮安市/淮安区', '向下兼容', NULL, '发布中', '注意划伤');
INSERT INTO `sys_waste` VALUES (52, 6, '大炮', '金属电子', '废旧金属', '废铁', 50.00, 2.10, '大炮轰蚊子', '2022-05-02 22:26:48', '2022-05-03', '北京市/市辖区/东城区', '如图所示', NULL, '发布中', '蚊子没了');
INSERT INTO `sys_waste` VALUES (55, NULL, '特色五', NULL, NULL, NULL, 1.00, 1.00, NULL, '2022-05-02 22:56:58', NULL, NULL, NULL, NULL, '已取消', NULL);
INSERT INTO `sys_waste` VALUES (56, 4, '哈皮罗', '工程玻璃', '工程拆除', '建筑违章', 80.00, 1.50, '傻逼罗', '2022-05-02 23:09:30', '2022-05-05', '江苏省/镇江市/丹阳市', '自寻死路', NULL, '发布中', '废品哈皮罗一只');

SET FOREIGN_KEY_CHECKS = 1;
