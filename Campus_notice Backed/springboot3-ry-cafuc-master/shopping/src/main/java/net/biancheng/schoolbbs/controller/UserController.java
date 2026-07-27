package net.biancheng.schoolbbs.controller;

import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.bean.User;
import net.biancheng.schoolbbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户分页列表（支持按用户名和角色搜索）
     */
    @GetMapping("/list")
    public Result list(@RequestParam(defaultValue = "1") Integer pageNum,
                       @RequestParam(defaultValue = "10") Integer pageSize,
                       @RequestParam(required = false) String username,
                       @RequestParam(required = false) String role) {
        return userService.getUserList(pageNum, pageSize, username, role);
    }

    /**
     * 获取用户详情
     */
    @GetMapping("/{userId}")
    public Result detail(@PathVariable Long userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        // 不返回密码
        user.setPassword(null);
        return Result.success(user);
    }

    /**
     * 新增用户
     */
    @PostMapping
    public Result add(@RequestBody User user) {
        return userService.addUser(user);
    }

    /**
     * 修改用户
     */
    @PutMapping
    public Result update(@RequestBody User user) {
        return userService.updateUser(user);
    }

    /**
     * 删除用户（逻辑删除）
     */
    @DeleteMapping("/{userId}")
    public Result delete(@PathVariable Long userId) {
        return userService.deleteUser(userId);
    }
}
