package com.ruoyi.system.domain.campus;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 公告实体 tb_announcement
 *
 * @author ruoyi
 */
public class Announcement extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private String title;

    private String content;

    private String summary;

    private Long categoryId;

    private Integer status;

    private Long publisherId;

    private String publisherName;

    private Long reviewerId;

    private String reviewComment;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date publishTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date expireTime;

    private Integer isTop;

    private Integer viewCount;

    private Integer deleted;

    /** 分类名称（非数据库字段，联表查询） */
    private String categoryName;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getSummary()
    {
        return summary;
    }

    public void setSummary(String summary)
    {
        this.summary = summary;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Long getPublisherId()
    {
        return publisherId;
    }

    public void setPublisherId(Long publisherId)
    {
        this.publisherId = publisherId;
    }

    public String getPublisherName()
    {
        return publisherName;
    }

    public void setPublisherName(String publisherName)
    {
        this.publisherName = publisherName;
    }

    public Long getReviewerId()
    {
        return reviewerId;
    }

    public void setReviewerId(Long reviewerId)
    {
        this.reviewerId = reviewerId;
    }

    public String getReviewComment()
    {
        return reviewComment;
    }

    public void setReviewComment(String reviewComment)
    {
        this.reviewComment = reviewComment;
    }

    public Date getPublishTime()
    {
        return publishTime;
    }

    public void setPublishTime(Date publishTime)
    {
        this.publishTime = publishTime;
    }

    public Date getExpireTime()
    {
        return expireTime;
    }

    public void setExpireTime(Date expireTime)
    {
        this.expireTime = expireTime;
    }

    public Integer getIsTop()
    {
        return isTop;
    }

    public void setIsTop(Integer isTop)
    {
        this.isTop = isTop;
    }

    public Integer getViewCount()
    {
        return viewCount;
    }

    public void setViewCount(Integer viewCount)
    {
        this.viewCount = viewCount;
    }

    public Integer getDeleted()
    {
        return deleted;
    }

    public void setDeleted(Integer deleted)
    {
        this.deleted = deleted;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }
}