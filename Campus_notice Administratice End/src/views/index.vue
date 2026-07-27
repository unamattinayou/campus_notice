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
          <el-tag :type="getNoticeStatusType(scope.row.status)" size="small">
            {{ getNoticeStatusLabel(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="240" align="center">
        <template #default="scope">
          <el-button size="small" @click="handleView(scope.row)">查看</el-button>
          <el-button size="small" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
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
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange"
    class="mt-4 justify-center"
  />
</template>

<script lang="ts" setup>
import { onMounted, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import http from '../utils/request.ts'
import { ElMessage, ElMessageBox } from 'element-plus' 

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

const router = useRouter()

// PageHelper标准分页返回结构（后端data里是records，不是list！）
interface PageResult<T> {
  pageNum: number
  pageSize: number
  total: number
  records: T[]
}

// 搜索关键词
const titleKey = ref('')
// 全部数据（后端一次返回所有数据，前端做分页）
const allData = ref<TbNotice[]>([])
// 当前页表格数据源
const tableData = ref<TbNotice[]>([])
// 分页
const currentPage = ref(1)
const pageSize = ref(5)
const totalRecords = ref(0)

// 根据当前页码和每页条数，从全量数据中切片
const updatePageData = () => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  tableData.value = allData.value.slice(start, end)
}

// 获取公告状态标签类型
const getNoticeStatusType = (status: string) => {
  const typeMap: Record<string, string> = {
    'DRAFT': '',
    'PENDING_REVIEW': 'primary',
    'PUBLISHED': 'success',
    'REVOKED': 'warning'
  }
  return typeMap[status] || ''
}

// 获取公告状态标签文本
const getNoticeStatusLabel = (status: string) => {
  const labelMap: Record<string, string> = {
    'DRAFT': '草稿',
    'PENDING_REVIEW': '待审核',
    'PUBLISHED': '已发布',
    'REVOKED': '已撤回'
  }
  return labelMap[status] || status
}

// 加载数据
const loadData = async () => {
  try {
    const res = await http({
      url: '/api/notice/all',
      method: 'GET'
    })

    console.log('后端完整返回数据：', res)
    // 后端返回所有公告（含草稿、已发布、已撤回），前端按关键词过滤
    let list = res.data || []
    if (titleKey.value) {
      const kw = titleKey.value.toLowerCase()
      list = list.filter((n: TbNotice) =>
        (n.title && n.title.toLowerCase().includes(kw)) ||
        (n.content && n.content.toLowerCase().includes(kw))
      )
    }
    allData.value = list
    totalRecords.value = list.length
    // 搜索后回到第一页
    currentPage.value = 1
    updatePageData()
    // 缓存公告列表到sessionStorage，供详情和编辑页面使用
    sessionStorage.setItem('noticeList', JSON.stringify(res.data))
  } catch (err) {
    console.error('请求失败，空白原因：', err)
  }
}

// 分页：每页条数变化
const handleSizeChange = () => {
  currentPage.value = 1
  updatePageData()
}

// 分页：页码变化
const handleCurrentChange = () => {
  updatePageData()
}

// 新增弹窗
const openAddDialog = () => {
  router.push('/notice/add')
}

// 查看详情
const handleView = (row: TbNotice) => {
  const data = encodeURIComponent(JSON.stringify(row))
  router.push({ path: `/notice/detail/${row.id}`, query: { data } })
}

// 编辑
const handleEdit = (row: TbNotice) => {
  const data = encodeURIComponent(JSON.stringify(row))
  router.push({ path: `/notice/edit/${row.id}`, query: { data } })
}

// 新增全局登录用户ID（实际项目从登录缓存获取，这里临时固定管理员ID=1）
const loginUserId = ref(1)

// 删除
const handleDelete = async (row: TbNotice) => {
  try {
    await ElMessageBox.confirm(`确认删除公告"${row.title}"吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    await http({ 
      url: `/api/notice/delete/${row.id}`, 
      method: 'DELETE',
      params: {
        userId: loginUserId.value
      }
    })
    // 从缓存中移除
    removeNoticeFromCache(row.id)
    // 从全量数据中移除并重新分页
    allData.value = allData.value.filter(n => n.id !== row.id)
    totalRecords.value = allData.value.length
    // 如果当前页删空了且不是第一页，回到上一页
    const maxPage = Math.max(1, Math.ceil(totalRecords.value / pageSize.value))
    if (currentPage.value > maxPage) {
      currentPage.value = maxPage
    }
    updatePageData()
    ElMessage.success("删除成功！")
  } catch (err: any) {
    if (err !== 'cancel' && err?.message !== 'cancel') {
      ElMessage.error(err.message || "删除失败！")
      console.error("删除公告异常：", err)
    }
  }
}

// 从缓存中移除公告
const removeNoticeFromCache = (id: number) => {
  const cachedList = sessionStorage.getItem('noticeList')
  if (cachedList) {
    try {
      const notices = JSON.parse(cachedList) as TbNotice[]
      const filtered = notices.filter(n => n.id !== id)
      sessionStorage.setItem('noticeList', JSON.stringify(filtered))
    } catch (e) {
      console.error('更新缓存失败', e)
    }
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