package net.biancheng.schoolbbs.bean;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("tb_notice")
public class Notice {
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 公告标题
     */
    private String title;

    /**
     * 公告内容
     */
    private String content;

    /**
     * 公告摘要
     */
    private String summary;

    /**
     * 公告分类：NOTICE-通知公告, NEWS-新闻动态, ACADEMIC-学术活动, ADMIN-行政公告
     */
    private String category;

    /**
     * 优先级：HIGH-高, NORMAL-普通, LOW-低
     */
    private String priority;

    /**
     * 发布状态：DRAFT-草稿, PUBLISHED-已发布, REVOKED-已撤回
     */
    private String status;

    /**
     * 发布人ID
     */
    private Long publisherId;

    /**
     * 发布人姓名
     */
    private String publisherName;

    /**
     * 发布时间
     */
    private LocalDateTime publishTime;

    /**
     * 是否置顶：0-不置顶, 1-置顶
     */
    private Integer isTop;

    /**
     * 浏览次数
     */
    private Integer viewCount;

    /**
     * 附件URL
     */
    private String attachmentUrl;

    @TableLogic
    private Integer isDeleted;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}