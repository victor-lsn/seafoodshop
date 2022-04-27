/*
 Navicat Premium Data Transfer

 Source Server         : victor
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : seafood_sell_system

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 16/06/2021 21:02:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 唯一属性',
  `addr` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'addr 用户地址',
  `user_id` int(11) NOT NULL COMMENT 'user_id 用户ID',
  `real_name` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '北京市海淀区永定路15号院', 3, '里斯');
INSERT INTO `address` VALUES (2, '云南省昆明市', 3, '张三');
INSERT INTO `address` VALUES (5, '北京市海淀区玉泉路15号院709号楼4单元501', 8, '乔亚辉');
INSERT INTO `address` VALUES (7, '111111', 7, '1111');
INSERT INTO `address` VALUES (8, '山西省太原市尖草坪区太原工业学院', 8, '刘思楠');

-- ----------------------------
-- Table structure for advert
-- ----------------------------
DROP TABLE IF EXISTS `advert`;
CREATE TABLE `advert`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of advert
-- ----------------------------
INSERT INTO `advert` VALUES (1, 'advert0.jpg', 'https://aecpm.alicdn.com/simba/img/TB1W4nPJFXXXXbSXpXXSutbFXXX.jpg');
INSERT INTO `advert` VALUES (2, 'advert1.jpg', 'https://img.alicdn.com/tps/i4/https://img.alicdn.com/imgextra/i1/6000000006885/O1CN01D2Y9NQ20jNZKXMcpq_!!6000000006885-0-octopus.jpg');
INSERT INTO `advert` VALUES (3, 'advert2.jpg', 'https://aecpm.alicdn.com/simba/img/TB1_JXrLVXXXXbZXVXXSutbFXXX.jpg');
INSERT INTO `advert` VALUES (4, 'advert3.jpg', NULL);
INSERT INTO `advert` VALUES (5, '海鲜小图00.jpg', NULL);
INSERT INTO `advert` VALUES (6, '海鲜小图01.jpg', NULL);
INSERT INTO `advert` VALUES (7, '海鲜小图02.jpg', NULL);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 种类ID',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'name 种类名称',
  `category_desc` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述',
  `parent` int(11) NULL DEFAULT NULL COMMENT '父级种类',
  `level` int(11) NULL DEFAULT NULL COMMENT '种类等级',
  `pic` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '鱼类', '鱼类', NULL, 1, '鱼类.jpg');
INSERT INTO `category` VALUES (2, '虾类', '虾类', NULL, 1, '虾类.jpg');
INSERT INTO `category` VALUES (3, '蟹类', '蟹类', NULL, 1, '蟹类.jpg');
INSERT INTO `category` VALUES (4, '贝类', '贝类', NULL, 1, '贝类.jpg');
INSERT INTO `category` VALUES (5, '海参', '海参', NULL, 1, '海参.jpg');
INSERT INTO `category` VALUES (7, '三文鱼', '', 1, 2, NULL);
INSERT INTO `category` VALUES (8, '鳕鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (9, '带鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (10, '金枪鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (11, '黄鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (12, '巴沙鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (13, '鲳鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (14, '鲈鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (15, '鳗鱼', NULL, 1, 2, NULL);
INSERT INTO `category` VALUES (18, '红虾', NULL, 2, 2, NULL);
INSERT INTO `category` VALUES (19, '白虾', NULL, 2, 2, NULL);
INSERT INTO `category` VALUES (24, '海产干货', '海产干货', NULL, 1, '海产干货.jpg');
INSERT INTO `category` VALUES (26, '黑虎虾', '', 2, 2, NULL);
INSERT INTO `category` VALUES (27, '大龙虾', '', 2, 2, NULL);
INSERT INTO `category` VALUES (28, '小龙虾', '', 2, 2, NULL);
INSERT INTO `category` VALUES (29, '大闸蟹', '', 3, 2, NULL);
INSERT INTO `category` VALUES (30, '帝王蟹', '', 3, 2, NULL);
INSERT INTO `category` VALUES (31, '梭子蟹', '', 3, 2, NULL);
INSERT INTO `category` VALUES (32, '面包蟹', '', 3, 2, NULL);
INSERT INTO `category` VALUES (33, '生蚝', '', 4, 2, NULL);
INSERT INTO `category` VALUES (34, '鲍鱼', '', 4, 2, NULL);
INSERT INTO `category` VALUES (35, '扇贝', '', 4, 2, NULL);
INSERT INTO `category` VALUES (36, '海螺', '', 4, 2, NULL);
INSERT INTO `category` VALUES (37, '北极贝', '', 4, 2, NULL);
INSERT INTO `category` VALUES (38, '即食海参', '', 5, 2, NULL);
INSERT INTO `category` VALUES (39, '淡干海参', '', 5, 2, NULL);
INSERT INTO `category` VALUES (40, '冻干海参', '', 5, 2, NULL);
INSERT INTO `category` VALUES (41, '墨鱼干', '', 24, 2, NULL);
INSERT INTO `category` VALUES (42, '鱿鱼干', '', 24, 2, NULL);
INSERT INTO `category` VALUES (43, '海带', '', 24, 2, NULL);
INSERT INTO `category` VALUES (44, '虾皮', '', 24, 2, NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NULL DEFAULT NULL,
  `seafood_id` int(11) NOT NULL,
  `parent` int(11) NULL DEFAULT NULL,
  `level` int(11) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` datetime(0) NOT NULL,
  `from_user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (14, 8, NULL, 3962, NULL, 1, '这个三文鱼很好吃的', '2021-06-14 11:35:27', 'sentinel', NULL);
INSERT INTO `comment` VALUES (15, 8, NULL, 3962, 14, 2, '1', '2021-06-14 11:39:23', 'sentinel', 'sentinel');
INSERT INTO `comment` VALUES (16, 8, NULL, 3962, NULL, 1, '太新鲜了！！！', '2021-06-14 11:53:51', 'sentinel', NULL);
INSERT INTO `comment` VALUES (17, 8, NULL, 3984, NULL, 1, '111', '2021-06-14 14:04:59', 'sentinel', NULL);
INSERT INTO `comment` VALUES (18, 8, NULL, 3984, NULL, 1, '好吃哦', '2021-06-14 14:06:43', 'sentinel', NULL);
INSERT INTO `comment` VALUES (19, 8, NULL, 3977, NULL, 1, '12121', '2021-06-15 13:30:44', 'sentinel', NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (3, '今天有些好东西哦111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111', '2021-03-24 17:52:18');
INSERT INTO `news` VALUES (4, '11111', '2021-03-24 18:05:58');
INSERT INTO `news` VALUES (5, '222', '2021-03-24 18:07:54');
INSERT INTO `news` VALUES (6, '3333', '2021-03-24 18:08:02');
INSERT INTO `news` VALUES (7, '222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222', '2021-03-24 18:09:15');
INSERT INTO `news` VALUES (8, '1212121挖到所 ', '2021-03-24 18:34:30');
INSERT INTO `news` VALUES (9, '阿达2我问他问题e网通 ', '2021-03-24 18:34:35');
INSERT INTO `news` VALUES (10, '八个人问题噶热帖问题问题为', '2021-03-24 18:34:47');
INSERT INTO `news` VALUES (11, '我如问题问题如问题认为如问题re入233333333333333333333', '2021-03-24 18:34:54');
INSERT INTO `news` VALUES (12, '阿尔泰reward认为奥re而儿童额', '2021-03-24 18:35:01');
INSERT INTO `news` VALUES (13, '青蛙UI打过去五个队前往公对公全文去外地秦皇岛谷温泉厚度为强化晚点去武汉队完全好赌好玩我去换电话去武汉', '2021-03-24 18:43:09');
INSERT INTO `news` VALUES (14, '起舞我一对五强化督和趣味趣味互动互全网独权威和杜威去我会读全文灰度化', '2021-03-24 18:43:16');
INSERT INTO `news` VALUES (15, '去武汉赌行情无单号请问去带回去我还得去读我大概区委高度弯曲刚度前完工度武器大哥请问', '2021-03-24 18:43:24');
INSERT INTO `news` VALUES (19, '鱼类、虾、蟹等含有丰富的蛋白质，含量可高达15%～20%，鱼翅、海参、干贝等含蛋白质在70%以上。另外，鱼蛋白质的必需氨基酸组成类似肉类，属优质蛋白', '2021-06-03 12:26:56');
INSERT INTO `news` VALUES (20, '鱼类、虾、蟹等脂肪含量很低，多数为1%～3%，并且多由不饱和脂肪酸组成，容易消化，不易引起动脉硬化；', '2021-06-03 12:27:14');
INSERT INTO `news` VALUES (21, '鱼类脂肪含有极丰富的维生素A和D，特别是鱼肝中含量更为丰富，鱼肉中还含有一定量的尼克酸、维生素B1', '2021-06-03 12:27:28');
INSERT INTO `news` VALUES (22, '海带、紫菜等海中植物，还含有丰富的碘和铁。', '2021-06-03 12:27:42');
INSERT INTO `news` VALUES (23, '海鲜中的病菌主要是副溶血性弧菌等，耐热性比较强，80℃以上才能杀灭。除了水中带来的细菌之外，海鲜中还可能存在寄生虫卵以及加工带来的病菌 和病毒污染。一般来说，在沸水中煮4-5分钟才算彻底杀菌。因此，在吃“醉蟹”、“生海胆”、“酱油腌海鲜”之类不加热烹调的海鲜一定要慎重，吃生鱼片的 时候也要保证鱼的新鲜和卫生。', '2021-06-03 12:28:09');
INSERT INTO `news` VALUES (24, '贝类本身带菌量比较高，蛋白质分解又很快，一旦死去便大量繁殖病菌、产生毒素，同时其中所含的不饱和脂肪酸也容易氧化酸败。不新鲜的贝类还会产 生较多的胺类和自由基，对人体健康造成威胁。选购活贝之后也不能在家存放太久，要尽快烹调。过敏体质的人尤其应当注意，因为有时候过敏反应不是因为海鲜本 身，而是在海鲜蛋白质分解过程中的物质导致的。', '2021-06-03 12:28:27');
INSERT INTO `news` VALUES (25, '在吃海鲜时最好别饮用啤酒。虾、蟹等海产品在人体代谢后会形成尿酸，而尿酸过多会引起痛风、肾结石等病症。如果大量食用海鲜的同时，再饮用啤酒，就会加速体内尿酸的形成。所以，在大量食用海鲜的时候，千万别喝啤酒，否则会对身体产生不利影响。', '2021-06-03 12:28:38');
INSERT INTO `news` VALUES (26, '鱼、虾、蟹等海产品含有丰富的蛋白质和钙等营养素。而水果中含有较多的鞣酸，如果吃完海产品后，马上吃水果，不但影响人体对蛋白质的吸收，海鲜 中的钙还会与水果中的鞣酸相结合，形成难溶的钙，会对胃肠道产生刺激，甚至引起腹痛、恶心、呕吐等症状。最好间隔2小时以上再吃。', '2021-06-03 12:28:52');
INSERT INTO `news` VALUES (27, '吃完海鲜不宜喝茶的道理与不宜吃水果的原因类似。因为茶叶中也含有鞣酸，同样能与海鲜中的钙形成难溶的钙。在食用海鲜前或后吃海鲜，都会增加钙与鞣酸相结合的机会。因此，在吃海鲜时最好别喝茶。同理，也是最好间隔2小时以上。', '2021-06-03 12:29:03');
INSERT INTO `news` VALUES (28, '任何海鲜都只有在高度新鲜的状态下才能做成清蒸、白灼之类的菜肴。水产海鲜与肉类不同，它们体内带有很多耐低温的细菌，而且蛋白质分解特别快。 如果放在冰箱里多时，虾体的含菌量增大，蛋白质也已经部分变性，产生了胺类物质，无论怎么样都达不到活虾的口感、风味和安全性，当然也就不适合白灼的吃法 了。不过，冰鲜的虾可以高温烹炒或煎炸，同时也能呈现出美味噢。', '2021-06-03 12:29:19');

-- ----------------------------
-- Table structure for order_seafood
-- ----------------------------
DROP TABLE IF EXISTS `order_seafood`;
CREATE TABLE `order_seafood`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 唯一标识',
  `order_id` int(11) NOT NULL COMMENT 'order_id 订单编号',
  `seafood_id` int(11) NOT NULL COMMENT 'seafood_id 海鲜编号',
  `seafood_count` int(255) NOT NULL DEFAULT 1 COMMENT '海鲜数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `seafood_id`(`seafood_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `order_seafood_ibfk_2` FOREIGN KEY (`seafood_id`) REFERENCES `seafood` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_seafood_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_seafood
-- ----------------------------
INSERT INTO `order_seafood` VALUES (63, 56, 3962, 1);
INSERT INTO `order_seafood` VALUES (64, 57, 3962, 50);
INSERT INTO `order_seafood` VALUES (65, 58, 3963, 10);
INSERT INTO `order_seafood` VALUES (66, 59, 3970, 3);
INSERT INTO `order_seafood` VALUES (67, 60, 3991, 1);
INSERT INTO `order_seafood` VALUES (68, 61, 3983, 30);
INSERT INTO `order_seafood` VALUES (69, 62, 3977, 50);
INSERT INTO `order_seafood` VALUES (70, 63, 3978, 20);
INSERT INTO `order_seafood` VALUES (71, 71, 3975, 1);
INSERT INTO `order_seafood` VALUES (73, 66, 3980, 1);
INSERT INTO `order_seafood` VALUES (74, 67, 3983, 1);
INSERT INTO `order_seafood` VALUES (75, 68, 3971, 1);
INSERT INTO `order_seafood` VALUES (76, 69, 3969, 1);
INSERT INTO `order_seafood` VALUES (77, 70, 3968, 1);
INSERT INTO `order_seafood` VALUES (78, 72, 3968, 1);
INSERT INTO `order_seafood` VALUES (79, 73, 3965, 1);
INSERT INTO `order_seafood` VALUES (80, 74, 3984, 1);
INSERT INTO `order_seafood` VALUES (81, 75, 3977, 1);
INSERT INTO `order_seafood` VALUES (82, 76, 3962, 1);
INSERT INTO `order_seafood` VALUES (83, 77, 3962, 1);
INSERT INTO `order_seafood` VALUES (84, 78, 3977, 1);
INSERT INTO `order_seafood` VALUES (85, 79, 3962, 1);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 权限唯一标识',
  `path` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'path 权限路径',
  `level` int(11) NOT NULL DEFAULT 1 COMMENT 'level 当前目录等级',
  `parent` int(11) NULL DEFAULT NULL COMMENT 'parent 父级目录ID',
  `icon` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标',
  `name` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, NULL, 1, NULL, 'el-icon-s-custom', '用户管理');
INSERT INTO `permission` VALUES (2, NULL, 1, NULL, 'el-icon-s-shop', '产品管理');
INSERT INTO `permission` VALUES (3, NULL, 1, NULL, 'el-icon-s-order', '订单管理');
INSERT INTO `permission` VALUES (4, NULL, 1, NULL, 'el-icon-camera-solid', '媒体管理');
INSERT INTO `permission` VALUES (5, NULL, 1, NULL, 'el-icon-box', '系统管理');
INSERT INTO `permission` VALUES (6, '/users', 2, 1, 'el-icon-s-grid', '用户列表');
INSERT INTO `permission` VALUES (7, '/goods', 2, 2, 'el-icon-s-grid', '商品管理');
INSERT INTO `permission` VALUES (8, '/category', 2, 2, 'el-icon-s-grid', '商品分类');
INSERT INTO `permission` VALUES (9, '/orders', 2, 3, 'el-icon-s-grid', '订单列表');
INSERT INTO `permission` VALUES (10, '/news', 2, 4, 'el-icon-s-grid', '新闻管理');
INSERT INTO `permission` VALUES (11, '/advert', 2, 4, 'el-icon-s-grid', '广告管理');
INSERT INTO `permission` VALUES (12, '/roles', 2, 5, 'el-icon-s-grid', '角色管理');
INSERT INTO `permission` VALUES (13, '/permission', 2, 5, 'el-icon-s-grid', '权限管理');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 角色唯一标识',
  `name` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'name 角色名称',
  `role_desc` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (0, '普通用户', '没有任何权限');
INSERT INTO `role` VALUES (1, '管理员', '系统管理员，有所有权限');
INSERT INTO `role` VALUES (2, '人工客服', '负责解决用户问题');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 唯一标识',
  `role_id` int(11) NOT NULL COMMENT 'role_id 角色ID',
  `permission_id` int(11) NOT NULL COMMENT 'permssion_id 权限ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `permssion_id`(`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 161 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (129, 1, 1);
INSERT INTO `role_permission` VALUES (130, 1, 2);
INSERT INTO `role_permission` VALUES (131, 1, 3);
INSERT INTO `role_permission` VALUES (132, 1, 4);
INSERT INTO `role_permission` VALUES (133, 1, 5);
INSERT INTO `role_permission` VALUES (134, 1, 6);
INSERT INTO `role_permission` VALUES (135, 1, 7);
INSERT INTO `role_permission` VALUES (136, 1, 8);
INSERT INTO `role_permission` VALUES (137, 1, 9);
INSERT INTO `role_permission` VALUES (138, 1, 10);
INSERT INTO `role_permission` VALUES (139, 1, 11);
INSERT INTO `role_permission` VALUES (140, 1, 12);
INSERT INTO `role_permission` VALUES (141, 1, 13);
INSERT INTO `role_permission` VALUES (152, 2, 1);
INSERT INTO `role_permission` VALUES (153, 2, 2);
INSERT INTO `role_permission` VALUES (154, 2, 3);
INSERT INTO `role_permission` VALUES (155, 2, 4);
INSERT INTO `role_permission` VALUES (156, 2, 6);
INSERT INTO `role_permission` VALUES (157, 2, 7);
INSERT INTO `role_permission` VALUES (158, 2, 9);
INSERT INTO `role_permission` VALUES (159, 2, 10);
INSERT INTO `role_permission` VALUES (160, 2, 11);

-- ----------------------------
-- Table structure for seafood
-- ----------------------------
DROP TABLE IF EXISTS `seafood`;
CREATE TABLE `seafood`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 海鲜唯一标识',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'name 名称',
  `in_price` decimal(10, 2) NOT NULL COMMENT 'price 进货价格',
  `out_price` decimal(10, 2) NOT NULL COMMENT '售价',
  `discount` decimal(10, 2) NOT NULL COMMENT '折扣',
  `count` int(11) NOT NULL COMMENT '库存',
  `category_id` int(11) NOT NULL COMMENT 'category 具体类别',
  `sale_date` date NOT NULL COMMENT 'sale_date 上架日期',
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'info 详情',
  `sale_count` int(11) NOT NULL DEFAULT 0 COMMENT '销量',
  `weight` float NOT NULL COMMENT '重量',
  `seafood_source` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产地',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category`(`category_id`) USING BTREE,
  CONSTRAINT `seafood_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4082 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seafood
-- ----------------------------
INSERT INTO `seafood` VALUES (3962, '【已通过核酸检测】洲渚家乡味 挪威冰鲜三文鱼刺身（大西洋鲑）日式生鲜生鱼片 挪威冰鲜三文鱼中段', 12.00, 24.00, 0.00, 7, 7, '2021-06-10', '【已通过核酸检测】洲渚家乡味 挪威冰鲜三文鱼刺身（大西洋鲑）日式生鲜生鱼片 挪威冰鲜三文鱼中段', '【已通过核酸检测】洲渚家乡味 挪威冰鲜三文鱼刺身（大西洋鲑）日式生鲜生鱼片 挪威冰鲜三文鱼中段【500克】【限时秒杀-到手价69元】【全店满3件享9.5折】【顺丰航空配送】【送酱油芥末】挪威冰鲜三文鱼当天现杀现发-500g含鱼皮，默认去皮400g', 54, 0.5, '中国东海');
INSERT INTO `seafood` VALUES (3963, 'Acornfresh 冰岛大西洋真鳕鱼深海捕捞婴幼儿宝宝辅食营养辅食健康轻食\\x0a 去皮去刺鳕鱼中段400g（2块装）', 20.00, 139.00, 0.00, 150, 8, '2021-06-10', 'Acornfresh 冰岛大西洋真鳕鱼深海捕捞婴幼儿宝宝辅食营养辅食健康轻食\\x0a 去皮去刺鳕鱼中段400g（2块装）', 'Acornfresh 冰岛大西洋真鳕鱼深海捕捞婴幼儿宝宝辅食营养辅食健康轻食\\x0a 去皮去刺鳕鱼中段400g（2块装）\n【经核酸检测】为了宝宝我们让标准更严格，守护宝宝健康成长。', 10, 0.5, '中国东海');
INSERT INTO `seafood` VALUES (3964, '渔港 国产冷冻渤海四去精品带鱼段 刀鱼 1300g 24-28段 海鲜水产', 40.00, 159.00, 0.00, 70, 9, '2021-06-10', '渔港 国产冷冻渤海四去精品带鱼段 刀鱼 1300g 24-28段 海鲜水产', ' 渔港 国产冷冻渤海四去精品带鱼段 刀鱼 1300g 24-28段 海鲜水产【美味好鱼】好好吃鱼，快乐成长，四海鱼类低至五折 【品质好鱼】优质大牌品质保障，每周三次鱼，健康好成长 【爆款优惠】银鳕特价促销，真鳕低至19.9走起', 0, 0.4, '中国渤海');
INSERT INTO `seafood` VALUES (3965, '核酸已检测SAPMER 生冻黄鳍金枪鱼排160g（国内加工） 海鲜水产 健康轻食健身食材', 50.00, 77.90, 0.00, 70, 10, '2021-06-10', '核酸已检测SAPMER 生冻黄鳍金枪鱼排160g（国内加工） 海鲜水产 健康轻食健身食材', '核酸已检测SAPMER 生冻黄鳍金枪鱼排160g（国内加工） 海鲜水产 健康轻食健身食材\n【美味好鱼】好好吃鱼，快乐成长，四海鱼类低至五折 【品质好鱼】优质大牌品质保障，每周三次鱼，健康好成长 【爆款优惠】银鳕特价促销，真鳕低至19.9走起查看>', 0, 0.16, '大西洋');
INSERT INTO `seafood` VALUES (3966, '三都港 速冻宁德大黄花鱼700g 2条 生鲜 海鲜水产', 40.00, 65.00, 0.00, 70, 11, '2021-06-10', '三都港 速冻宁德大黄花鱼700g 2条 生鲜 海鲜水产', '三都港 速冻宁德大黄花鱼700g 2条 生鲜 海鲜水产', 0, 1.4, '中国大陆');
INSERT INTO `seafood` VALUES (3967, '【2份减20】巴沙鱼片5斤装 冷冻鱼片 淡水龙利鱼柳 新鲜无刺无骨鱼肉做酸菜鱼 2500g', 50.00, 69.00, 0.00, 80, 12, '2021-06-10', '【2份减20】巴沙鱼片5斤装 冷冻鱼片 淡水龙利鱼柳 新鲜无刺无骨鱼肉做酸菜鱼 2500g', '【2份减20】巴沙鱼片5斤装 冷冻鱼片 淡水龙利鱼柳 新鲜无刺无骨鱼肉做酸菜鱼 2500g\n【通过核酸检测】【全国7仓】大部分地区当日/次日达，如坏包赔。【真材实料】含冰少（仅15-20%冰衣，净重4斤以上），购买放心实惠。爆款直降，更多商品点我查看！查看>', 0, 2.6, '中国大陆');
INSERT INTO `seafood` VALUES (3968, '翔泰 国产海南金鲳鱼700g（2条）火锅食材 无公害认证 全程可追溯 鱼类 生鲜 BAP认证 海鲜水产', 30.00, 44.90, 0.00, 80, 13, '2021-06-10', '翔泰 国产海南金鲳鱼700g（2条）火锅食材 无公害认证 全程可追溯 鱼类 生鲜 BAP认证 海鲜水产', '翔泰 国产海南金鲳鱼700g（2条）火锅食材 无公害认证 全程可追溯 鱼类 生鲜 BAP认证 海鲜水产\n【美味好鱼】好好吃鱼，快乐成长，四海鱼类低至五折 【品质好鱼】优质大牌品质保障，每周三次鱼，健康好成长 【爆款优惠】银鳕特价促销，真鳕低至19.9走起查看>', 0, 1.4, '中国大陆');
INSERT INTO `seafood` VALUES (3969, '三都港 深海三去海鲈鱼（含清蒸料包）500g 生鲜 鱼类 海鲜水产 健康轻食', 20.00, 58.80, 0.00, 80, 14, '2021-06-10', '三都港 深海三去海鲈鱼（含清蒸料包）500g 生鲜 鱼类 海鲜水产 健康轻食', NULL, 0, 0.5, '中国大陆');
INSERT INTO `seafood` VALUES (3970, '鳗鱼皇后 鳗鱼蒲烧 600g段装（鳗鱼100g+酱汁20g）×5段 海鲜制品 鱼类 加热即食 生鲜国产', 100.00, 160.00, 0.00, 100, 15, '2021-06-10', '鳗鱼皇后 鳗鱼蒲烧 600g段装（鳗鱼100g+酱汁20g）×5段 海鲜制品 鱼类 加热即食 生鲜国产', '鳗鱼皇后 鳗鱼蒲烧 600g段装（鳗鱼100g+酱汁20g）×5段 海鲜制品 鱼类 加热即食 生鲜国产\n全程24道工艺，活鳗烤制，三同品质，微波炉加热3分钟即可食用', 3, 0.6, '江西省赣州市');
INSERT INTO `seafood` VALUES (3971, '味库精选 冷冻阿根廷红虾L1 净重2kg 30-40只 烧烤食材 海鲜水产 手掌大小 宴请款', 90.00, 140.00, 0.00, 90, 18, '2021-06-10', '味库精选 冷冻阿根廷红虾L1 净重2kg 30-40只 烧烤食材 海鲜水产 手掌大小 宴请款', '味库精选 冷冻阿根廷红虾L1 净重2kg 30-40只 烧烤食材 海鲜水产 手掌大小 宴请款\n【已通过核酸检测】天然网红虾，近南极深海冷水域的纯野生海捕大虾，船冻技术锁住营养，个大饱满只手难握，富含虾青素，适合煎炸', 0, 2, '阿根廷');
INSERT INTO `seafood` VALUES (3972, '国联 国产大虾 净重1.8kg 90-108只 盒装活冻白虾 火锅海鲜烧烤食材 生鲜', 80.00, 120.00, 0.00, 60, 19, '2021-06-10', '国联 国产大虾 净重1.8kg 90-108只 盒装活冻白虾 火锅海鲜烧烤食材 生鲜', '国联 国产大虾 净重1.8kg 90-108只 盒装活冻白虾 火锅海鲜烧烤食材 生鲜\n国联水产，部分产品领券299减150，6月10日至11日！赶快进入抢购吧！', 0, 1.8, '中国大陆');
INSERT INTO `seafood` VALUES (3973, 'Member\'s Mark 泰国进口 生冷冻黑虎虾 2kg（60-80只）虎纹虾 海鲜 核酸已检测', 240.00, 300.00, 0.00, 120, 26, '2021-06-10', 'Member\'s Mark 泰国进口 生冷冻黑虎虾 2kg（60-80只）虎纹虾 海鲜 核酸已检测', 'Member\'s Mark 泰国进口 生冷冻黑虎虾 2kg（60-80只）虎纹虾 海鲜 核酸已检测\n超值爆品随心买，进口牛奶8.3元/升，麻辣小龙虾64元/盒，蛋黄酥3.9元/个，更多山姆好物', 0, 2, '泰国');
INSERT INTO `seafood` VALUES (3974, '【活鲜】味库 大龙虾 波士顿龙虾波龙 鲜活 加拿大龙虾400-500g/只*2 直采 鲜活到家健康轻食 送蘸料', 200.00, 240.00, 0.00, 100, 27, '2021-06-10', '【活鲜】味库 大龙虾 波士顿龙虾波龙 鲜活 加拿大龙虾400-500g/只*2 直采 鲜活到家健康轻食 送蘸料', '【活鲜】味库 大龙虾 波士顿龙虾波龙 鲜活 加拿大龙虾400-500g/只*2 直采 鲜活到家健康轻食 送蘸料\n【家庭款】味库买手优选源产地新斯科舍省直采大龙虾！溯源检疫！安心食用！只只鲜活发货，保证每一只选用生猛大龙虾发货', 0, 1, '加拿大');
INSERT INTO `seafood` VALUES (3975, ' Member\'s Mark 麻辣小龙虾 1.2kg(600g*2盒)', 100.00, 160.00, 0.00, 75, 28, '2021-06-10', 'Member\'s Mark 麻辣小龙虾 1.2kg(600g*2盒)', 'Member\'s Mark 麻辣小龙虾 1.2kg(600g*2盒)\n超值爆品随心买，进口牛奶8.3元/升，麻辣小龙虾64元/盒，蛋黄酥3.9元/个，更多山姆好物，', 0, 1, '中国大陆');
INSERT INTO `seafood` VALUES (3976, '阳澄嘟嘟大闸蟹 鲜活特大螃蟹 可全母实物活体 海鲜水产生鲜礼盒 公蟹4.0-4.3两母蟹3.0-3.3两10只5对', 200.00, 298.00, 0.00, 60, 29, '2021-06-10', '阳澄嘟嘟大闸蟹 鲜活特大螃蟹 可全母实物活体 海鲜水产生鲜礼盒 公蟹4.0-4.3两母蟹3.0-3.3两10只5对', '阳澄嘟嘟大闸蟹 鲜活特大螃蟹 可全母实物活体 海鲜水产生鲜礼盒 公蟹4.0-4.3两母蟹3.0-3.3两10只5对\n原产地发货，配送吃蟹工具', 0, 3, '阳澄湖');
INSERT INTO `seafood` VALUES (3977, '【鲜活 送鲍鱼1斤】味库 俄罗斯鲜活帝王蟹 海鲜水产 核酸检测通过 约5斤-4.6斤/一只', 1200.00, 1600.00, 0.00, 28, 30, '2021-06-10', '【鲜活 送鲍鱼1斤】味库 俄罗斯鲜活帝王蟹 海鲜水产 核酸检测通过 约5斤-4.6斤/一只', '【鲜活 送鲍鱼1斤】味库 俄罗斯鲜活帝王蟹 海鲜水产 核酸检测通过 约5斤-4.6斤/一只\n通过核酸检测！送鲜活鲍鱼1斤鲜【全国23仓就近发货，联系客服可免费发闪送2小时达】保证鲜活发货，鲜活空运，来一只犒劳一下自己的人生更多海鲜9.9元起', 52, 4, '俄罗斯');
INSERT INTO `seafood` VALUES (3978, '渔哥戏鱼 青岛梭子蟹鲜活螃蟹特大海蟹梭子蟹青蟹花蟹白蟹活体海鲜水产 全母蟹2斤装（4-6只）', 290.00, 350.00, 0.00, 90, 31, '2021-06-10', '渔哥戏鱼 青岛梭子蟹鲜活螃蟹特大海蟹梭子蟹青蟹花蟹白蟹活体海鲜水产 全母蟹2斤装（4-6只）', '渔哥戏鱼 青岛梭子蟹鲜活螃蟹特大海蟹梭子蟹青蟹花蟹白蟹活体海鲜水产 全母蟹2斤装（4-6只）\n1.领券买2立减20元，鲜活发货，新鲜直达，超划算！ 2.只发母蟹，只只满黄，黄满肉肥，鲜香味美！ 3.烹饪简单，方式多样，招待宴请的硬菜！', 0, 1, '中国大陆');
INSERT INTO `seafood` VALUES (3979, '味库精选 面包蟹 活鲜 大膏蟹600-800g/只*1 螃蟹 鲜活发货 包鲜到家不包活 坏单包赔', 150.00, 200.00, 0.00, 80, 32, '2021-06-10', '味库精选 面包蟹 活鲜 大膏蟹600-800g/只*1 螃蟹 鲜活发货 包鲜到家不包活 坏单包赔', '味库精选 面包蟹 活鲜 大膏蟹600-800g/只*1 螃蟹 鲜活发货 包鲜到家不包活 坏单包赔\n【膏蟹之王】太平洋深海海域生长，个大体肥膏满鲜香，蟹肉洁白细腻，肉质紧实，蟹膏丰盈，海味十足', 0, 1.3, '爱尔兰');
INSERT INTO `seafood` VALUES (3980, '【三倍体】九能(JIUNENG) 乳山生蚝鲜活特大牡蛎生鲜贝类新鲜海蛎子清蒸小肥蚝带壳生蚝肉 乳山生蚝XXL净重4.5斤约23只', 40.00, 90.00, 0.00, 76, 33, '2021-06-10', '【三倍体】九能(JIUNENG) 乳山生蚝鲜活特大牡蛎生鲜贝类新鲜海蛎子清蒸小肥蚝带壳生蚝肉 乳山生蚝XXL净重4.5斤约23只', '【三倍体】九能(JIUNENG) 乳山生蚝鲜活特大牡蛎生鲜贝类新鲜海蛎子清蒸小肥蚝带壳生蚝肉 乳山生蚝XXL净重4.5斤约23只\n【XXL生蚝4.5斤装买2箱发3箱】 【领券下单立减40,到手价¥59】 下单当天现捞，产地直发送蚝刀，京东顺丰发货！猛戳查看购买', 0, 3, '中国大陆');
INSERT INTO `seafood` VALUES (3981, '【抢！买二赠一 拍两份发3斤】海唤 新鲜活冻大鲍鱼 鲍鱼捞饭食材 500g 袋装 生鲜 火锅烧烤食材 9-11头', 30.00, 70.00, 0.00, 90, 34, '2021-06-10', '【抢！买二赠一 拍两份发3斤】海唤 新鲜活冻大鲍鱼 鲍鱼捞饭食材 500g 袋装 生鲜 火锅烧烤食材 9-11头', '抢！买二赠一 拍两份发3斤】海唤 新鲜活冻大鲍鱼 鲍鱼捞饭食材 500g 袋装 生鲜 火锅烧烤食材 9-11头\n1.京东超市，七仓发货，买二赠1，拍两份发3斤！ 2.肉质饱满，肥厚多汁，口感鲜嫩弹牙！ 3.顾客好评如潮，品质保证！', 0, 0.5, '中国大陆');
INSERT INTO `seafood` VALUES (3982, '渔哥戏鱼 大扇贝超大冷冻半壳扇贝1斤新鲜海鲜水产贝类蒜蓉粉丝扇贝 烧烤食材 扇贝', 20.00, 40.00, 0.00, 300, 35, '2021-06-10', '渔哥戏鱼 大扇贝超大冷冻半壳扇贝1斤新鲜海鲜水产贝类蒜蓉粉丝扇贝 烧烤食材 扇贝', '渔哥戏鱼 大扇贝超大冷冻半壳扇贝1斤新鲜海鲜水产贝类蒜蓉粉丝扇贝 烧烤食材 扇贝\n1.半壳大个扇贝肉，两份顺丰免邮！ 2.公母混发，现挖现发，吃的就是个新鲜！ 3.扇贝肉质肥嫩鲜美，丰富的营养！', 0, 0.5, '中国大陆');
INSERT INTO `seafood` VALUES (3983, '味库精选 海螺 鲜活 XXXL大号 8-15颗/1.5kg 约三斤装 盒装 海鲜水产', 80.00, 136.00, 0.00, 199, 36, '2021-06-10', '味库精选 海螺 鲜活 XXXL大号 8-15颗/1.5kg 约三斤装 盒装 海鲜水产', '味库精选 海螺 鲜活 XXXL大号 8-15颗/1.5kg 约三斤装 盒装 海鲜水产鲜活大海螺，水开后蒸4-5分钟即可，忌过久容易煮破苦胆肉质发紫无法食用', 31, 2, '中国大陆');
INSERT INTO `seafood` VALUES (3984, '洲渚家乡味 加拿大冷冻北极贝刺身S号 150克约10只装', 20.00, 59.00, 0.00, 199, 37, '2021-06-10', '洲渚家乡味 加拿大冷冻北极贝刺身S号 150克约10只装', '洲渚家乡味 加拿大冷冻北极贝刺身S号 150克约10只装\n【美味剌身-尝鲜价39元】【领券满50-20，3件再打9.5折】加拿大北极贝刺身、去脏处理、缓化即食、味道鲜美，肉质爽脆，贝感新鲜', 1, 0.15, '加拿大');
INSERT INTO `seafood` VALUES (3985, '好当家冷冻即食海参 有机刺参 400g6-10头 威海海参 深海底播 海鲜水产 生鲜礼盒', 180.00, 369.00, 0.00, 140, 38, '2021-06-10', '好当家冷冻即食海参 有机刺参 400g6-10头 威海海参 深海底播 海鲜水产 生鲜礼盒', '好当家冷冻即食海参 有机刺参 400g6-10头 威海海参 深海底播 海鲜水产 生鲜礼盒\n领取津贴立减30元，无需泡发，开袋即食，连续12年有机认证，顺丰配送500g10-15头即食海参', 0, 0.7, '山东');
INSERT INTO `seafood` VALUES (3986, '参王朝 大连底播淡干海参干货辽刺参海鲜水产礼盒 7A实惠装 8年250g 35-45头', 500.00, 900.00, 0.00, 130, 39, '2021-06-10', '参王朝 大连底播淡干海参干货辽刺参海鲜水产礼盒 7A实惠装 8年250g 35-45头', '参王朝 大连底播淡干海参干货辽刺参海鲜水产礼盒 7A实惠装 8年250g 35-45头\n618全店秒杀，狂欢到底，保价全年【8年半斤实惠装，秒杀到手价997元】【限量赠送138元大促礼包】【京东溯源，专享7A品质】', 0, 0.5, '辽宁');
INSERT INTO `seafood` VALUES (3987, '赵家 淡干海参大连底播辽刺参海鲜干货礼盒生鲜水产 健康轻食 250g家庭装9年【20-30头】', 600.00, 1200.00, 0.00, 30, 40, '2021-06-10', '赵家 淡干海参大连底播辽刺参海鲜干货礼盒生鲜水产 健康轻食 250g家庭装9年【20-30头】', '赵家 淡干海参大连底播辽刺参海鲜干货礼盒生鲜水产 健康轻食 250g家庭装9年【20-30头】\n三十年的传统品牌，值得每一位消费者信赖！赵家海参', 0, 2.1, '辽宁');
INSERT INTO `seafood` VALUES (3988, '淡晒墨鱼干500g海鲜海产干货 乌贼干北海墨鱼约20-30个', 30.00, 60.00, 0.00, 120, 41, '2021-06-10', '淡晒墨鱼干500g海鲜海产干货 乌贼干北海墨鱼约20-30个', '淡晒墨鱼干500g海鲜海产干货 乌贼干北海墨鱼约20-30个\n深海捕捞，渔民自晒小墨鱼，品质佳，喜欢的亲们请放心购，墨鱼干有大有小，纯属正常，以收到实物为准哦！点击>>2-3只高品质大号墨鱼干500g正在疯抢中', 0, 0.5, '中国大陆');
INSERT INTO `seafood` VALUES (3989, '鱼臻多 北海烧烤鱿鱼干芥末鱿鱼丝共30-35条特产海鲜干货KTV酒吧手撕海产品 【酒吧同款】A5精品鱿鱼35条【配芥末酱油】', 20.00, 58.00, 0.00, 110, 42, '2021-06-10', '鱼臻多 北海烧烤鱿鱼干芥末鱿鱼丝共30-35条特产海鲜干货KTV酒吧手撕海产品 【酒吧同款】A5精品鱿鱼35条【配芥末酱油】', '鱼臻多 北海烧烤鱿鱼干芥末鱿鱼丝共30-35条特产海鲜干货KTV酒吧手撕海产品 【酒吧同款】A5精品鱿鱼35条【配芥末酱油】\n足干淡晒。配芥末酱油。越嚼越香', 0, 0.27, '中国大陆');
INSERT INTO `seafood` VALUES (3990, '溢源 海带干货日晒昆布干货500g霞浦特产海带凉拌煲汤', 15.00, 28.00, 0.00, 100, 43, '2021-06-10', '溢源 海带干货日晒昆布干货500g霞浦特产海带凉拌煲汤', '溢源 海带干货日晒昆布干货500g霞浦特产海带凉拌煲汤\n高品质无碎片，干净无泥无沙', 0, 0.5, '中国大陆');
INSERT INTO `seafood` VALUES (3991, '方家铺子 虾皮 小虾米 少盐海米干70g 不咸 始于1906', 16.00, 30.00, 0.00, 120, 44, '2021-06-10', '方家铺子 虾皮 小虾米 少盐海米干70g 不咸 始于1906', '方家铺子 虾皮 小虾米 少盐海米干70g 不咸 始于1906\n【国家龙头企业】方家铺子，国民滋补，始于1906 【香酥少渣】虾皮炖蛋，虾皮冬瓜汤 【更多优惠】食补好物低至第二件0元速戳', 1, 0.12, '中国大陆');

-- ----------------------------
-- Table structure for seafood_pic
-- ----------------------------
DROP TABLE IF EXISTS `seafood_pic`;
CREATE TABLE `seafood_pic`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seafood_id` int(11) NULL DEFAULT NULL,
  `name` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pic_path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `seafood_id`(`seafood_id`) USING BTREE,
  CONSTRAINT `seafood_pic_ibfk_1` FOREIGN KEY (`seafood_id`) REFERENCES `seafood` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8069 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seafood_pic
-- ----------------------------
INSERT INTO `seafood_pic` VALUES (7829, 3962, '1.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7830, 3962, '2.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7831, 3963, '8.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7832, 3963, '9.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7833, 3964, '12.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7834, 3964, '11.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7835, 3965, '16.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7836, 3965, '17.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7837, 3966, '21.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7838, 3966, '22.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7839, 3967, '25.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7840, 3967, '26.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7841, 3968, '30.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7842, 3968, '31.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7843, 3969, '34.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7844, 3969, '35.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7845, 3970, '39.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7846, 3970, '40.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7847, 3971, '43.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7848, 3971, '44.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7849, 3972, '48.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7850, 3972, '49.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7851, 3973, '52.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7852, 3973, '53.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7853, 3974, '56.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7854, 3974, '60.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7855, 3975, '61.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7856, 3975, '65.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7857, 3976, '66.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7858, 3976, '67.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7859, 3977, '70.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7860, 3977, '71.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7861, 3978, '74.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7862, 3978, '75.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7863, 3979, '78.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7864, 3979, '79.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7865, 3980, '82.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7866, 3980, '83.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7867, 3981, '86.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7868, 3981, '87.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7869, 3982, '90.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7870, 3982, '92.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7871, 3983, '94.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7872, 3983, '95.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7873, 3984, '98.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7874, 3984, '100.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7875, 3985, '101.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7876, 3985, '102.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7877, 3986, '104.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7878, 3986, '105.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7879, 3987, '106.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7880, 3987, '107.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7881, 3988, '109.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7882, 3988, '112.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7883, 3989, '113.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7884, 3989, '114.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7885, 3990, '116.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7886, 3990, '117.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7887, 3991, '120.jpg', NULL);
INSERT INTO `seafood_pic` VALUES (7888, 3991, '123.jpg', NULL);

-- ----------------------------
-- Table structure for shop_car
-- ----------------------------
DROP TABLE IF EXISTS `shop_car`;
CREATE TABLE `shop_car`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `seafood_id` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `seafood_id`(`seafood_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shop_car_ibfk_2` FOREIGN KEY (`seafood_id`) REFERENCES `seafood` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shop_car_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_car
-- ----------------------------
INSERT INTO `shop_car` VALUES (14, 8, 3981, 1);

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 流水号',
  `user_id` int(11) NOT NULL COMMENT 'user_id 用户ID',
  `user_addr` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'user_addr 收货地址',
  `create_date` datetime(0) NOT NULL COMMENT 'create_date 生成订单时间',
  `cost` decimal(10, 2) NOT NULL COMMENT 'cost 商品价值',
  `pay` decimal(10, 2) NOT NULL COMMENT 'pay 实际支付金额',
  `realName` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人姓名',
  `serial_number` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `status` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单状态（0未发货，1已发货，2用户确认收货）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `shop_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_order
-- ----------------------------
INSERT INTO `shop_order` VALUES (56, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-06-13 22:19:05', 24.00, 24.00, '乔亚辉', '12c2e192-682f-445d-8f3c-1e51c3e9bef3', '0');
INSERT INTO `shop_order` VALUES (57, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-06-13 22:22:12', 6200.00, 4960.00, '乔亚辉', '7e07a1b7-97db-4ba9-9300-e46723f5967d', '0');
INSERT INTO `shop_order` VALUES (58, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-05-14 22:30:10', 10000.00, 10000.00, '乔亚辉', '12345678-1234-2222-2222-222111223234', '0');
INSERT INTO `shop_order` VALUES (59, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-04-16 22:33:14', 20000.00, 20000.00, '乔亚辉', '33333333-2222-3333-4444-121212121331', '0');
INSERT INTO `shop_order` VALUES (60, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-03-04 22:35:53', 4100.00, 3100.00, '乔亚辉', '11111111-1111-1111-1111-111111111111', '0');
INSERT INTO `shop_order` VALUES (61, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-02-11 22:43:22', 8300.00, 7300.00, '乔亚辉', '22222222-2222-2222-2222-222222222222', '0');
INSERT INTO `shop_order` VALUES (62, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-06-13 22:47:20', 80000.00, 64000.00, '乔亚辉', '2b99f0b7-130d-4d6d-a4e9-74ae660a8ed6', '0');
INSERT INTO `shop_order` VALUES (63, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-01-28 23:00:30', 13000.00, 11000.00, '乔亚辉', '33333333-4444-4444-4444-444444444444', '0');
INSERT INTO `shop_order` VALUES (66, 8, '山西省太原市尖草坪区太原工业学院', '2020-10-09 11:29:43', 400.00, 320.00, '刘思楠', '22333333-2444-4455-4455-898989898989', '0');
INSERT INTO `shop_order` VALUES (67, 8, '山西省太原市尖草坪区太原工业学院', '2021-06-14 12:01:59', 136.00, 136.00, '刘思楠', 'e655fcb6-125d-4f43-9f0b-a09b4ce7c706', '0');
INSERT INTO `shop_order` VALUES (68, 8, '山西省太原市尖草坪区太原工业学院', '2020-05-06 13:18:20', 1500.00, 1200.00, '刘思楠', '23233111-2323-1212-4545-453636314688', '0');
INSERT INTO `shop_order` VALUES (69, 8, '山西省太原市尖草坪区太原工业学院', '2020-06-10 13:23:56', 200.00, 160.00, '刘思楠', '23232323-4545-6767-7878-895673218495', '0');
INSERT INTO `shop_order` VALUES (70, 3, '云南省昆明市', '2020-10-15 13:25:47', 150.00, 90.00, '张三', '78787888-4545-3456-6767-789654342424', '0');
INSERT INTO `shop_order` VALUES (71, 3, '云南省昆明市', '2020-09-17 13:34:01', 300.00, 240.00, '张三', '89898989-3434-5656-6789-235688789996', '0');
INSERT INTO `shop_order` VALUES (72, 3, '云南省昆明市', '2020-11-01 13:39:38', 200.00, 160.00, '张三', '687e3001-2183-3435-5656-346665768687', '0');
INSERT INTO `shop_order` VALUES (73, 3, '云南省昆明市', '2021-03-11 13:41:24', 120.00, 96.00, '张三', '5rhdiqwii-qsja-1234-1345-132435354545', '0');
INSERT INTO `shop_order` VALUES (74, 8, '山西省太原市尖草坪区太原工业学院', '2021-06-14 14:05:50', 59.00, 59.00, '刘思楠', '9163c147-2675-4b56-8e36-0b2e93c06c0d', '0');
INSERT INTO `shop_order` VALUES (75, 8, '山西省太原市尖草坪区太原工业学院', '2021-06-15 13:28:20', 1600.00, 1600.00, '刘思楠', 'e2bbae30-ac65-47f2-813c-a7d1e0668743', '0');
INSERT INTO `shop_order` VALUES (76, 8, '山西省太原市尖草坪区太原工业学院', '2021-06-15 13:29:17', 24.00, 24.00, '刘思楠', '247ac474-5cfc-43a7-9e1a-5dd7b04bb2c9', '0');
INSERT INTO `shop_order` VALUES (77, 8, '山西省太原市尖草坪区太原工业学院', '2021-06-15 18:31:47', 24.00, 24.00, '刘思楠', 'ee7b143e-a22a-4527-b0e2-34ca4d561884', '0');
INSERT INTO `shop_order` VALUES (78, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-06-15 18:32:34', 1600.00, 1600.00, '乔亚辉', 'e99bb7a7-3bad-4e25-883e-5b41b30f2f53', '0');
INSERT INTO `shop_order` VALUES (79, 8, '北京市海淀区玉泉路15号院709号楼4单元501', '2021-06-15 18:33:37', 24.00, 24.00, '乔亚辉', '3b530d42-b0ab-4086-895a-a0848cb796c6', '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 唯一标识',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'name 用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'password 用户密码',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'phone 用户手机号',
  `role` int(11) NULL DEFAULT 0 COMMENT 'role 角色，默认为普通用户',
  `flag` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT 'flag 是否启用标志，默认启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role`(`role`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, '1111', '12333', '1111', 1, '0');
INSERT INTO `user` VALUES (4, '1111', '12333', '1111', 1, '1');
INSERT INTO `user` VALUES (5, '1111', 'b59c67bf196a4758191e42f76670ceba', '12333', 0, '1');
INSERT INTO `user` VALUES (6, '1111', 'b59c67bf196a4758191e42f76670ceba', '123323', 0, '1');
INSERT INTO `user` VALUES (7, '客服1', '25d55ad283aa400af464c76d713c07ad', '15383414174', 2, '1');
INSERT INTO `user` VALUES (8, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414185', 1, '1');
INSERT INTO `user` VALUES (9, '客服2', 'ecadec2924e86bf88d622ceb0855382d', '15383414176', 2, '1');
INSERT INTO `user` VALUES (10, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414177', 0, '1');
INSERT INTO `user` VALUES (11, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414178', 0, '1');
INSERT INTO `user` VALUES (12, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414179', 0, '1');
INSERT INTO `user` VALUES (13, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414171', 0, '1');
INSERT INTO `user` VALUES (14, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414172', 0, '1');
INSERT INTO `user` VALUES (15, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414173', 0, '1');
INSERT INTO `user` VALUES (16, 'sentinel', 'ecadec2924e86bf88d622ceb0855382d', '15383414162', 2, '1');

SET FOREIGN_KEY_CHECKS = 1;
