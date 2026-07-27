package com.ruoyi.system.mapper.campus;

import java.util.List;
import com.ruoyi.system.domain.campus.Category;

public interface CategoryMapper
{
    List<Category> selectCategoryList(Category category);
    Category selectCategoryById(Long id);
    int insertCategory(Category category);
    int updateCategory(Category category);
    int deleteCategoryById(Long id);
    List<Category> selectAllCategories();
}
