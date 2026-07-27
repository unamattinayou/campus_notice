package net.biancheng.schoolbbs.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import net.biancheng.schoolbbs.bean.Notice;
import net.biancheng.schoolbbs.bean.OperationLog;
import net.biancheng.schoolbbs.bean.Result;
import net.biancheng.schoolbbs.bean.User;
import net.biancheng.schoolbbs.mapper.NoticeMapper;
import net.biancheng.schoolbbs.service.NoticeService;
import net.biancheng.schoolbbs.service.OperationLogService;
import net.biancheng.schoolbbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private OperationLogService operationLogService;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    private static final String NOTICE_VIEW_KEY = "notice:view:";

//    @Override
//    @Transactional
//    @CacheEvict(value = "notices", allEntries = true)
//    public Result publishNotice(Notice notice, Long userId) {
//        User user = userService.getUserById(userId);
//        if (user == null) {
//            return Result.error("用户不存在");
//        }
//
//        notice.setPublisherId(userId);
//        notice.setPublisherName(user.getRealName());
//        notice.setPublishTime(LocalDateTime.now());
//        notice.setStatus("PUBLISHED");
//        notice.setViewCount(0);
//
//        int result = noticeMapper.insert(notice);
//        if (result > 0) {
//            // 记录操作日志
//            OperationLog log = new OperationLog();
//            log.setUserId(userId);
//            log.setUsername(user.getUsername());
//            log.setOperationType("CREATE");
//            log.setModule("公告管理");
//            log.setDescription("发布公告：" + notice.getTitle());
//            log.setResult("SUCCESS");
//            operationLogService.saveLog(log);
//
//            return Result.success("发布成功", notice);
//        }
//        return Result.error("发布失败");
//    }

    @Override
    @Transactional
    @CacheEvict(value = "notices", allEntries = true)
    public Result publishNotice(Notice notice, Long userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        notice.setPublisherId(userId);
        notice.setPublisherName(user.getRealName());
        notice.setPublishTime(LocalDateTime.now());
        // 如果前端未指定状态，则默认为待审核
        if (notice.getStatus() == null || notice.getStatus().isEmpty()) {
            notice.setStatus("PENDING_REVIEW");
        }
        notice.setViewCount(0);

        int result = noticeMapper.insert(notice);
        if (result > 0) {
            // 记录操作日志
            OperationLog log = new OperationLog();
            log.setUserId(userId);
            log.setUsername(user.getUsername());
            log.setOperationType("CREATE");
            log.setModule("公告管理");
            log.setDescription("发布公告：" + notice.getTitle());
            log.setResult("SUCCESS");
            operationLogService.saveLog(log);

            return Result.success("发布成功", notice);
        }
        return Result.error("发布失败");
    }


    @Override
    @Transactional
    @CacheEvict(value = "notices", allEntries = true)
    public Result updateNotice(Notice notice, Long userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        Notice existNotice = noticeMapper.selectById(notice.getId());
        if (existNotice == null) {
            return Result.error("公告不存在");
        }

        notice.setUpdateTime(LocalDateTime.now());
        int result = noticeMapper.updateById(notice);
        if (result > 0) {
            // 清除该公告的缓存
            redisTemplate.delete(NOTICE_VIEW_KEY + notice.getId());

            // 记录操作日志
            OperationLog log = new OperationLog();
            log.setUserId(userId);
            log.setUsername(user.getUsername());
            log.setOperationType("UPDATE");
            log.setModule("公告管理");
            log.setDescription("更新公告：" + notice.getTitle());
            log.setResult("SUCCESS");
            operationLogService.saveLog(log);

            return Result.success("更新成功", notice);
        }
        return Result.error("更新失败");
    }

    @Override
    @Transactional
    @CacheEvict(value = "notices", allEntries = true)
    public Result deleteNotice(Long noticeId, Long userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        int result = noticeMapper.deleteById(noticeId);
        if (result > 0) {
            // 清除该公告的缓存
            redisTemplate.delete(NOTICE_VIEW_KEY + noticeId);

            // 记录操作日志
            OperationLog log = new OperationLog();
            log.setUserId(userId);
            log.setUsername(user.getUsername());
            log.setOperationType("DELETE");
            log.setModule("公告管理");
            log.setDescription("删除公告ID：" + noticeId);
            log.setResult("SUCCESS");
            operationLogService.saveLog(log);

            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    @Override
    @Transactional
    @CacheEvict(value = "notices", allEntries = true)
    public Result revokeNotice(Long noticeId, Long userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        Notice notice = noticeMapper.selectById(noticeId);
        if (notice == null) {
            return Result.error("公告不存在");
        }

        notice.setStatus("REVOKED");
        int result = noticeMapper.updateById(notice);
        if (result > 0) {
            // 清除该公告的缓存
            redisTemplate.delete(NOTICE_VIEW_KEY + noticeId);

            // 记录操作日志
            OperationLog log = new OperationLog();
            log.setUserId(userId);
            log.setUsername(user.getUsername());
            log.setOperationType("UPDATE");
            log.setModule("公告管理");
            log.setDescription("撤回公告：" + notice.getTitle());
            log.setResult("SUCCESS");
            operationLogService.saveLog(log);

            return Result.success("撤回成功", null);
        }
        return Result.error("撤回失败");
    }

    @Override
   // @Cacheable(value = "notices", key = "'published'")
    public Result getPublishedNotices() {
        return Result.success(noticeMapper.selectPublishedNotices());
    }

    @Override
    public Result searchNotices(String keyword, String category) {
        return Result.success(noticeMapper.searchNotices(keyword, category));
    }

    @Override
    public Result getNoticeDetail(Long noticeId) {
        // 先从Redis获取浏览次数
        String viewKey = NOTICE_VIEW_KEY + noticeId;
        Integer viewCount = (Integer) redisTemplate.opsForValue().get(viewKey);

        if (viewCount == null) {
            // 从数据库获取
            Notice notice = noticeMapper.selectById(noticeId);
            if (notice != null) {
                viewCount = notice.getViewCount();
                redisTemplate.opsForValue().set(viewKey, viewCount, 1, TimeUnit.HOURS);
            }
        }

        // 异步更新浏览次数（实际生产中可以用消息队列）
        noticeMapper.incrementViewCount(noticeId);
        if (viewCount != null) {
            redisTemplate.opsForValue().increment(viewKey);
        }

        Notice notice = noticeMapper.selectById(noticeId);
        if (notice != null) {
            return Result.success(notice);
        }
        return Result.error("公告不存在");
    }

    @Override
    public Result getAllNotices() {
        LambdaQueryWrapper<Notice> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(Notice::getCreateTime);
        return Result.success(noticeMapper.selectList(wrapper));
    }
}