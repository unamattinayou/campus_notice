package net.biancheng.schoolbbs.service;

import net.biancheng.schoolbbs.bean.Notice;
import net.biancheng.schoolbbs.bean.Result;

public interface NoticeService {

    /**
     * 发布公告
     */
    Result publishNotice(Notice notice, Long userId);

    /**
     * 更新公告
     */
    Result updateNotice(Notice notice, Long userId);

    /**
     * 删除公告
     */
    Result deleteNotice(Long noticeId, Long userId);

    /**
     * 撤回公告
     */
    Result revokeNotice(Long noticeId, Long userId);

    /**
     * 获取所有已发布公告
     */
    Result getPublishedNotices();

    /**
     * 搜索公告
     */
    Result searchNotices(String keyword, String category);

    /**
     * 获取公告详情
     */
    Result getNoticeDetail(Long noticeId);

    /**
     * 管理员获取所有公告（包含草稿）
     */
    Result getAllNotices();
}