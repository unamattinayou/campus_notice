package net.biancheng.schoolbbs.service;

import net.biancheng.schoolbbs.bean.OperationLog;

public interface OperationLogService {

    /**
     * 记录操作日志
     */
    void saveLog(OperationLog operationLog);
}