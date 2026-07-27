package com.ruoyi.web.controller.campus;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.campus.Announcement;
import com.ruoyi.system.domain.campus.Attachment;
import com.ruoyi.system.service.campus.IAnnouncementService;
import com.ruoyi.system.service.campus.IAttachmentService;

@RestController
@RequestMapping("/api/announcements")
public class AnnouncementController extends BaseController
{
    @Autowired
    private IAnnouncementService announcementService;

    @Autowired
    private IAttachmentService attachmentService;

    @GetMapping
    public TableDataInfo list(Announcement announcement)
    {
        startPage();
        announcement.setStatus(2);
        List<Announcement> list = announcementService.selectAnnouncementList(announcement);
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        Announcement announcement = announcementService.selectAnnouncementById(id);
        if (announcement == null)
        {
            return error("公告不存在");
        }
        Long userId = SecurityUtils.getUserId();
        announcementService.recordRead(id, userId);
        List<Attachment> attachments = attachmentService.selectAttachmentsByAnnouncementId(id);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("announcement", announcement);
        ajax.put("attachments", attachments);
        return ajax;
    }

    @PostMapping
    public AjaxResult add(@RequestBody Announcement announcement)
    {
        announcement.setStatus(0);
        announcement.setPublisherId(SecurityUtils.getUserId());
        announcement.setPublisherName(SecurityUtils.getUsername());
        announcement.setCreateBy(SecurityUtils.getUsername());
        announcement.setViewCount(0);
        announcementService.insertAnnouncement(announcement);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("id", announcement.getId());
        return ajax;
    }

    @PutMapping("/{id}")
    public AjaxResult edit(@PathVariable Long id, @RequestBody Announcement announcement)
    {
        announcement.setId(id);
        announcement.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(announcementService.updateAnnouncement(announcement));
    }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(announcementService.deleteAnnouncementById(id));
    }

    @PutMapping("/{id}/submit")
    public AjaxResult submit(@PathVariable Long id)
    {
        return toAjax(announcementService.submitForReview(id));
    }

    @PutMapping("/{id}/review")
    public AjaxResult review(@PathVariable Long id, @RequestBody Announcement announcement)
    {
        Integer status = announcement.getStatus();
        String reviewComment = announcement.getReviewComment();
        Long reviewerId = SecurityUtils.getUserId();
        return toAjax(announcementService.reviewAnnouncement(id, status, reviewerId, reviewComment));
    }

    @GetMapping("/my")
    public TableDataInfo myAnnouncements()
    {
        startPage();
        Announcement announcement = new Announcement();
        announcement.setPublisherId(SecurityUtils.getUserId());
        List<Announcement> list = announcementService.selectAnnouncementList(announcement);
        return getDataTable(list);
    }
}
