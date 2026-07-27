package com.ruoyi.system.service.campus;

import com.ruoyi.system.domain.campus.AnnouncementRead;

public interface IAnnouncementReadService
{
    int insertAnnouncementRead(AnnouncementRead announcementRead);
    AnnouncementRead selectByAnnouncementIdAndUserId(Long announcementId, Long userId);
}
