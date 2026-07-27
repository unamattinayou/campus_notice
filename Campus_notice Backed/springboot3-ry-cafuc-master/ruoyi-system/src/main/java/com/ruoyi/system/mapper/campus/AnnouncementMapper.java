package com.ruoyi.system.mapper.campus;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.campus.Announcement;

public interface AnnouncementMapper
{
    List<Announcement> selectAnnouncementList(Announcement announcement);
    Announcement selectAnnouncementById(Long id);
    int insertAnnouncement(Announcement announcement);
    int updateAnnouncement(Announcement announcement);
    int deleteAnnouncementById(Long id);
    int updateStatus(@Param("id") Long id, @Param("status") Integer status,
                     @Param("reviewerId") Long reviewerId, @Param("reviewComment") String reviewComment);
    int incrementViewCount(Long id);
    Map<String, Object> selectOverviewStats();
    List<Map<String, Object>> selectCategoryDistribution();
    List<Map<String, Object>> selectPublishTrend(@Param("days") int days);
}
