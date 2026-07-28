# 校园通知管理系统

一个完整的校园信息发布与管理平台，包含门户网站、管理后台和移动端应用，实现校园公告、新闻动态的信息化发布与管理。

## 项目结构

```
Campus_notice/
├── Campus_notice Web/              # 门户网站前端
├── Campus_notice Web Backed/       # 门户网站后端
├── Campus_notice Administratice End/  # 管理后台前端
├── Campus_notice Backed/           # 管理后台后端
└── Campus_noticeHarmous/           # 鸿蒙移动端应用
```

## 系统架构

```
┌─────────────────────────────────────────────────────────────────┐
│                        客户端层                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  Vue 3 门户  │  │ 若依管理后台 │  │ HarmonyOS App│              │
│  │   (Web)     │  │   (Web)     │  │  (移动端)    │              │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘              │
└─────────┼────────────────┼────────────────┼─────────────────────┘
          │                │                │
          ▼                ▼                ▼
┌─────────────────────────────────────────────────────────────────┐
│                        服务层                                     │
│  ┌─────────────────────┐    ┌─────────────────────┐              │
│  │ Spring Boot (门户)   │    │ Spring Boot (管理)   │              │
│  │  - REST API         │    │  - 若依框架          │              │
│  │  - JPA              │    │  - MyBatis          │              │
│  └──────────┬──────────┘    └──────────┬──────────┘              │
└─────────────┼──────────────────────────┼─────────────────────────┘
              │                          │
              ▼                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                        数据层                                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │    MySQL    │  │    Redis    │  │   文件存储   │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

## 技术栈

### 门户网站前端 (Campus_notice Web)

| 技术 | 版本 | 说明 |
|------|------|------|
| Vue | 3.5.x | 渐进式 JavaScript 框架 |
| Vue Router | 4.6.x | 官方路由管理器 |
| Vite | 6.3.x | 下一代前端构建工具 |
| Tailwind CSS | 3.4.x | 实用优先的 CSS 框架 |
| Axios | 1.18.x | HTTP 客户端 |
| Lucide Vue Next | 0.577.x | 图标库 |

### 门户网站后端 (Campus_notice Web Backed)

| 技术 | 版本 | 说明 |
|------|------|------|
| Spring Boot | 4.0.x | 应用框架 |
| Spring Data JPA | - | 数据持久化 |
| MySQL Connector | 8.x | MySQL 驱动 |
| Lombok | - | 简化代码 |

### 管理后台前端 (Campus_notice Administratice End)

| 技术 | 版本 | 说明 |
|------|------|------|
| Vue | 3.5.x | 渐进式 JavaScript 框架 |
| Element Plus | 2.9.x | UI 组件库 |
| Pinia | 3.0.x | 状态管理 |
| Vue Router | 4.5.x | 路由管理 |
| Vite | 6.3.x | 构建工具 |
| ECharts | 5.6.x | 数据可视化 |

### 管理后台后端 (Campus_notice Backed)

| 技术 | 版本 | 说明 |
|------|------|------|
| Spring Boot | 3.3.x | 应用框架 |
| 若依框架 | 3.9.x | 权限管理框架 |
| MyBatis | 3.0.x | ORM 框架 |
| MySQL | 8.x | 关系型数据库 |
| Redis | - | 缓存数据库 |
| Druid | 1.2.x | 数据库连接池 |
| JWT | 0.9.x | Token 认证 |
| Springdoc | 2.6.x | API 文档 |

### 鸿蒙移动端 (Campus_noticeHarmous)

| 技术 | 版本 | 说明 |
|------|------|------|
| HarmonyOS SDK | 6.1.0(23) | 华为鸿蒙系统 SDK |
| ArkTS | - | 声明式开发范式 |
| ArkUI | - | UI 组件框架 |

## 功能模块

### 门户网站

- **首页** - 学校简介、统计数据、最新动态
- **院系设置** - 院系信息展示
- **招生就业** - 招生政策、就业信息
- **科学研究** - 科研成果、学术活动
- **校园生活** - 社团活动、校园设施
- **新闻动态** - 校园新闻、公告通知（支持分类筛选、关键词搜索、分页）

### 管理后台

- **系统管理** - 用户、角色、菜单、部门管理
- **公告管理** - 公告发布、审核、分类管理
- **新闻管理** - 新闻发布、编辑、审核
- **系统监控** - 在线用户、操作日志、服务器监控
- **定时任务** - 任务调度管理

### 鸿蒙移动端

- **校园门户** - 首页、院系、招生、科研、生活
- **公告查询** - 分类筛选、关键词搜索
- **数据可视化** - 公告分布统计（饼图）
- **个人中心** - 收藏、历史、设置

## 数据库设计

### 核心数据表

| 表名 | 说明 |
|------|------|
| tb_announcement | 公告表 |
| tb_category | 公告分类表 |
| tb_attachment | 附件表 |
| tb_push_record | 推送记录表 |
| tb_announcement_read | 阅读记录表 |

### 公告状态流转

```
草稿(DRAFT) → 待审核(PENDING) → 已发布(PUBLISHED)
                    ↓
               已驳回(REJECTED)
