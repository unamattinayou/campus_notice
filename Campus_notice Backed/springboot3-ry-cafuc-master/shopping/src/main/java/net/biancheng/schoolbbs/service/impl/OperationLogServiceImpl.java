package net.biancheng.schoolbbs.service.impl;

import net.biancheng.schoolbbs.bean.OperationLog;
import net.biancheng.schoolbbs.mapper.OperationLogMapper;
import net.biancheng.schoolbbs.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OperationLogServiceImpl implements OperationLogService {

    @Autowired
    private OperationLogMapper operationLogMapper;

    @Override
    public void saveLog(OperationLog operationLog) {
        operationLogMapper.insert(operationLog);
    }
}