package net.biancheng.schoolbbs.bean;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("tb_operation_log")
public class OperationLog {
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 操作用户ID
     */
    private Long userId;

    /**
     * 操作用户名
     */
    private String username;

    /**
     * 操作类型：CREATE-创建, UPDATE-更新, DELETE-删除, VIEW-查看
     */
    private String operationType;

    /**
     * 操作模块
     */
    private String module;

    /**
     * 操作描述
     */
    private String description;

    /**
     * 请求IP
     */
    private String ipAddress;

    /**
     * 请求方法
     */
    private String requestMethod;

    /**
     * 请求参数
     */
    private String requestParams;

    /**
     * 操作结果：SUCCESS-成功, FAIL-失败
     */
    private String result;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}