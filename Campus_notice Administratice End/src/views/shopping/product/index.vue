<template>
  <!-- 搜索区域：按标题title检索 -->
  <el-row :gutter="20" class="mb-4">
    <el-col :span="5">
      <el-input v-model="titleKey" style="width: 240px" placeholder="请输入公告标题搜索" clearable />
    </el-col>
    <el-col :span="2">
      <el-button plain @click="loadData">查询</el-button>
    </el-col>
    <el-col :span="15"></el-col>
    <el-col :span="2">
      <el-button type="primary" @click="openAddDialog">新增公告</el-button>
    </el-col>
  </el-row>

  <!-- 空数据提示 -->
  <div v-if="tableData.length === 0" class="text-center py-10 text-gray-500 text-lg">
    暂无公告数据
  </div>

  <!-- 公告表格 -->
  <el-row :gutter="20" v-else>
    <el-table :data="tableData" border style="width: 100%">
      <el-table-column type="selection" width="55" />
      <el-table-column label="ID" prop="id" width="80" align="center" />
      <el-table-column label="公告标题" prop="title" min-width="200" />
      <el-table-column label="分类" prop="category" width="100" align="center">
        <template #default="scope">
          <el-tag size="small">
            {{ scope.row.category === 'NOTICE' ? '通知公告' : scope.row.category === 'NEWS' ? '新闻动态' : '学术活动' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="优先级" prop="priority" width="100" align="center">
        <template #default="scope">
          <el-tag :type="scope.row.priority === 'HIGH' ? 'danger' : scope.row.priority === 'NORMAL' ? '' : 'info'" size="small">
            {{ scope.row.priority === 'HIGH' ? '高' : scope.row.priority === 'NORMAL' ? '普通' : '低' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="是否置顶" prop="isTop" width="90" align="center">
        <template #default="scope">
          <el-tag v-if="scope.row.isTop === 1" type="danger" size="small">置顶</el-tag>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="发布人" prop="publisherName" width="100" align="center" />
      <!-- 修复：prop和实体字段完全一致 publishTime -->
    
      <el-table-column label="发布时间" prop="publishTime" width="170" align="center" />
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template #default="scope">
          <el-tag :type="scope.row.status === 'PUBLISHED' ? 'success' : scope.row.status === 'DRAFT' ? '' : 'warning'" size="small">
            {{ scope.row.status === 'DRAFT' ? '草稿' : scope.row.status === 'PUBLISHED' ? '已发布' : '已撤回' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="浏览量" prop="viewCount" width="80" align="center" />
      <el-table-column label="操作" width="160" align="center">
        <template #default="scope">
          <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-row>

  <!-- 分页 -->
  <el-pagination
    v-model:current-page="currentPage"
    v-model:page-size="pageSize"
    :page-sizes="[2, 5, 10, 20]"
    :background="true"
    layout="total, sizes, prev, pager, next, jumper"
    :total="totalRecords"
    @size-change="loadData"
    @current-change="loadData"
    class="mt-4 justify-center"
  />

  <!-- 新增/编辑弹窗 -->
  <el-dialog v-model="dialogVisible" title="公告编辑" width="700" destroy-on-close>
    <el-form :model="form" label-width="120px">
      <el-row :gutter="16">
        <el-col :span="12">
          <el-form-item label="公告标题">
            <el-input v-model="form.title" placeholder="请输入标题" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="分类">
            <el-select v-model="form.category" placeholder="请选择分类">
              <el-option label="通知公告" value="NOTICE" />
              <el-option label="新闻动态" value="NEWS" />
              <el-option label="学术活动" value="ACADEMIC" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="优先级">
            <el-select v-model="form.priority" placeholder="请选择优先级">
              <el-option label="高" value="HIGH" />
              <el-option label="普通" value="NORMAL" />
              <el-option label="低" value="LOW" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态">
            <el-select v-model="form.status" placeholder="请选择状态">
              <el-option label="草稿" value="DRAFT" />
              <el-option label="已发布" value="PUBLISHED" />
              <el-option label="已撤回" value="REVOKED" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="是否置顶">
            <el-switch v-model="form.isTop" :active-value="1" :inactive-value="0" active-text="置顶" inactive-text="不置顶" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="附件链接">
            <el-input v-model="form.attachmentUrl" placeholder="附件URL" />
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="公告摘要">
            <el-input v-model="form.summary" type="textarea" :rows="2" placeholder="简短摘要" />
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="公告正文">
            <el-input v-model="form.content" type="textarea" :rows="6" placeholder="完整公告内容" />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <el-button @click="dialogVisible = false">取消</el-button>
      <el-button type="primary" @click="submitForm">保存</el-button>
    </template>
  </el-dialog>
</template>

<script lang="ts" setup>
import { onMounted, ref, reactive } from 'vue'
import http from '../../../utils/request.ts'
import { ElMessage } from 'element-plus' 

// 实体：严格匹配后端返回字段 publishTime（不是publishTime）
interface TbNotice {
  id: number
  title: string
  content: string
  summary: string
  category: 'NOTICE' | 'NEWS' | 'ACADEMIC'
  priority: 'HIGH' | 'NORMAL' | 'LOW'
  status: 'DRAFT' | 'PUBLISHED' | 'REVOKED'
  publisherId: number
  publisherName: string
  publishTime: string // 修正：实体字段 publishTime，表格prop统一publishTime → 改为publishTime
  isTop: 0 | 1
  viewCount: number
  attachmentUrl: string
  isDeleted: 0 | 1
  createTime: string
  updateTime: string
}

// PageHelper标准分页返回结构（后端data里是records，不是list！）
interface PageResult<T> {
  pageNum: number
  pageSize: number
  total: number
  records: T[]
}

// 搜索关键词
const titleKey = ref('')
// 表格数据源
const tableData = ref<TbNotice[]>([])
// 分页
const currentPage = ref(1)
const pageSize = ref(5)
const totalRecords = ref(0)

// 弹窗
const dialogVisible = ref(false)
// 表单
const form = reactive<TbNotice>({
  id: 0,
title: "",
content: "",
summary: "",
category: "NOTICE",
priority: "NORMAL",
status: "DRAFT",
publisherId: 0,
publisherName: "管理员",
publishTime: "",
isTop: 0,
viewCount: 0,
attachmentUrl: "",
isDeleted: 0,
createTime: "",
updateTime: ""
})


// 加载数据（加完整打印调试，定位空白根源）
const loadData = async () => {
  try {
    const res = await http({
      url: '/api/notice/search',
      method: 'GET',
      params: {
        keyword: titleKey.value,
        category: "",
        pageNum: currentPage.value,
        pageSize: pageSize.value
      }
    })

    console.log('后端完整返回数据：', res)
    // 后端返回数组直接赋值
    tableData.value = res.data
    // 分页总数适配（后端分页返回IPage时改为 res.data.total）
    totalRecords.value = res.data.length
  } catch (err) {
    console.error('请求失败，空白原因：', err)
  }
}

// 新增弹窗
const openAddDialog = () => {
  form.id = 0
  form.title = ''
  form.content = ''
  form.summary = ''
  form.category = 'NOTICE'
  form.priority = 'NORMAL'
  form.status = 'DRAFT'
  form.isTop = 0
  form.attachmentUrl = ''
  dialogVisible.value = true
}

// 编辑
const handleEdit = (row: TbNotice) => {
  Object.assign(form, row)
  dialogVisible.value = true
}

// 保存
// 新增全局登录用户ID（实际项目从登录缓存获取，这里临时固定管理员ID=1）
const loginUserId = ref(1)

// 提交保存（新增/编辑）
const submitForm = async () => {
  try {
    if (form.id === 0) {
      // 新增公告
      await http({
        url: '/api/notice/publish',
        method: 'POST',
        data: form,
        params: {
          userId: loginUserId.value
        }
      })
    } else {
      // 编辑公告
      await http({
        url: '/api/notice/update',
        method: 'PUT',
        data: form,
        params: {
          userId: loginUserId.value
        }
      })
    }
    // 成功提示
    ElMessage.success("公告保存成功！")
    dialogVisible.value = false
    loadData()
  } catch (err) {
    // 失败提示
    ElMessage.error("保存失败，请检查输入内容或联系管理员")
    console.error("保存公告异常：", err)
  }
}

// 删除
const handleDelete = async (row: TbNotice) => {
  try {
    await http({ 
      url: `/api/notice/delete/${row.id}`, 
      method: 'DELETE',
      params: {
        userId: loginUserId.value
      }
    })
    ElMessage.success("删除成功！")
    loadData()
  } catch (err) {
    ElMessage.error("删除失败！")
    console.error("删除公告异常：", err)
  }
}

onMounted(() => loadData())
</script>

<style scoped>
.mt-4 {
  margin-top: 16px;
}
.justify-center {
  display: flex;
  justify-content: center;
}
.py-10 {
  padding: 40px 0;
}
.text-gray-500 {
  color: #666;
}
</style>