package com.ruoyi.system.service.campus;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.campus.Announcement;

public interface IAnnouncementService
{
    List<Announcement> selectAnnouncementList(Announcement announcement);
    Announcement selectAnnouncementById(Long id);
    int insertAnnouncement(Announcement announcement);
    int updateAnnouncement(Announcement announcement);
    int deleteAnnouncementById(Long id);
    int submitForReview(Long id);
    int reviewAnnouncement(Long id, Integer status, Long reviewerId, String reviewComment);
    void recordRead(Long announcementId, Long userId);
    Map<String, Object> selectOverviewStats();
    List<Map<String, Object>> selectCategoryDistribution();
    List<Map<String, Object>> selectPublishTrend(int days);
}
