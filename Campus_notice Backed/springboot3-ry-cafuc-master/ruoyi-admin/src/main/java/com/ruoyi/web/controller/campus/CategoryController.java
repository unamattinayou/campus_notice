package com.ruoyi.web.controller.campus;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.campus.Category;
import com.ruoyi.system.service.campus.ICategoryService;

@RestController
@RequestMapping("/api/categories")
public class CategoryController extends BaseController
{
    @Autowired
    private ICategoryService categoryService;

    @GetMapping
    public AjaxResult list()
    {
        List<Category> list = categoryService.selectAllCategories();
        return success(list);
    }

    @PostMapping
    public AjaxResult add(@RequestBody Category category)
    {
        category.setCreateBy(SecurityUtils.getUsername());
        return toAjax(categoryService.insertCategory(category));
    }

    @PutMapping("/{id}")
    public AjaxResult edit(@PathVariable Long id, @RequestBody Category category)
    {
        category.setId(id);
        category.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(categoryService.updateCategory(category));
    }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(categoryService.deleteCategoryById(id));
    }
}
