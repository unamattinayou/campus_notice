package com.ruoyi.web.controller.campus;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.campus.PushRecord;
import com.ruoyi.system.service.campus.IPushRecordService;

@RestController
@RequestMapping("/api/push")
public class PushController extends BaseController
{
    @Autowired
    private IPushRecordService pushRecordService;

    @GetMapping("/notifications")
    public TableDataInfo notifications()
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        List<PushRecord> list = pushRecordService.selectPushRecordsByUserId(userId);
        return getDataTable(list);
    }

    @PutMapping("/{id}/read")
    public AjaxResult markRead(@PathVariable Long id)
    {
        return toAjax(pushRecordService.updateReadStatus(id, 1));
    }

    @GetMapping("/unread-count")
    public AjaxResult unreadCount()
    {
        Long userId = SecurityUtils.getUserId();
        int count = pushRecordService.countUnreadByUserId(userId);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("count", count);
        return ajax;
    }
}
