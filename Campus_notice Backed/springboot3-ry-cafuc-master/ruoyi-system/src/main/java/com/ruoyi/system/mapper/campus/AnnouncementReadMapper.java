package com.ruoyi.system.mapper.campus;

import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.campus.AnnouncementRead;

public interface AnnouncementReadMapper
{
    int insertAnnouncementRead(AnnouncementRead announcementRead);
    AnnouncementRead selectByAnnouncementIdAndUserId(@Param("announcementId") Long announcementId,
                                                      @Param("userId") Long userId);
}
