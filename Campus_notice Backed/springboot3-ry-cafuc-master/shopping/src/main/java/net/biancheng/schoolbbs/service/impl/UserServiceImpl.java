package net.biancheng.schoolbbs.service.impl;

import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.bean.User;
import net.biancheng.schoolbbs.mapper.UserMapper;
import net.biancheng.schoolbbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    // ==================== 原有方法保持不变 ====================

    @Override
    public Result login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return Result.error("用户名或密码错误");
        }
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes(StandardCharsets.UTF_8));
        if (!md5Password.equals(user.getPassword())) {
            return Result.error("用户名或密码错误");
        }
        String token = UUID.randomUUID().toString().replace("-", "");
        Map<String, Object> userMap = new HashMap<>();
        userMap.put("id", user.getId());
        userMap.put("username", user.getUsername());
        userMap.put("realName", user.getRealName());
        userMap.put("role", user.getRole());
        userMap.put("department", user.getDepartment());
        redisTemplate.opsForHash().putAll("user:token:" + token, userMap);
        redisTemplate.expire("user:token:" + token, 24, TimeUnit.HOURS);
        Map<String, Object> result = new HashMap<>();
        result.put("token", token);
        result.put("userInfo", userMap);
        return Result.success("登录成功", result);
    }

    @Override
    public User getUserByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public User getUserById(Long id) {
        return userMapper.selectById(id);
    }

    // ==================== 新增方法 ====================

    @Override
    public Result getUserList(Integer pageNum, Integer pageSize, String username, String role) {
        Page<User> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        if (username != null && !username.trim().isEmpty()) {
            wrapper.like(User::getUsername, username);
        }
        if (role != null && !role.trim().isEmpty()) {
            wrapper.eq(User::getRole, role);
        }
        wrapper.orderByDesc(User::getCreateTime);

        Page<User> result = userMapper.selectPage(page, wrapper);

        // 清除密码
        result.getRecords().forEach(u -> u.setPassword(null));

        Map<String, Object> data = new HashMap<>();
        data.put("rows", result.getRecords());
        data.put("total", result.getTotal());

        return Result.success(data);
    }

    @Override
    public Result addUser(User user) {
        // 校验用户名是否已存在
        User existing = userMapper.selectByUsername(user.getUsername());
        if (existing != null) {
            return Result.error("用户名已存在");
        }

        // 密码MD5加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes(StandardCharsets.UTF_8)));
        } else {
            return Result.error("密码不能为空");
        }

        userMapper.insert(user);
        return Result.success("新增成功", null);
    }

    @Override
    public Result updateUser(User user) {
        if (user.getId() == null) {
            return Result.error("用户ID不能为空");
        }

        User existing = userMapper.selectById(user.getId());
        if (existing == null) {
            return Result.error("用户不存在");
        }

        // 如果传了密码且与新密码不同，则加密；否则不更新密码
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String md5Password = DigestUtils.md5DigestAsHex(user.getPassword().getBytes(StandardCharsets.UTF_8));
            if (!md5Password.equals(existing.getPassword())) {
                user.setPassword(md5Password);
            }
        } else {
            // 不更新密码，保持原密码
            user.setPassword(existing.getPassword());
        }

        userMapper.updateById(user);
        return Result.success("修改成功", null);
    }

    @Override
    public Result deleteUser(Long userId) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        userMapper.deleteById(userId);
        return Result.success("删除成功", null);
    }
}
