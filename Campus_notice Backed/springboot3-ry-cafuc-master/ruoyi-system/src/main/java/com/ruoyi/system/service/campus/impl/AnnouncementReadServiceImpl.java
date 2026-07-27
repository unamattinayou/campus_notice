package com.ruoyi.system.service.campus.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.campus.AnnouncementRead;
import com.ruoyi.system.mapper.campus.AnnouncementReadMapper;
import com.ruoyi.system.service.campus.IAnnouncementReadService;

@Service
public class AnnouncementReadServiceImpl implements IAnnouncementReadService
{
    @Autowired
    private AnnouncementReadMapper announcementReadMapper;

    @Override
    public int insertAnnouncementRead(AnnouncementRead announcementRead)
    {
        return announcementReadMapper.insertAnnouncementRead(announcementRead);
    }

    @Override
    public AnnouncementRead selectByAnnouncementIdAndUserId(Long announcementId, Long userId)
    {
        return announcementReadMapper.selectByAnnouncementIdAndUserId(announcementId, userId);
    }
}
