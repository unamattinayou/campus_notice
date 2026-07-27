package net.biancheng.schoolbbs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import net.biancheng.schoolbbs.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper extends BaseMapper<User> {

    @Select("SELECT * FROM tb_user WHERE username = #{username} AND is_deleted = 0")
    User selectByUsername(@Param("username") String username);
}