package com.ruoyi.system.service.campus;

import java.util.List;
import com.ruoyi.system.domain.campus.Category;

public interface ICategoryService
{
    List<Category> selectCategoryList(Category category);
    Category selectCategoryById(Long id);
    int insertCategory(Category category);
    int updateCategory(Category category);
    int deleteCategoryById(Long id);
    List<Category> selectAllCategories();
}
