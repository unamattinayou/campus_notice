package com.ruoyi.system.service.campus;

import java.util.List;
import com.ruoyi.system.domain.campus.Attachment;

public interface IAttachmentService
{
    Attachment insertAttachment(Attachment attachment);
    List<Attachment> selectAttachmentsByAnnouncementId(Long announcementId);
    Attachment selectAttachmentById(Long id);
    int deleteAttachmentById(Long id);
}
