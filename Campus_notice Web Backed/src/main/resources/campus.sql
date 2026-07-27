CREATE DATABASE IF NOT EXISTS campus_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE campus_db;

DROP TABLE IF EXISTS campus_stats;
CREATE TABLE campus_stats (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    stat_key VARCHAR(50) NOT NULL UNIQUE,
    stat_value VARCHAR(100) NOT NULL,
    stat_label VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO campus_stats (stat_key, stat_value, stat_label) VALUES
('history_years', '70', '年办学历史'),
('student_count', '35000', '在校学生'),
('faculty_count', '2800', '教职员工'),
('degree_programs', '156', '硕博学位点');

DROP TABLE IF EXISTS academic_programs;
CREATE TABLE academic_programs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO academic_programs (code, name, description) VALUES
('CS', '计算机科学', '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才'),
('EM', '经济管理', '融合经济学与管理学前沿理论，注重实践与国际化视野'),
('LC', '文学与传播', '传承人文精神，在数字时代探索文学创作与传媒创新'),
('LS', '生命科学', '从基因到生态，探索生命奥秘，推动生物医药前沿突破'),
('ET', '工程技术', '涵盖土木、机械、电子等多个方向，产学研深度融合'),
('AD', '艺术设计', '融合传统美学与现代设计理念，激发创造力与审美表达');

DROP TABLE IF EXISTS campus_life_features;
CREATE TABLE campus_life_features (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO campus_life_features (title, description) VALUES
('学生社团', '200+社团涵盖学术、文化、体育、公益等领域'),
('体育竞技', '省级赛事多次获奖，体育精神融入校园文化'),
('志愿服务', '参与公益项目，践行社会责任，传递温暖力量');

DROP TABLE IF EXISTS news;
CREATE TABLE news (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    summary TEXT,
    category VARCHAR(50) NOT NULL,
    publish_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO news (title, summary, category, publish_date) VALUES
('我校科研团队获国家重点研发计划立项', '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。', '学术', '2026-07-10'),
('第十二届校园文化艺术节圆满落幕', '历时两周的校园文化艺术节吸引了近万名师生参与，涵盖音乐、戏剧、书法、摄影等多个板块，展现了明德学子的多元才华。', '校园', '2026-07-05'),
('2026年秋季学期开学安排公告', '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日，请各位同学做好相关准备。', '通知', '2026-06-28');

DROP TABLE IF EXISTS nav_links;
CREATE TABLE nav_links (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50) NOT NULL,
    path VARCHAR(100) NOT NULL,
    is_active TINYINT(1) DEFAULT 0,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO nav_links (label, path, is_active, sort_order) VALUES
('首页', '/', 1, 1),
('院系设置', '/departments', 0, 2),
('招生就业', '/admissions', 0, 3),
('科学研究', '/research', 0, 4),
('校园生活', '/campus-life', 0, 5),
('新闻动态', '/news', 0, 6);

DROP TABLE IF EXISTS footer_links;
CREATE TABLE footer_links (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    section VARCHAR(50) NOT NULL,
    label VARCHAR(100) NOT NULL,
    path VARCHAR(100) NOT NULL,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO footer_links (section, label, path, sort_order) VALUES
('快速链接', '院系设置', '/departments', 1),
('快速链接', '科学研究', '/research', 2),
('快速链接', '校园生活', '/campus-life', 3),
('快速链接', '新闻动态', '/news', 4),
('招生信息', '本科招生', '/undergraduate', 1),
('招生信息', '研究生招生', '/graduate', 2),
('招生信息', '国际学生', '/international', 3),
('招生信息', '奖学金', '/scholarships', 4),
('联系我们', '招生咨询', '/contact', 1),
('联系我们', '校园访问', '/visit', 2),
('联系我们', '信息公开', '/public', 3),
('联系我们', '校友会', '/alumni', 4);

DROP TABLE IF EXISTS school_info;
CREATE TABLE school_info (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(500),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO school_info (name, address, postal_code, phone) VALUES
('牛犇大学', '北京市海淀区学院路100号', '100081', '010-62888888');