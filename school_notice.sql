/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : school_notice

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 28/07/2026 17:01:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academic_programs
-- ----------------------------
DROP TABLE IF EXISTS `academic_programs`;
CREATE TABLE `academic_programs`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of academic_programs
-- ----------------------------
INSERT INTO `academic_programs` VALUES (1, 'CS', '计算机科学', '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `academic_programs` VALUES (2, 'EM', '经济管理', '融合经济学与管理学前沿理论，注重实践与国际化视野', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `academic_programs` VALUES (3, 'LC', '文学与传播', '传承人文精神，在数字时代探索文学创作与传媒创新', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `academic_programs` VALUES (4, 'LS', '生命科学', '从基因到生态，探索生命奥秘，推动生物医药前沿突破', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `academic_programs` VALUES (5, 'ET', '工程技术', '涵盖土木、机械、电子等多个方向，产学研深度融合', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `academic_programs` VALUES (6, 'AD', '艺术设计', '融合传统美学与现代设计理念，激发创造力与审美表达', '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for campus_life_features
-- ----------------------------
DROP TABLE IF EXISTS `campus_life_features`;
CREATE TABLE `campus_life_features`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_life_features
-- ----------------------------
INSERT INTO `campus_life_features` VALUES (1, '学生社团', '200+社团涵盖学术、文化、体育、公益等领域', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `campus_life_features` VALUES (2, '体育竞技', '省级赛事多次获奖，体育精神融入校园文化', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `campus_life_features` VALUES (3, '志愿服务', '参与公益项目，践行社会责任，传递温暖力量', '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for campus_stats
-- ----------------------------
DROP TABLE IF EXISTS `campus_stats`;
CREATE TABLE `campus_stats`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `stat_key`(`stat_key`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_stats
-- ----------------------------
INSERT INTO `campus_stats` VALUES (1, 'history_years', '70', '年办学历史', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `campus_stats` VALUES (2, 'student_count', '10000000', '在校学生', '2026-07-17 17:15:07', '2026-07-17 17:19:10');
INSERT INTO `campus_stats` VALUES (3, 'faculty_count', '2800', '教职员工', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `campus_stats` VALUES (4, 'degree_programs', '156', '硕博学位点', '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for footer_links
-- ----------------------------
DROP TABLE IF EXISTS `footer_links`;
CREATE TABLE `footer_links`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `section` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int(11) NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of footer_links
-- ----------------------------
INSERT INTO `footer_links` VALUES (1, '快速链接', '院系设置', '/departments', 1, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (2, '快速链接', '科学研究', '/research', 2, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (3, '快速链接', '校园生活', '/campus-life', 3, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (4, '快速链接', '新闻动态', '/news', 4, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (5, '招生信息', '本科招生', '/undergraduate', 1, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (6, '招生信息', '研究生招生', '/graduate', 2, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (7, '招生信息', '国际学生', '/international', 3, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (8, '招生信息', '奖学金', '/scholarships', 4, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (9, '联系我们', '招生咨询', '/contact', 1, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (10, '联系我们', '校园访问', '/visit', 2, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (11, '联系我们', '信息公开', '/public', 3, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `footer_links` VALUES (12, '联系我们', '校友会', '/alumni', 4, '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for nav_links
-- ----------------------------
DROP TABLE IF EXISTS `nav_links`;
CREATE TABLE `nav_links`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NULL DEFAULT 0,
  `sort_order` int(11) NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nav_links
-- ----------------------------
INSERT INTO `nav_links` VALUES (1, '首页', '/', 1, 1, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `nav_links` VALUES (2, '院系设置', '/departments', 0, 2, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `nav_links` VALUES (3, '招生就业', '/admissions', 0, 3, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `nav_links` VALUES (4, '科学研究', '/research', 0, 4, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `nav_links` VALUES (5, '校园生活', '/campus-life', 0, 5, '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `nav_links` VALUES (6, '新闻动态', '/news', 0, 6, '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `publish_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '我校科研团队获国家重点研发计划立项', '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。', '学术', '2026-07-10', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `news` VALUES (2, '第十二届校园文化艺术节圆满落幕', '历时两周的校园文化艺术节吸引了近万名师生参与，涵盖音乐、戏剧、书法、摄影等多个板块，展现了明德学子的多元才华。', '校园', '2026-07-05', '2026-07-17 17:15:07', '2026-07-17 17:15:07');
INSERT INTO `news` VALUES (3, '2026年秋季学期开学安排公告', '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日，请各位同学做好相关准备。', '通知', '2026-06-28', '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for school_info
-- ----------------------------
DROP TABLE IF EXISTS `school_info`;
CREATE TABLE `school_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of school_info
-- ----------------------------
INSERT INTO `school_info` VALUES (1, '牛犇大学', '北京市海淀区学院路100号', '100081', '010-62888888', '2026-07-17 17:15:07', '2026-07-17 17:15:07');

-- ----------------------------
-- Table structure for tb_notice
-- ----------------------------
DROP TABLE IF EXISTS `tb_notice`;
CREATE TABLE `tb_notice`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '摘要',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类：NOTICE-通知公告, NEWS-新闻动态, ACADEMIC-学术活动, ADMIN-行政公告',
  `priority` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'NORMAL' COMMENT '优先级：HIGH-高, NORMAL-普通, LOW-低',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'DRAFT' COMMENT '状态：DRAFT-草稿, PUBLISHED-已发布, REVOKED-已撤回',
  `publisher_id` bigint(20) NULL DEFAULT NULL COMMENT '发布人ID',
  `publisher_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布人姓名',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `is_top` tinyint(4) NULL DEFAULT 0 COMMENT '是否置顶（0-否 1-是）',
  `view_count` int(11) NULL DEFAULT 0 COMMENT '浏览次数',
  `attachment_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件URL',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除（0-否 1-是）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category`(`category`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_publish_time`(`publish_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_notice
-- ----------------------------
INSERT INTO `tb_notice` VALUES (1, '关于2024年元旦放假的通知', '根据学校安排，2024年元旦放假时间为1月1日，共1天。请各部门做好值班安排。', '2024年元旦放假安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-15 16:37:09', 1, 7, NULL, 0, '2026-07-15 16:37:09', '2026-07-17 09:29:39');
INSERT INTO `tb_notice` VALUES (2, '校园网络维护公告', '为提升校园网络质量，将于本周六凌晨2:00-6:00进行网络设备升级，届时全校网络将暂时中断。', '本周末网络维护', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-15 16:37:09', 0, 1, NULL, 0, '2026-07-15 16:37:09', '2026-07-16 17:57:17');
INSERT INTO `tb_notice` VALUES (3, '学术讲座：人工智能前沿技术', '本次讲座邀请到著名AI专家王教授，将介绍大模型、机器学习等前沿技术，欢迎师生参加。时间：周三下午2点，地点：学术报告厅。', 'AI前沿技术讲座', 'ACADEMIC', 'HIGH', 'PUBLISHED', 2, '张老师', '2026-07-15 16:37:09', 0, 2, NULL, 0, '2026-07-15 16:37:09', '2026-07-16 17:57:44');
INSERT INTO `tb_notice` VALUES (4, '2026年秋季学期开学返校通知', '为保障新学期教学工作有序开展，结合学校工作安排，全体学生于2026年9月1日-2日错峰返校，9月3日正式上课。请各学院督促学生按时返校，做好返校登记、健康自查工作，严禁无故迟到、旷课。教职工9月1日全员到岗开展工作。', '2026年秋季学期学生返校及开学工作安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-18 10:00:00', 1, 126, NULL, 0, '2026-07-18 10:00:00', '2026-07-18 10:00:00');
INSERT INTO `tb_notice` VALUES (5, '暑期校园图书馆开放时间调整公告', '暑期期间图书馆调整开放时段，周一至周五8:00-21:00开放，周六周日9:00-18:00开放，每周三下午闭馆整理书籍。请师生合理安排借阅时间，遵守图书馆管理规定。', '暑期图书馆开放时间调整说明', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-18 10:10:00', 0, 89, NULL, 0, '2026-07-18 10:10:00', '2026-07-18 10:10:00');
INSERT INTO `tb_notice` VALUES (6, '学术报告：大数据与智慧校园建设研讨', '本次学术报告邀请高校信息化建设专家李教授，围绕大数据技术在校园管理、教学服务、智慧运维中的应用展开讲解，分享高校智慧校园建设案例与发展趋势。讲座时间：7月30日下午3点，地点：行政楼学术报告厅，欢迎全校师生参会。', '大数据与智慧校园建设专题学术报告', 'ACADEMIC', 'HIGH', 'PUBLISHED', 2, '张老师', '2026-07-18 10:20:00', 0, 45, NULL, 0, '2026-07-18 10:20:00', '2026-07-18 10:20:00');
INSERT INTO `tb_notice` VALUES (7, '我校学子在省级学科竞赛中斩获多项奖项', '在2026年省级大学生计算机设计大赛中，我校学子凭借扎实的专业功底和创新能力，斩获一等奖2项、二等奖5项、三等奖8项，充分展现了我校应用型人才培养成果。', '我校学生省级学科竞赛获奖喜讯', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-18 10:30:00', 0, 156, NULL, 0, '2026-07-18 10:30:00', '2026-07-28 15:44:16');
INSERT INTO `tb_notice` VALUES (8, '关于开展暑期安全专项排查工作的通知', '为筑牢校园安全防线，杜绝安全隐患，学校将开展暑期校园安全专项排查，重点排查宿舍、实验室、食堂、消防设施、水电设备等区域安全问题。各部门需于7月25日前完成自查并提交整改报告。', '暑期校园安全专项排查工作安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-19 09:00:00', 1, 98, NULL, 0, '2026-07-19 09:00:00', '2026-07-19 09:00:00');
INSERT INTO `tb_notice` VALUES (9, '校园食堂暑期菜品更新及价格公示通知', '为提升师生就餐体验，暑期食堂优化菜品结构，新增20余种家常菜品、特色小吃，同时公示所有菜品价格，严格执行物价标准，杜绝乱涨价现象，全力保障师生饮食安全与权益。', '暑期食堂菜品更新及价格公示', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-19 09:15:00', 0, 76, NULL, 0, '2026-07-19 09:15:00', '2026-07-19 09:15:00');
INSERT INTO `tb_notice` VALUES (10, '科研讲座：高校横向课题申报技巧解析', '本次讲座聚焦高校横向课题申报流程、材料撰写、立项要点、经费管理等核心内容，邀请资深科研管理专家现场答疑，助力教师提升课题申报成功率。面向全体教职工开展，时间8月5日上午9点。', '高校横向课题申报技巧专题科研讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-19 09:30:00', 0, 32, NULL, 0, '2026-07-19 09:30:00', '2026-07-19 09:30:00');
INSERT INTO `tb_notice` VALUES (11, '学校开展2026年暑期家访暖心活动', '为精准帮扶学生成长，学校组织辅导员开展暑期家访活动，深入家庭了解学生成长环境、家庭情况，重点关注贫困学生、特殊学生群体，搭建家校共育桥梁，助力学生全面发展。', '我校开展暑期家校家访暖心活动', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-19 09:45:00', 0, 68, NULL, 0, '2026-07-19 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (12, '2026年秋季教材征订工作通知', '为保障新学期教学顺利开展，现启动2026年秋季学期教材征订工作，各学院需统计师生教材需求，于8月10日前完成线上申报，逾期不予受理。教材统一由学校招标供应商配送。', '2026年秋季学期教材征订安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-20 10:00:00', 1, 85, NULL, 0, '2026-07-20 10:00:00', '2026-07-20 10:00:00');
INSERT INTO `tb_notice` VALUES (13, '校园快递站点暑期运营时间调整通知', '暑期校园快递站点调整运营时间，每日10:00-19:00正常营业，每周日下午停业盘点。请师生及时取件，避免快递滞留超时退回。', '暑期校园快递站运营时间调整', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-20 10:15:00', 0, 42, NULL, 0, '2026-07-20 10:15:00', '2026-07-20 10:15:00');
INSERT INTO `tb_notice` VALUES (14, '学术沙龙：新媒体时代新闻传播创新研究', '本次学术沙龙面向新闻、传媒、汉语言专业师生，围绕新媒体传播规律、短视频创作、融媒体发展等热点话题开展交流研讨，鼓励师生分享研究成果、交流学术思路。', '新媒体新闻传播创新主题学术沙龙', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-20 10:30:00', 0, 28, NULL, 0, '2026-07-20 10:30:00', '2026-07-20 10:30:00');
INSERT INTO `tb_notice` VALUES (15, '我校顺利完成2026年上半年教学检查工作', '为规范教学管理、提升教学质量，学校教务处组织开展2026年上半年期末教学检查，覆盖课堂教学、教案备课、作业批改、实训教学等环节，全面梳理教学工作亮点与不足。', '我校完成上半年期末教学质量检查', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-20 10:45:00', 0, 53, NULL, 0, '2026-07-20 10:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (16, '关于暑期学生留校住宿管理的通知', '暑期留校学生需严格遵守校园住宿管理规定，按时报备留校信息，服从宿管人员管理，严禁晚归、夜不归宿，严禁违规使用电器，共同维护安全整洁的住宿环境。', '暑期留校学生住宿管理规定通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-21 09:00:00', 1, 102, NULL, 0, '2026-07-21 09:00:00', '2026-07-21 09:00:00');
INSERT INTO `tb_notice` VALUES (17, '校园公共区域绿植养护施工通知', '为美化校园环境，后勤处将于7月22日-7月30日开展校园绿植修剪、补种、养护施工，施工期间部分绿化带临时封闭，请师生绕行，注意出行安全。', '校园绿植养护施工及通行提醒', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-21 09:15:00', 0, 36, NULL, 0, '2026-07-21 09:15:00', '2026-07-21 09:15:00');
INSERT INTO `tb_notice` VALUES (18, '考研备考经验分享学术交流会通知', '为助力2027届考研学生高效备考，学校邀请往届考研高分上岸学长学姐，分享备考规划、公共课复习、专业课备考、复试调剂等实战经验，现场答疑解惑。', '2027届考研备考经验分享交流会', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-21 09:30:00', 0, 79, NULL, 0, '2026-07-21 09:30:00', '2026-07-21 09:30:00');
INSERT INTO `tb_notice` VALUES (19, '学校组织师生开展暑期志愿服务活动', '暑假期间，学校团委组织师生志愿者开展社区帮扶、文明劝导、公益宣讲等志愿服务活动，积极践行社会责任，展现我校师生良好精神风貌。', '我校师生积极参与暑期志愿服务', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-21 09:45:00', 0, 61, NULL, 0, '2026-07-21 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (20, '2026年教师节表彰评选工作启动通知', '为表彰先进、树立榜样，弘扬尊师重教风尚，学校启动2026年优秀教师、优秀班主任、师德标兵评选工作，各部门需按要求推荐候选人，8月20日前完成申报。', '2026年教师节优秀教职工评选通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-22 10:00:00', 1, 88, NULL, 0, '2026-07-22 10:00:00', '2026-07-22 10:00:00');
INSERT INTO `tb_notice` VALUES (21, '校园浴室暑期清洁消毒安排通知', '为保障师生暑期洗浴卫生安全，后勤处将于7月25日、8月10日、8月25日对校园公共浴室进行全面清洁、消毒、设备检修，消毒期间浴室临时暂停开放。', '暑期校园浴室清洁消毒及暂停开放通知', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-22 10:15:00', 0, 49, NULL, 0, '2026-07-22 10:15:00', '2026-07-22 10:15:00');
INSERT INTO `tb_notice` VALUES (22, '人工智能专业前沿发展趋势专题讲座', '本次讲座聚焦人工智能产业发展、专业就业前景、核心技术迭代、行业人才需求等内容，结合当下AI行业热点，为人工智能专业学生提供专业学习与职业规划指导。', '人工智能专业发展趋势专题讲座', 'ACADEMIC', 'HIGH', 'PUBLISHED', 2, '张老师', '2026-07-22 10:30:00', 0, 57, NULL, 0, '2026-07-22 10:30:00', '2026-07-22 10:30:00');
INSERT INTO `tb_notice` VALUES (23, '我校新增2个校级一流本科专业建设点', '经学校评审、公示审定，2026年我校新增软件工程、汉语言文学2个校级一流本科专业建设点，学校将加大经费投入，持续提升专业建设水平与人才培养质量。', '我校新增两个校级一流本科专业', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-22 10:45:00', 0, 73, NULL, 0, '2026-07-22 10:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (24, '关于做好暑期防汛防台风安全工作的通知', '暑期为汛期、台风高发时段，为保障校园财产安全和留校师生人身安全，各部门需严格落实防汛防台风工作要求，做好隐患排查、应急值守、物资储备等工作。', '暑期校园防汛防台风安全工作部署', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-23 09:00:00', 1, 94, NULL, 0, '2026-07-23 09:00:00', '2026-07-23 09:00:00');
INSERT INTO `tb_notice` VALUES (25, '校园停车场暑期车位优化调整通知', '为规范校园停车秩序，提升停车利用率，学校对暑期校园停车场车位进行重新规划划分，增设临时访客车位，规范教职工停车区域，即日起正式执行。', '暑期校园停车场车位优化调整公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-23 09:15:00', 0, 31, NULL, 0, '2026-07-23 09:15:00', '2026-07-23 09:15:00');
INSERT INTO `tb_notice` VALUES (26, '经管类专业创新创业科研论坛通知', '本次论坛面向经管类师生，围绕大学生创新创业、小微企业运营、互联网创业模式等主题开展学术交流，搭建师生科研交流、项目孵化、创新创业对接平台。', '经管专业创新创业科研交流论坛', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-23 09:30:00', 0, 29, NULL, 0, '2026-07-23 09:30:00', '2026-07-23 09:30:00');
INSERT INTO `tb_notice` VALUES (27, '学校召开暑期中层干部工作部署会议', '7月23日，学校召开暑期中层干部工作会议，总结上半年办学成果，部署暑期基建改造、招生录取、教学筹备、校园安全等重点工作，明确新学期发展目标。', '我校召开暑期重点工作部署会议', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-23 09:45:00', 0, 65, NULL, 0, '2026-07-23 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (28, '2026年新生入学教育工作方案通知', '为帮助2026级新生快速适应大学生活，树立正确的学业观、价值观，学校制定新生入学教育方案，涵盖安全教育、校规校纪、学业规划、校园文化等多项教育内容。', '2026级新生入学教育工作安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-24 10:00:00', 1, 107, NULL, 0, '2026-07-24 10:00:00', '2026-07-24 10:00:00');
INSERT INTO `tb_notice` VALUES (29, '校园直饮水设备全面检修维护通知', '后勤保障处将于7月26日-28日对全校教学楼、宿舍楼、办公楼直饮水设备进行全面检修、滤芯更换、水质检测，检修期间部分设备暂停使用。', '校园直饮水设备暑期检修维护通知', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-24 10:15:00', 0, 44, NULL, 0, '2026-07-24 10:15:00', '2026-07-24 10:15:00');
INSERT INTO `tb_notice` VALUES (30, '外语四六级备考技巧专题学术讲座', '为助力学生顺利通过大学英语四六级考试，本次讲座围绕听力、阅读、写作、翻译四大题型，讲解高频考点、解题技巧、备考方法，针对性解决学生备考难点问题。', '大学英语四六级备考技巧专题讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-24 10:30:00', 0, 83, NULL, 0, '2026-07-24 10:30:00', '2026-07-24 10:30:00');
INSERT INTO `tb_notice` VALUES (31, '我校暑期社会实践团队奔赴各地开展调研', '2026年暑期，我校组建20支社会实践团队，奔赴乡村、社区、企业开展乡村振兴调研、红色文化宣讲、民生服务等实践活动，践行知行合一育人理念。', '我校学子积极开展暑期社会实践活动', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-24 10:45:00', 0, 71, NULL, 0, '2026-07-24 10:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (32, '关于规范暑期校园进出管理的通知', '为强化暑期校园安全管理，严格落实校园门禁制度，校外人员入校需实名登记，留校学生、教职工凭校园卡进出校园，严禁无关人员、车辆随意入校。', '暑期校园出入安全管理规范通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-25 09:00:00', 1, 91, NULL, 0, '2026-07-25 09:00:00', '2026-07-25 09:00:00');
INSERT INTO `tb_notice` VALUES (33, '校园路灯系统升级改造施工通知', '学校将于7月27日-8月5日开展校园路灯系统升级改造，更换老旧灯具、新增节能路灯、优化照明线路，施工期间部分路段照明临时中断，请师生注意通行安全。', '校园路灯系统升级改造施工公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-25 09:15:00', 0, 38, NULL, 0, '2026-07-25 09:15:00', '2026-07-25 09:15:00');
INSERT INTO `tb_notice` VALUES (34, '文学创作与经典品读学术分享会通知', '本次分享会面向文学爱好者，围绕经典文学作品解读、现代文学创作技巧、散文诗歌写作思路等内容开展交流，提升学生文学素养与写作能力。', '文学创作与经典品读学术分享会', 'ACADEMIC', 'LOW', 'PUBLISHED', 2, '张老师', '2026-07-25 09:30:00', 0, 25, NULL, 0, '2026-07-25 09:30:00', '2026-07-25 09:30:00');
INSERT INTO `tb_notice` VALUES (35, '学校获评市级文明校园先进单位荣誉称号', '经市委文明办评审认定，我校凭借优良的校园风尚、完善的育人体系、扎实的文明创建工作，成功获评2026年度市级文明校园先进单位。', '我校获评市级文明校园先进单位', 'NOTICE', 'HIGH', 'PUBLISHED', 3, '李老师', '2026-07-25 09:45:00', 0, 132, NULL, 0, '2026-07-25 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (36, '2026年秋季学期学费缴纳通知', '为保障新学期教学工作正常开展，现将2026年秋季学期学费、住宿费缴纳事宜通知如下，全体在校生需于8月15日前完成线上缴费，逾期将影响新学期注册。', '2026年秋季学期学费缴费安排通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-26 09:00:00', 1, 115, NULL, 0, '2026-07-26 09:00:00', '2026-07-26 09:00:00');
INSERT INTO `tb_notice` VALUES (37, '校园中央空调暑期检修停机通知', '后勤处将于7月28日-8月2日对全校教学楼、办公楼中央空调系统进行全面检修保养，检修期间中央空调暂停运行，敬请广大师生谅解。', '暑期校园中央空调检修停机公告', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-26 09:20:00', 0, 52, NULL, 0, '2026-07-26 09:20:00', '2026-07-26 09:20:00');
INSERT INTO `tb_notice` VALUES (38, '机械专业智能制造技术专题讲座', '本次讲座聚焦智能制造、工业机器人、数字化生产等前沿技术，结合行业实操案例讲解专业核心知识，助力机械专业学生把握行业发展方向。', '智能制造前沿技术专业专题讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-26 09:40:00', 0, 37, NULL, 0, '2026-07-26 09:40:00', '2026-07-26 09:40:00');
INSERT INTO `tb_notice` VALUES (39, '我校学子在市级田径运动会斩获佳绩', '在2026年市级大学生田径运动会上，我校运动健儿奋勇拼搏，斩获3金4银2铜，打破两项市级赛事纪录，充分展现我校学子顽强拼搏的体育精神。', '我校学子市级田径运动会斩获多项奖牌', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-26 10:00:00', 0, 86, NULL, 0, '2026-07-26 10:00:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (40, '关于暑期学生网络安全教育的通知', '为防范电信网络诈骗，提升学生网络安全意识，学校要求各学院开展暑期网络安全教育，引导学生规范网络行为，杜绝网络借贷、刷单诈骗等风险行为。', '暑期学生网络安全防范教育通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-27 09:00:00', 1, 103, NULL, 0, '2026-07-27 09:00:00', '2026-07-27 09:00:00');
INSERT INTO `tb_notice` VALUES (41, '校园垃圾分类暑期专项整治通知', '为持续推进校园垃圾分类工作，暑期开展垃圾分类专项整治行动，规范各区域垃圾投放标准，安排专人巡查督导，营造整洁文明校园环境。', '暑期校园垃圾分类专项整治公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-27 09:15:00', 0, 29, NULL, 0, '2026-07-27 09:15:00', '2026-07-27 09:15:00');
INSERT INTO `tb_notice` VALUES (42, '公务员考试备考常识干货分享交流会', '本次交流会聚焦公务员考试行测、申论备考重点，讲解时政常识积累、答题思维搭建、真题复盘技巧，助力备考学生高效备考公考。', '公务员考试备考技巧分享交流会', 'ACADEMIC', 'LOW', 'PUBLISHED', 2, '张老师', '2026-07-27 09:30:00', 0, 41, NULL, 0, '2026-07-27 09:30:00', '2026-07-27 09:30:00');
INSERT INTO `tb_notice` VALUES (43, '学校开展暑期教师教研提升培训活动', '为提升教师教学能力与教研水平，学校组织全体专任教师开展暑期线上教研培训，涵盖新课改理念、信息化教学、课程设计等核心内容。', '我校开展暑期教师教研能力提升培训', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-27 09:45:00', 0, 58, NULL, 0, '2026-07-27 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (44, '2026年秋季社团招新筹备工作通知', '为保障新学期学生社团工作有序开展，现启动秋季社团招新筹备工作，各社团需完善招新方案、准备宣传物料，8月25日前完成筹备报备。', '2026年秋季学生社团招新筹备通知', 'NOTICE', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-28 09:00:00', 0, 67, NULL, 0, '2026-07-28 09:00:00', '2026-07-28 09:00:00');
INSERT INTO `tb_notice` VALUES (45, '校园超市暑期商品价格管控通知', '为规范暑期校园超市经营行为，保障师生消费权益，学校后勤部门对校园超市商品价格进行专项管控，严禁哄抬物价、违规涨价，接受师生监督。', '暑期校园超市商品价格管控公告', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-28 09:15:00', 0, 45, NULL, 0, '2026-07-28 09:15:00', '2026-07-28 09:15:00');
INSERT INTO `tb_notice` VALUES (46, '生态环境治理前沿学术研讨讲座', '本次讲座聚焦生态保护、环境治理、绿色发展等热点领域，结合当下环保政策与行业案例，讲解生态环境专业研究方向与就业前景。', '生态环境治理前沿学术研讨讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-28 09:30:00', 0, 33, NULL, 0, '2026-07-28 09:30:00', '2026-07-28 09:30:00');
INSERT INTO `tb_notice` VALUES (47, '我校两项校级科研课题顺利结题', '经学校科研处评审验收，我校2025年度两项校级重点科研课题顺利完成结题工作，课题研究成果贴合教学实际，具备良好的应用推广价值。', '我校两项校级科研课题顺利结题', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-28 09:45:00', 0, 49, NULL, 0, '2026-07-28 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (48, '关于新学期课程预选工作的通知', '为合理调配教学资源，保障新学期选课工作有序开展，学校将开启2026年秋季学期课程预选，学生需在规定时间内完成选课操作，逾期不予补选。', '2026年秋季学期课程预选工作通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-29 09:00:00', 1, 96, NULL, 0, '2026-07-29 09:00:00', '2026-07-29 09:00:00');
INSERT INTO `tb_notice` VALUES (49, '校园安防监控系统升级维护通知', '学校将于7月30日-8月3日对全校安防监控系统进行升级迭代、设备检修、线路优化，维护期间部分区域监控临时失效，敬请谅解。', '校园安防监控系统暑期升级维护公告', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-29 09:15:00', 0, 40, NULL, 0, '2026-07-29 09:15:00', '2026-07-29 09:15:00');
INSERT INTO `tb_notice` VALUES (50, '法学专业司法考试备考经验分享会', '邀请往届法考高分上岸毕业生，分享司法考试备考规划、法条记忆、案例分析、主观题答题技巧，为法学专业学生提供实战备考指导。', '法学专业司法考试备考经验分享会', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-29 09:30:00', 0, 51, NULL, 0, '2026-07-29 09:30:00', '2026-07-29 09:30:00');
INSERT INTO `tb_notice` VALUES (51, '学校开展暑期校园环境整治专项行动', '为打造整洁优美的校园环境，后勤部门开展暑期校园环境专项整治，重点清理卫生死角、整治乱堆乱放、修缮破损设施，全面提升校园风貌。', '我校开展暑期校园环境整治专项行动', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-29 09:45:00', 0, 62, NULL, 0, '2026-07-29 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (52, '2026年秋季助学金申请申报通知', '为做好新学期学生资助工作，助力家庭经济困难学生顺利就学，现启动2026年秋季学期助学金申请工作，各学院严格审核，按时完成申报流程。', '2026年秋季学期助学金申报通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-30 09:00:00', 1, 109, NULL, 0, '2026-07-30 09:00:00', '2026-07-30 09:00:00');
INSERT INTO `tb_notice` VALUES (53, '校园电动车规范停放管理通知', '为规范校园电动车停放、充电秩序，消除安全隐患，学校划定专属停放区域，严禁电动车进楼入户、乱停乱放，暑期常态化巡查管控。', '暑期校园电动车规范停放管理公告', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-07-30 09:15:00', 0, 55, NULL, 0, '2026-07-30 09:15:00', '2026-07-30 09:15:00');
INSERT INTO `tb_notice` VALUES (54, '心理学心理健康知识科普学术讲座', '本次讲座围绕大学生常见心理问题、情绪调节、压力疏导、人际交往等内容展开科普，帮助学生掌握心理调节方法，培育健康心理状态。', '大学生心理健康知识科普专题讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-30 09:30:00', 0, 64, NULL, 0, '2026-07-30 09:30:00', '2026-07-30 09:30:00');
INSERT INTO `tb_notice` VALUES (55, '我校与多家企业签订校企合作协议', '为深化产教融合、提升学生就业质量，我校与本地优质企业签订校企合作协议，共建实训基地、开展订单式培养，助力学生高质量就业。', '我校新增多家校企合作单位', 'NOTICE', 'HIGH', 'PUBLISHED', 3, '李老师', '2026-07-30 09:45:00', 0, 92, NULL, 0, '2026-07-30 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (56, '暑期学生外出实践安全报备通知', '所有暑期外出实习、实践、游玩的学生，需提前向辅导员报备行程信息、联系方式，每日按时签到，确保人身安全，杜绝私自外出、失联情况。', '暑期学生外出安全报备管理通知', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-07-31 09:00:00', 1, 87, NULL, 0, '2026-07-31 09:00:00', '2026-07-31 09:00:00');
INSERT INTO `tb_notice` VALUES (57, '校园公共卫生间升级改造施工通知', '为提升校园公共服务设施品质，学校将于8月1日-8月8日对校园公共卫生间进行升级改造，施工期间对应卫生间临时封闭，敬请师生谅解。', '校园公共卫生间升级改造施工公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-07-31 09:15:00', 0, 34, NULL, 0, '2026-07-31 09:15:00', '2026-07-31 09:15:00');
INSERT INTO `tb_notice` VALUES (58, '数字媒体艺术设计创新讲座', '本次讲座聚焦数字插画、短视频设计、三维建模、新媒体视觉设计等行业前沿内容，结合商业设计案例，为艺术设计专业学生提供创作指导。', '数字媒体艺术设计创新专题讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-07-31 09:30:00', 0, 39, NULL, 0, '2026-07-31 09:30:00', '2026-07-31 09:30:00');
INSERT INTO `tb_notice` VALUES (59, '学校开展红色教育主题暑期实践活动', '为传承红色基因、厚植爱国情怀，学校组织学生赴红色教育基地开展研学实践，通过实地研学、党史学习、心得交流，强化学生爱国理想信念。', '我校开展红色教育暑期研学实践活动', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-07-31 09:45:00', 0, 74, NULL, 0, '2026-07-31 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (60, '2026年新生宿舍分配工作通知', '为有序开展新生入学筹备工作，学校启动2026级新生宿舍分配工作，按照专业集中、合理调配的原则统筹分配宿舍，保障新生住宿需求。', '2026级新生宿舍分配工作安排', 'NOTICE', 'HIGH', 'PUBLISHED', 1, '系统管理员', '2026-08-01 10:00:00', 1, 99, NULL, 0, '2026-08-01 10:00:00', '2026-08-01 10:00:00');
INSERT INTO `tb_notice` VALUES (61, '暑期校园广播系统调试通知', '为保障新学期校园广播正常运行，后勤部门将于8月2日对全校广播系统进行全面调试、音效优化、设备检修，调试期间广播将间歇性播放测试音。', '暑期校园广播系统调试公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-08-01 10:15:00', 0, 27, NULL, 0, '2026-08-01 10:15:00', '2026-08-01 10:15:00');
INSERT INTO `tb_notice` VALUES (62, '金融专业投资理财知识科普讲座', '本次讲座围绕金融市场、投资理财、风险防控、理财规划等内容展开，结合当下经济形势，为金融专业学生普及专业知识与实操技巧。', '金融专业投资理财知识科普讲座', 'ACADEMIC', 'LOW', 'PUBLISHED', 2, '张老师', '2026-08-01 10:30:00', 0, 35, NULL, 0, '2026-08-01 10:30:00', '2026-08-01 10:30:00');
INSERT INTO `tb_notice` VALUES (63, '我校教师多篇论文入选核心期刊发表', '近期，我校多名专任教师撰写的学术论文成功入选中文核心期刊、SCI期刊发表，内容涵盖教育教学、工程技术、人文社科等多个领域，科研成果丰硕。', '我校教师多篇学术论文成功发表', 'NOTICE', 'HIGH', 'PUBLISHED', 3, '李老师', '2026-08-01 10:45:00', 0, 81, NULL, 0, '2026-08-01 10:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (64, '关于新学期校园卫生包干区划分的通知', '为持续优化校园环境卫生管理，学校重新划分新学期各学院、各部门卫生包干区域，明确清扫责任与考核标准，全面落实校园卫生责任制。', '2026年秋季校园卫生包干区划分通知', 'NOTICE', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-08-02 09:00:00', 0, 59, NULL, 0, '2026-08-02 09:00:00', '2026-08-02 09:00:00');
INSERT INTO `tb_notice` VALUES (65, '校园健身器材暑期检修维护通知', '后勤体育部对校园操场、健身区所有健身器材进行全面检修、除锈保养、破损更换，消除器材安全隐患，保障师生健身安全。', '暑期校园健身器材检修维护公告', 'ADMIN', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-08-02 09:15:00', 0, 43, NULL, 0, '2026-08-02 09:15:00', '2026-08-02 09:15:00');
INSERT INTO `tb_notice` VALUES (66, '毕业论文写作规范与技巧指导讲座', '针对2027届毕业生，本次讲座详细讲解毕业论文选题、框架搭建、文献检索、格式规范、查重降重等核心内容，助力学生规范完成论文写作。', '毕业生毕业论文写作规范指导讲座', 'ACADEMIC', 'HIGH', 'PUBLISHED', 2, '张老师', '2026-08-02 09:30:00', 0, 95, NULL, 0, '2026-08-02 09:30:00', '2026-08-02 09:30:00');
INSERT INTO `tb_notice` VALUES (67, '学校开展暑期反诈宣传进校园活动', '为筑牢师生反诈防线，学校联合辖区派出所开展暑期反诈宣传活动，通过案例讲解、互动问答、视频科普，提升师生反诈防骗意识。', '我校开展暑期反诈宣传专项活动', 'NOTICE', 'NORMAL', 'PUBLISHED', 3, '李老师', '2026-08-02 09:45:00', 0, 77, NULL, 0, '2026-08-02 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (68, '2026年秋季运动会筹备工作通知', '为丰富校园文体生活，学校拟定于10月举办秋季田径运动会，现启动运动会筹备工作，各学院需积极组织运动员选拔、报名及训练工作。', '2026年秋季校园运动会筹备通知', 'NOTICE', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-08-03 09:00:00', 0, 72, NULL, 0, '2026-08-03 09:00:00', '2026-08-03 09:00:00');
INSERT INTO `tb_notice` VALUES (69, '校园雨水管网疏通清理施工通知', '为提升校园防汛排水能力，后勤部门将于8月3日-8月6日开展校园雨水管网疏通、淤泥清理、管道检修施工，施工期间部分路段临时封闭。', '校园雨水管网疏通清理施工公告', 'ADMIN', 'LOW', 'PUBLISHED', 1, '系统管理员', '2026-08-03 09:15:00', 0, 30, NULL, 0, '2026-08-03 09:15:00', '2026-08-03 09:15:00');
INSERT INTO `tb_notice` VALUES (70, '跨境电商行业发展与就业前景讲座', '本次讲座聚焦跨境电商行业发展现状、运营模式、岗位需求、就业前景，结合实操案例，为电商、国贸专业学生提供职业规划指导。', '跨境电商行业发展与就业专题讲座', 'ACADEMIC', 'NORMAL', 'PUBLISHED', 2, '张老师', '2026-08-03 09:30:00', 0, 47, NULL, 0, '2026-08-03 09:30:00', '2026-08-03 09:30:00');
INSERT INTO `tb_notice` VALUES (71, '我校获批多项市级科研创新项目', '经市级科研部门评审公示，我校本年度获批市级科研创新项目6项、青年科研项目3项，获得专项科研经费支持，科研创新实力持续提升。', '我校获批多项市级科研创新项目', 'NOTICE', 'HIGH', 'PUBLISHED', 3, '李老师', '2026-08-03 09:45:00', 0, 84, NULL, 0, '2026-08-03 09:45:00', '2026-07-28 15:48:32');
INSERT INTO `tb_notice` VALUES (72, '关于规范学生暑期线上学习的通知', '为督促学生充分利用暑期时间提升自我，各学院需组织学生开展线上自主学习、课程预习、技能提升，杜绝暑期虚度光阴，夯实学业基础。', '学生暑期线上自主学习规范通知', 'NOTICE', 'NORMAL', 'PUBLISHED', 1, '系统管理员', '2026-08-04 09:00:00', 0, 63, NULL, 0, '2026-08-04 09:00:00', '2026-08-04 09:00:00');

-- ----------------------------
-- Table structure for tb_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_operation_log`;
CREATE TABLE `tb_operation_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '操作用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作用户名',
  `operation_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型：CREATE-创建, UPDATE-更新, DELETE-删除, VIEW-查看',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作模块',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求IP',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作结果：SUCCESS-成功, FAIL-失败',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_operation_type`(`operation_type`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_operation_log
-- ----------------------------
INSERT INTO `tb_operation_log` VALUES (1, 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-16 09:59:56');
INSERT INTO `tb_operation_log` VALUES (2, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (3, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (4, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (5, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (6, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (7, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (8, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (9, 1, 'admin', 'CREATE', '公告管理', '发布公告：', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (10, 1, 'admin', 'CREATE', '公告管理', '发布公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (11, 1, 'admin', 'CREATE', '公告管理', '发布公告：??????', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (12, 1, 'admin', 'DELETE', '公告管理', '删除公告ID：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (13, 1, 'admin', 'CREATE', '公告管理', '发布公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (14, 1, 'admin', 'UPDATE', '公告管理', '更新公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (15, 1, 'admin', 'UPDATE', '公告管理', '更新公告：????', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (16, 1, 'admin', 'UPDATE', '公告管理', '更新公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (17, 1, 'admin', 'DELETE', '公告管理', '删除公告ID：14', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (18, 1, 'admin', 'UPDATE', '公告管理', '更新公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (19, 1, 'admin', 'UPDATE', '公告管理', '更新公告：关于2024年元旦放假的通知', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (20, 1, 'admin', 'CREATE', '公告管理', '发布公告：111', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (21, 1, 'admin', 'UPDATE', '公告管理', '更新公告：关于2024年元旦放假的通知', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (22, 1, 'admin', 'UPDATE', '公告管理', '更新公告：111111', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (23, 1, 'admin', 'UPDATE', '公告管理', '更新公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (24, 1, 'admin', 'UPDATE', '公告管理', '更新公告：11', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (25, 1, 'admin', 'CREATE', '公告管理', '发布公告：123123', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (26, 1, 'admin', 'CREATE', '公告管理', '发布公告：124132', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (27, 1, 'admin', 'UPDATE', '公告管理', '更新公告：124132', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (28, 1, 'admin', 'UPDATE', '公告管理', '更新公告：124132', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (29, 1, 'admin', 'CREATE', '公告管理', '发布公告：123', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (30, 1, 'admin', 'CREATE', '公告管理', '发布公告：1111', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (31, 1, 'admin', 'UPDATE', '公告管理', '更新公告：111', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (32, 1, 'admin', 'UPDATE', '公告管理', '更新公告：111', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (33, 1, 'admin', 'CREATE', '公告管理', '发布公告：zzx', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (34, 1, 'admin', 'CREATE', '公告管理', '发布公告：asd', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (35, 1, 'admin', 'CREATE', '公告管理', '发布公告：asfasf', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (36, 1, 'admin', 'UPDATE', '公告管理', '更新公告：关于2024年元旦放假的通知', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (37, 1, 'admin', 'DELETE', '公告管理', '删除公告ID：10', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (38, 1, 'admin', 'DELETE', '公告管理', '删除公告ID：20', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (39, 1, 'admin', 'UPDATE', '公告管理', '更新公告：123123', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (40, 1, 'admin', 'UPDATE', '公告管理', '更新公告：asd', NULL, NULL, NULL, 'SUCCESS', NULL);
INSERT INTO `tb_operation_log` VALUES (41, 1, 'admin', 'UPDATE', '公告管理', '更新公告：asfasf', NULL, NULL, NULL, 'SUCCESS', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码（MD5加密）',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色：ADMIN-管理员, STUDENT-学生, TEACHER-教师',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门/院系',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除（0-否 1-是）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'ADMIN', NULL, NULL, '信息中心', 0, '2026-07-15 16:37:09', '2026-07-17 08:27:05');
INSERT INTO `user` VALUES (2, 'teacher01', 'e10adc3949ba59abbe56e057f20f883e', '张老师', 'TEACHER', NULL, NULL, '计算机学院', 0, '2026-07-15 16:37:09', '2026-07-15 16:37:09');
INSERT INTO `user` VALUES (3, 'student01', 'e10adc3949ba59abbe56e057f20f883e', '李同学', 'STUDENT', NULL, NULL, '计算机学院', 0, '2026-07-15 16:37:09', '2026-07-15 16:37:09');

SET FOREIGN_KEY_CHECKS = 1;
