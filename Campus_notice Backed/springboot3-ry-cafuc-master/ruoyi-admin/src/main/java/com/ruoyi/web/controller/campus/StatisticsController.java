package com.ruoyi.web.controller.campus;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.campus.IAnnouncementService;

@RestController
@RequestMapping("/api/statistics")
public class StatisticsController extends BaseController
{
    @Autowired
    private IAnnouncementService announcementService;

    @GetMapping("/overview")
    public AjaxResult overview()
    {
        Map<String, Object> stats = announcementService.selectOverviewStats();
        return success(stats);
    }

    @GetMapping("/trend")
    public AjaxResult trend()
    {
        List<Map<String, Object>> trend = announcementService.selectPublishTrend(30);
        return success(trend);
    }
}
