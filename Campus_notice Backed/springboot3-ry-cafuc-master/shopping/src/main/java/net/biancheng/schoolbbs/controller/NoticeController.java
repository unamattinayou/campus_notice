package net.biancheng.schoolbbs.controller;

import net.biancheng.schoolbbs.bean.Notice;
import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 发布公告（管理员）
     */
    @PostMapping("/publish")
    public Result publishNotice(@RequestBody Notice notice,
                                @RequestParam Long userId) {
        return noticeService.publishNotice(notice, userId);
    }

    /**
     * 更新公告（管理员）
     */
    @PutMapping("/update")
    public Result updateNotice(@RequestBody Notice notice,
                               @RequestParam Long userId) {
        return noticeService.updateNotice(notice, userId);
    }

    /**
     * 删除公告（管理员）
     */
    @DeleteMapping("/delete/{noticeId}")
    public Result deleteNotice(@PathVariable Long noticeId,
                               @RequestParam Long userId) {
        return noticeService.deleteNotice(noticeId, userId);
    }

    /**
     * 撤回公告（管理员）
     */
    @PutMapping("/revoke/{noticeId}")
    public Result revokeNotice(@PathVariable Long noticeId,
                               @RequestParam Long userId) {
        return noticeService.revokeNotice(noticeId, userId);
    }

    /**
     * 获取已发布公告列表（师生端）
     */
    @GetMapping("/published")
    public Result getPublishedNotices() {
        return noticeService.getPublishedNotices();
    }

    /**
     * 搜索公告
     */
    @GetMapping("/search")
    public Result searchNotices(@RequestParam(required = false) String keyword,
                                @RequestParam(required = false) String category,
                                @RequestParam(defaultValue = "1") Integer pageNum,
                                @RequestParam(defaultValue = "5") Integer pageSize) {
        return noticeService.searchNotices(keyword, category);
    }

//    @GetMapping("/search")
//    public Result searchNotices(@RequestParam(required = false) String keyword,
//                                @RequestParam(required = false) String category,
//                                @RequestParam(defaultValue = "1") Integer pageNum,
//                                @RequestParam(defaultValue = "5") Integer pageSize)
    /**
     * 获取公告详情
     */
    @GetMapping("/detail/{noticeId}")
    public Result getNoticeDetail(@PathVariable Long noticeId) {
        return noticeService.getNoticeDetail(noticeId);
    }

    /**
     * 获取所有公告（管理员）
     */
    @GetMapping("/all")
    public Result getAllNotices() {
        return noticeService.getAllNotices();
    }
}