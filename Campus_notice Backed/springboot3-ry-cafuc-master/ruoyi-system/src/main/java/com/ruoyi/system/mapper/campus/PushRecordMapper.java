package com.ruoyi.system.mapper.campus;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.campus.PushRecord;

public interface PushRecordMapper
{
    int insertPushRecord(PushRecord pushRecord);
    int batchInsertPushRecords(@Param("list") List<PushRecord> list);
    List<PushRecord> selectPushRecordsByUserId(Long userId);
    int updateReadStatus(@Param("id") Long id, @Param("isRead") Integer isRead);
    int countUnreadByUserId(Long userId);
}
