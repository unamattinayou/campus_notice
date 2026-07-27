package net.biancheng.schoolbbs.controller;

import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     * 用户登录
     */
    @PostMapping("/login")
    public Result login(@RequestBody Map<String, String> loginInfo) {
        String username = loginInfo.get("username");
        String password = loginInfo.get("password");

        if (username == null || password == null) {
            return Result.error("用户名和密码不能为空");
        }

        return userService.login(username, password);
    }

    /**
     * 退出登录
     */
    @PostMapping("/logout")
    public Result logout(@RequestHeader("Authorization") String token) {
        // 实际项目中需要清除Redis中的token
        return Result.success("退出成功", null);
    }
}