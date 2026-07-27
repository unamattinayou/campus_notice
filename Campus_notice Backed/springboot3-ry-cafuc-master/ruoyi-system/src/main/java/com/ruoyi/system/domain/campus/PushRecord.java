package com.ruoyi.system.domain.campus;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 推送记录实体 tb_push_record
 *
 * @author ruoyi
 */
public class PushRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long announcementId;

    private Long targetUserId;

    private Integer isRead;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date readTime;

    private Integer deleted;

    /** 公告标题（非数据库字段） */
    private String announcementTitle;

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

    public Long getTargetUserId()
    {
        return targetUserId;
    }

    public void setTargetUserId(Long targetUserId)
    {
        this.targetUserId = targetUserId;
    }

    public Integer getIsRead()
    {
        return isRead;
    }

    public void setIsRead(Integer isRead)
    {
        this.isRead = isRead;
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

    public String getAnnouncementTitle()
    {
        return announcementTitle;
    }

    public void setAnnouncementTitle(String announcementTitle)
    {
        this.announcementTitle = announcementTitle;
    }
}