package com.ruoyi.system.service.campus;

import java.util.List;
import com.ruoyi.system.domain.campus.PushRecord;

public interface IPushRecordService
{
    int insertPushRecord(PushRecord pushRecord);
    int batchInsertPushRecords(List<PushRecord> list);
    List<PushRecord> selectPushRecordsByUserId(Long userId);
    int updateReadStatus(Long id, Integer isRead);
    int countUnreadByUserId(Long userId);
}
