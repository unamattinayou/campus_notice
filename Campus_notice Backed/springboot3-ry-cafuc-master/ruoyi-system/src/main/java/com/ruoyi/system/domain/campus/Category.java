package com.ruoyi.system.domain.campus;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 分类实体 tb_category
 *
 * @author ruoyi
 */
public class Category extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private String categoryName;

    private Integer sortOrder;

    private Integer deleted;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Integer getDeleted()
    {
        return deleted;
    }

    public void setDeleted(Integer deleted)
    {
        this.deleted = deleted;
    }
}