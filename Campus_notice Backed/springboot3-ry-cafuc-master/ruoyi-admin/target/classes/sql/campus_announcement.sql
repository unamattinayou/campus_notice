-- 校园公告管理系统 SQL 脚本

-- 分类表
DROP TABLE IF EXISTS tb_category;
CREATE TABLE tb_category (
    id          BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    category_name VARCHAR(100) NOT NULL COMMENT '分类名称',
    sort_order   INT(11)     DEFAULT 0 COMMENT '排序',
    deleted      TINYINT(1)  DEFAULT 0 COMMENT '逻辑删除(0未删除/1已删除)',
    create_time  DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_by    VARCHAR(64) DEFAULT NULL COMMENT '创建者',
    update_by    VARCHAR(64) DEFAULT NULL COMMENT '更新者',
    remark       VARCHAR(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告分类表';

-- 公告表
DROP TABLE IF EXISTS tb_announcement;
CREATE TABLE tb_announcement (
    id              BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '公告ID',
    title           VARCHAR(200) NOT NULL COMMENT '公告标题',
    content         LONGTEXT     DEFAULT NULL COMMENT '公告内容',
    summary         VARCHAR(500) DEFAULT NULL COMMENT '公告摘要',
    category_id     BIGINT(20)   DEFAULT NULL COMMENT '分类ID',
    status          TINYINT(1)   DEFAULT 0 COMMENT '状态(0草稿/1待审核/2已发布/3已驳回)',
    publisher_id    BIGINT(20)   DEFAULT NULL COMMENT '发布者ID',
    publisher_name  VARCHAR(64)  DEFAULT NULL COMMENT '发布者名称',
    reviewer_id     BIGINT(20)   DEFAULT NULL COMMENT '审核人ID',
    review_comment  VARCHAR(500) DEFAULT NULL COMMENT '审核意见',
    publish_time    DATETIME     DEFAULT NULL COMMENT '发布时间',
    expire_time     DATETIME     DEFAULT NULL COMMENT '过期时间',
    is_top          TINYINT(1)   DEFAULT 0 COMMENT '是否置顶(0否/1是)',
    view_count      INT(11)      DEFAULT 0 COMMENT '阅读次数',
    deleted         TINYINT(1)   DEFAULT 0 COMMENT '逻辑删除(0未删除/1已删除)',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_by       VARCHAR(64)  DEFAULT NULL COMMENT '创建者',
    update_by       VARCHAR(64)  DEFAULT NULL COMMENT '更新者',
    remark          VARCHAR(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    KEY idx_category_id (category_id),
    KEY idx_status (status),
    KEY idx_publisher_id (publisher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';

-- 附件表
DROP TABLE IF EXISTS tb_attachment;
CREATE TABLE tb_attachment (
    id              BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '附件ID',
    announcement_id BIGINT(20)   NOT NULL COMMENT '公告ID',
    file_name       VARCHAR(255) NOT NULL COMMENT '文件名',
    file_path       VARCHAR(500) NOT NULL COMMENT '文件路径',
    file_size       BIGINT(20)   DEFAULT 0 COMMENT '文件大小(字节)',
    deleted         TINYINT(1)   DEFAULT 0 COMMENT '逻辑删除(0未删除/1已删除)',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_announcement_id (announcement_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='附件表';

-- 公告阅读记录表
DROP TABLE IF EXISTS tb_announcement_read;
CREATE TABLE tb_announcement_read (
    id              BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    announcement_id BIGINT(20) NOT NULL COMMENT '公告ID',
    user_id         BIGINT(20) NOT NULL COMMENT '用户ID',
    read_time       DATETIME   DEFAULT NULL COMMENT '阅读时间',
    deleted         TINYINT(1) DEFAULT 0 COMMENT '逻辑删除(0未删除/1已删除)',
    create_time     DATETIME   DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_announcement_user (announcement_id, user_id),
    KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告阅读记录表';

-- 推送记录表
DROP TABLE IF EXISTS tb_push_record;
CREATE TABLE tb_push_record (
    id              BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '推送记录ID',
    announcement_id BIGINT(20) NOT NULL COMMENT '公告ID',
    target_user_id  BIGINT(20) NOT NULL COMMENT '目标用户ID',
    is_read         TINYINT(1) DEFAULT 0 COMMENT '是否已读(0未读/1已读)',
    read_time       DATETIME   DEFAULT NULL COMMENT '阅读时间',
    deleted         TINYINT(1) DEFAULT 0 COMMENT '逻辑删除(0未删除/1已删除)',
    create_time     DATETIME   DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time     DATETIME   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_target_user_id (target_user_id),
    KEY idx_announcement_id (announcement_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推送记录表';

-- 插入默认分类数据
INSERT INTO tb_category (category_name, sort_order) VALUES ('通知公告', 1);
INSERT INTO tb_category (category_name, sort_order) VALUES ('新闻动态', 2);
INSERT INTO tb_category (category_name, sort_order) VALUES ('学术活动', 3);