package com.ruoyi.web.controller.campus;

import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginBody;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.web.service.SysLoginService;
import com.ruoyi.framework.web.service.SysPermissionService;
import com.ruoyi.framework.web.service.TokenService;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/auth")
public class AuthController extends BaseController
{
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private SysPermissionService permissionService;

    @Anonymous
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(),
                loginBody.getCode(), loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    @PostMapping("/logout")
    public AjaxResult logout(HttpServletRequest request)
    {
        LoginUser loginUser = tokenService.getLoginUser(request);
        if (loginUser != null)
        {
            tokenService.delLoginUser(loginUser.getToken());
        }
        return success("退出成功");
    }

    @GetMapping("/info")
    public AjaxResult info()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        Set<String> roles = permissionService.getRolePermission(user);
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    @Anonymous
    @GetMapping("/health")
    public AjaxResult health()
    {
        return success("ok");
    }
}
