package com.ruoyi.system.service.campus.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.campus.Attachment;
import com.ruoyi.system.mapper.campus.AttachmentMapper;
import com.ruoyi.system.service.campus.IAttachmentService;

@Service
public class AttachmentServiceImpl implements IAttachmentService
{
    @Autowired
    private AttachmentMapper attachmentMapper;

    @Override
    public Attachment insertAttachment(Attachment attachment)
    {
        attachmentMapper.insertAttachment(attachment);
        return attachment;
    }

    @Override
    public List<Attachment> selectAttachmentsByAnnouncementId(Long announcementId)
    {
        return attachmentMapper.selectAttachmentsByAnnouncementId(announcementId);
    }

    @Override
    public Attachment selectAttachmentById(Long id)
    {
        return attachmentMapper.selectAttachmentById(id);
    }

    @Override
    public int deleteAttachmentById(Long id)
    {
        return attachmentMapper.deleteAttachmentById(id);
    }
}
