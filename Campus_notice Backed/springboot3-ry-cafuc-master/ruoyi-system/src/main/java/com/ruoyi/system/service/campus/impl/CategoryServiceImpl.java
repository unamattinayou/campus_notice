package com.ruoyi.system.service.campus.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.campus.Category;
import com.ruoyi.system.mapper.campus.CategoryMapper;
import com.ruoyi.system.service.campus.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService
{
    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> selectCategoryList(Category category)
    {
        return categoryMapper.selectCategoryList(category);
    }

    @Override
    public Category selectCategoryById(Long id)
    {
        return categoryMapper.selectCategoryById(id);
    }

    @Override
    public int insertCategory(Category category)
    {
        return categoryMapper.insertCategory(category);
    }

    @Override
    public int updateCategory(Category category)
    {
        return categoryMapper.updateCategory(category);
    }

    @Override
    public int deleteCategoryById(Long id)
    {
        return categoryMapper.deleteCategoryById(id);
    }

    @Override
    public List<Category> selectAllCategories()
    {
        return categoryMapper.selectAllCategories();
    }
}
