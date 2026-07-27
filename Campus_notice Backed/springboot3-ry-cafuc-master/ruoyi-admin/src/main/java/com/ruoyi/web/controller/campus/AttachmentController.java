package com.ruoyi.web.controller.campus;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.campus.Attachment;
import com.ruoyi.system.service.campus.IAttachmentService;

@RestController
@RequestMapping("/api/attachments")
public class AttachmentController extends BaseController
{
    @Autowired
    private IAttachmentService attachmentService;

    private static final String UPLOAD_DIR = "D:/ruoyi/uploadPath/attachments/";

    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file,
                             @RequestParam(value = "announcementId", required = false) Long announcementId)
    {
        if (file.isEmpty())
        {
            return error("上传文件不能为空");
        }
        try
        {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath))
            {
                Files.createDirectories(uploadPath);
            }
            String originalName = file.getOriginalFilename();
            String suffix = originalName != null && originalName.contains(".") ?
                originalName.substring(originalName.lastIndexOf(".")) : "";
            String storedName = UUID.randomUUID().toString() + suffix;
            Path destPath = uploadPath.resolve(storedName);
            file.transferTo(destPath.toFile());

            Attachment attachment = new Attachment();
            attachment.setAnnouncementId(announcementId);
            attachment.setFileName(originalName);
            attachment.setFilePath(storedName);
            attachment.setFileSize(file.getSize());
            attachmentService.insertAttachment(attachment);

            AjaxResult ajax = AjaxResult.success("上传成功");
            ajax.put("attachment", attachment);
            return ajax;
        }
        catch (IOException e)
        {
            logger.error("文件上传失败", e);
            return error("文件上传失败");
        }
    }

    @GetMapping("/{id}")
    public void download(@PathVariable Long id, HttpServletResponse response)
    {
        Attachment attachment = attachmentService.selectAttachmentById(id);
        if (attachment == null)
        {
            return;
        }
        File file = new File(UPLOAD_DIR + attachment.getFilePath());
        if (!file.exists())
        {
            return;
        }
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream())
        {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition",
                "attachment; filename=" + URLEncoder.encode(attachment.getFileName(), StandardCharsets.UTF_8));
            byte[] buffer = new byte[4096];
            int len;
            while ((len = fis.read(buffer)) > 0)
            {
                os.write(buffer, 0, len);
            }
            os.flush();
        }
        catch (IOException e)
        {
            logger.error("文件下载失败", e);
        }
    }
}
