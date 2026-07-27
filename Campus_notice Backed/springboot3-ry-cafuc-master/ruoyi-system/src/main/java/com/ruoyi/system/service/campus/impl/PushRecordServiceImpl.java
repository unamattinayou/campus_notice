package com.ruoyi.system.service.campus.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.campus.PushRecord;
import com.ruoyi.system.mapper.campus.PushRecordMapper;
import com.ruoyi.system.service.campus.IPushRecordService;

@Service
public class PushRecordServiceImpl implements IPushRecordService
{
    @Autowired
    private PushRecordMapper pushRecordMapper;

    @Override
    public int insertPushRecord(PushRecord pushRecord)
    {
        return pushRecordMapper.insertPushRecord(pushRecord);
    }

    @Override
    public int batchInsertPushRecords(List<PushRecord> list)
    {
        return pushRecordMapper.batchInsertPushRecords(list);
    }

    @Override
    public List<PushRecord> selectPushRecordsByUserId(Long userId)
    {
        return pushRecordMapper.selectPushRecordsByUserId(userId);
    }

    @Override
    public int updateReadStatus(Long id, Integer isRead)
    {
        return pushRecordMapper.updateReadStatus(id, isRead);
    }

    @Override
    public int countUnreadByUserId(Long userId)
    {
        return pushRecordMapper.countUnreadByUserId(userId);
    }
}
