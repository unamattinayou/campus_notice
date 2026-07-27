package net.biancheng.schoolbbs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import net.biancheng.schoolbbs.bean.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface NoticeMapper extends BaseMapper<Notice> {

    @Select("SELECT * FROM tb_notice WHERE is_deleted = 0 ORDER BY is_top DESC, publish_time DESC")
    List<Notice> selectAllPublished();

    @Select("SELECT * FROM tb_notice WHERE is_deleted = 0 AND status = 'PUBLISHED' ORDER BY is_top DESC, publish_time DESC")
    List<Notice> selectPublishedNotices();

    @Select("<script>" +
            "SELECT * FROM tb_notice WHERE is_deleted = 0 AND status = 'PUBLISHED'" +
            "<if test='keyword != null and keyword != \"\"'>" +
            "AND (title LIKE CONCAT('%',#{keyword},'%') OR content LIKE CONCAT('%',#{keyword},'%'))" +
            "</if>" +
            "<if test='category != null and category != \"\"'>" +
            "AND category = #{category}" +
            "</if>" +
            "ORDER BY is_top DESC, publish_time DESC" +
            "</script>")
    List<Notice> searchNotices(@Param("keyword") String keyword, @Param("category") String category);

    @Update("UPDATE tb_notice SET view_count = view_count + 1 WHERE id = #{id}")
    int incrementViewCount(@Param("id") Long id);
}