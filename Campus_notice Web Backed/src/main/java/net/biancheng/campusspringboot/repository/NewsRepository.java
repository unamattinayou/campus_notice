package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.News;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 ORDER BY n.isTop DESC, n.publishDate DESC")
    List<News> findAllPublishedOrderByTopAndPublishDateDesc();

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 ORDER BY n.isTop DESC, n.publishDate DESC")
    Page<News> findAllPublishedOrderByTopAndPublishDateDesc(Pageable pageable);

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 AND n.category = :category ORDER BY n.isTop DESC, n.publishDate DESC")
    Page<News> findByCategoryPublished(@Param("category") String category, Pageable pageable);

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 AND (n.title LIKE %:keyword% OR n.summary LIKE %:keyword%) ORDER BY n.isTop DESC, n.publishDate DESC")
    Page<News> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 AND n.category = :category AND (n.title LIKE %:keyword% OR n.summary LIKE %:keyword%) ORDER BY n.isTop DESC, n.publishDate DESC")
    Page<News> searchByKeywordAndCategory(@Param("keyword") String keyword, @Param("category") String category, Pageable pageable);
}