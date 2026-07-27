package net.biancheng.campusspringboot.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "tb_notice")
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "summary", length = 500)
    private String summary;

    @Column(name = "category", length = 50)
    private String category;

    @Column(name = "publish_time")
    private LocalDateTime publishDate;

    @Column(name = "create_time")
    private LocalDateTime createdAt;

    @Column(name = "update_time")
    private LocalDateTime updatedAt;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @Column(name = "status", length = 20)
    private String status;

    @Column(name = "is_deleted")
    private Integer isDeleted;

    @Column(name = "is_top")
    private Integer isTop;

    @Column(name = "view_count")
    private Integer viewCount;
}