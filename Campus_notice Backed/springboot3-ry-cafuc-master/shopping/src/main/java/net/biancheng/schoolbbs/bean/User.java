package net.biancheng.schoolbbs.bean;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("user")
public class User {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String username;
    private String password;
    private String realName;

    /**
     * 角色：ADMIN-管理员, STUDENT-学生, TEACHER-教师
     */
    private String role;

    private String phone;
    private String email;
    private String department;

    @TableLogic
    private Integer isDeleted;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}