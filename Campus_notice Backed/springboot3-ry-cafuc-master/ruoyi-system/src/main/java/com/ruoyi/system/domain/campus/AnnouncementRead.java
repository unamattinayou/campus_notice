package com.ruoyi.system.domain.campus;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 公告阅读记录实体 tb_announcement_read
 *
 * @author ruoyi
 */
public class AnnouncementRead extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long announcementId;

    private Long userId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date readTime;

    private Integer deleted;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getAnnouncementId()
    {
        return announcementId;
    }

    public void setAnnouncementId(Long announcementId)
    {
        this.announcementId = announcementId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Date getReadTime()
    {
        return readTime;
    }

    public void setReadTime(Date readTime)
    {
        this.readTime = readTime;
    }

    public Integer getDeleted()
    {
        return deleted;
    }

    public void setDeleted(Integer deleted)
    {
        this.deleted = deleted;
    }
}