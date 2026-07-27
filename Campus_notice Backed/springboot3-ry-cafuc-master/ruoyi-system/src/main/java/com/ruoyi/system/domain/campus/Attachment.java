package com.ruoyi.system.domain.campus;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 附件实体 tb_attachment
 *
 * @author ruoyi
 */
public class Attachment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long announcementId;

    private String fileName;

    private String filePath;

    private Long fileSize;

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

    public String getFileName()
    {
        return fileName;
    }

    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

    public String getFilePath()
    {
        return filePath;
    }

    public void setFilePath(String filePath)
    {
        this.filePath = filePath;
    }

    public Long getFileSize()
    {
        return fileSize;
    }

    public void setFileSize(Long fileSize)
    {
        this.fileSize = fileSize;
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