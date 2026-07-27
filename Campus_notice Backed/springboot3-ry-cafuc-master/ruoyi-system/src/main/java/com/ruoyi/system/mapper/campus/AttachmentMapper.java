package com.ruoyi.system.mapper.campus;

import java.util.List;
import com.ruoyi.system.domain.campus.Attachment;

public interface AttachmentMapper
{
    int insertAttachment(Attachment attachment);
    List<Attachment> selectAttachmentsByAnnouncementId(Long announcementId);
    Attachment selectAttachmentById(Long id);
    int deleteAttachmentById(Long id);
}
