package com.ruoyi.system.service.campus.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.campus.Announcement;
import com.ruoyi.system.domain.campus.AnnouncementRead;
import com.ruoyi.system.domain.campus.PushRecord;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.mapper.campus.AnnouncementMapper;
import com.ruoyi.system.mapper.campus.AnnouncementReadMapper;
import com.ruoyi.system.mapper.campus.PushRecordMapper;
import com.ruoyi.system.service.campus.IAnnouncementService;

@Service
public class AnnouncementServiceImpl implements IAnnouncementService
{
    @Autowired
    private AnnouncementMapper announcementMapper;

    @Autowired
    private AnnouncementReadMapper announcementReadMapper;

    @Autowired
    private PushRecordMapper pushRecordMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public List<Announcement> selectAnnouncementList(Announcement announcement)
    {
        return announcementMapper.selectAnnouncementList(announcement);
    }

    @Override
    public Announcement selectAnnouncementById(Long id)
    {
        return announcementMapper.selectAnnouncementById(id);
    }

    @Override
    public int insertAnnouncement(Announcement announcement)
    {
        return announcementMapper.insertAnnouncement(announcement);
    }

    @Override
    public int updateAnnouncement(Announcement announcement)
    {
        return announcementMapper.updateAnnouncement(announcement);
    }

    @Override
    public int deleteAnnouncementById(Long id)
    {
        return announcementMapper.deleteAnnouncementById(id);
    }

    @Override
    public int submitForReview(Long id)
    {
        Announcement announcement = new Announcement();
        announcement.setId(id);
        announcement.setStatus(1);
        return announcementMapper.updateAnnouncement(announcement);
    }

    @Override
    @Transactional
    public int reviewAnnouncement(Long id, Integer status, Long reviewerId, String reviewComment)
    {
        int rows = announcementMapper.updateStatus(id, status, reviewerId, reviewComment);
        if (status == 2)
        {
            Announcement announcement = announcementMapper.selectAnnouncementById(id);
            SysUser searchUser = new SysUser();
            searchUser.setStatus("0");
            List<SysUser> users = sysUserMapper.selectUserList(searchUser);
            if (users != null && !users.isEmpty())
            {
                List<PushRecord> records = new ArrayList<>();
                for (SysUser user : users)
                {
                    if (announcement.getPublisherId() != null && announcement.getPublisherId().equals(user.getUserId()))
                    {
                        continue;
                    }
                    PushRecord record = new PushRecord();
                    record.setAnnouncementId(id);
                    record.setTargetUserId(user.getUserId());
                    record.setIsRead(0);
                    records.add(record);
                }
                if (!records.isEmpty())
                {
                    pushRecordMapper.batchInsertPushRecords(records);
                }
            }
        }
        return rows;
    }

    @Override
    public void recordRead(Long announcementId, Long userId)
    {
        AnnouncementRead exist = announcementReadMapper.selectByAnnouncementIdAndUserId(announcementId, userId);
        if (exist == null)
        {
            AnnouncementRead read = new AnnouncementRead();
            read.setAnnouncementId(announcementId);
            read.setUserId(userId);
            read.setReadTime(new Date());
            announcementReadMapper.insertAnnouncementRead(read);
            announcementMapper.incrementViewCount(announcementId);
        }
    }

    @Override
    public Map<String, Object> selectOverviewStats()
    {
        return announcementMapper.selectOverviewStats();
    }

    @Override
    public List<Map<String, Object>> selectCategoryDistribution()
    {
        return announcementMapper.selectCategoryDistribution();
    }

    @Override
    public List<Map<String, Object>> selectPublishTrend(int days)
    {
        return announcementMapper.selectPublishTrend(days);
    }
}
