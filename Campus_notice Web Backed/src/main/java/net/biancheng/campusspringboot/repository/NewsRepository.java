package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {

    @Query("SELECT n FROM News n WHERE n.status = 'PUBLISHED' AND n.isDeleted = 0 ORDER BY n.isTop DESC, n.publishDate DESC")
    List<News> findAllPublishedOrderByTopAndPublishDateDesc();
}