```

## API 接口

### 门户网站 API

| 接口 | 方法 | 说明 |
|------|------|------|
| `/api/home` | GET | 获取首页数据 |
| `/api/news` | GET | 获取新闻列表（分页） |
| `/api/news/{id}` | GET | 获取新闻详情 |
| `/api/stats` | GET | 获取统计数据 |
| `/api/nav-links` | GET | 获取导航链接 |
| `/api/school-info` | GET | 获取学校信息 |

### 新闻查询参数

```
GET /api/news?page=1&size=10&category=NOTICE&keyword=开学
```

| 参数 | 说明 |
|------|------|
| page | 页码（默认 1） |
| size | 每页数量（默认 10） |
| category | 分类（NOTICE/ADMIN/ACADEMIC/HONOR） |
| keyword | 搜索关键词 |

## 快速开始

### 环境要求

- JDK 17+
- Node.js 18+
- MySQL 8.0+
- Redis 6.0+
- DevEco Studio 4.0+（鸿蒙开发）

### 数据库配置

1. 创建数据库

```sql
CREATE DATABASE school_notice DEFAULT CHARACTER SET utf8mb4;
CREATE DATABASE ry_campus DEFAULT CHARACTER SET utf8mb4;
```

2. 导入 SQL 脚本

```bash
# 管理后台数据库
mysql -u root -p ry_campus < Campus_notice Backed/springboot3-ry-cafuc-master/sql/ry_20250522.sql
mysql -u root -p ry_campus < Campus_notice Backed/springboot3-ry-cafuc-master/ruoyi-admin/src/main/resources/sql/campus_announcement.sql

# 门户网站数据库
mysql -u root -p school_notice < Campus_notice Web Backed/src/main/resources/campus.sql
```

### 后端启动

1. 管理后台后端

```bash
cd "Campus_notice Backed/springboot3-ry-cafuc-master"

# 修改数据库配置
# 编辑 ruoyi-admin/src/main/resources/application-druid.yml

# 启动
mvn spring-boot:run -pl ruoyi-admin
```

2. 门户网站后端

```bash
cd "Campus_notice Web Backed"

# 修改数据库配置
# 编辑 src/main/resources/application.properties

# 启动
./mvnw spring-boot:run
```

### 前端启动

1. 门户网站前端

```bash
cd "Campus_notice Web"

npm install
npm run dev
```

访问地址：http://localhost:5173

2. 管理后台前端

```bash
cd "Campus_notice Administratice End"

npm install
npm run dev
```

访问地址：http://localhost:80

默认管理员账号：`admin` / `admin123`

### 鸿蒙应用启动

1. 使用 DevEco Studio 打开项目

```bash
DevEco Studio → Open → Campus_noticeHarmous/notice
```

2. 配置签名并运行

## 项目截图

### 门户网站

- 首页展示学校概况、统计数据、最新动态
- 新闻动态页支持分类筛选、关键词搜索、分页浏览
- 响应式设计，适配桌面和移动端

### 管理后台

- 基于 RBAC 权限模型
- 公告发布支持富文本编辑
- 公告审核流程可视化

### 鸿蒙移动端

- 校园门户风格统一
- 公告分布数据可视化
- 支持下拉刷新

## 开发规范

### 代码规范

- 后端遵循阿里巴巴 Java 开发手册
- 前端遵循 Vue 官方风格指南
- ArkTS 遵循鸿蒙开发规范

### 分支管理

- `main` - 生产分支
- `develop` - 开发分支
- `feature/*` - 功能分支

## 技术亮点

1. **前后端分离架构** - Vue 3 + Spring Boot，接口统一规范
2. **权限管理** - 基于若依框架的 RBAC 权限控制
3. **多端适配** - Web 门户 + 管理后台 + 鸿蒙 App
4. **数据可视化** - ECharts + Canvas 实现公告分布统计
5. **响应式设计** - Tailwind CSS 实现多设备适配
6. **搜索优化** - 支持分类筛选 + 关键词搜索组合查询

## 许可证

MIT License

## 联系方式

如有问题或建议，请提交 Issue 或 Pull Request。
