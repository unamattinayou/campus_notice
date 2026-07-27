package net.biancheng.schoolbbs.service;

import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.bean.User;

public interface UserService {

    /**
     * 用户登录
     */
    Result login(String username, String password);

    /**
     * 根据用户名获取用户信息
     */
    User getUserByUsername(String username);

    /**
     * 根据ID获取用户信息
     */
    User getUserById(Long id);

    /**
     * 分页查询用户列表
     */
    Result getUserList(Integer pageNum, Integer pageSize, String username, String role);

    /**
     * 新增用户
     */
    Result addUser(User user);

    /**
     * 修改用户
     */
    Result updateUser(User user);

    /**
     * 删除用户（逻辑删除）
     */
    Result deleteUser(Long userId);
}
