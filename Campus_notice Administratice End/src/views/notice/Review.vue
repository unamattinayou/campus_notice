<template>
  <div class="notice-review">
    <!-- 无权限提示 -->
    <el-result v-if="!isAdmin" icon="warning" title="无权限访问" sub-title="只有系统管理员可以使用公告审核功能">
      <template #extra>
        <el-button type="primary" @click="router.push('/')">返回首页</el-button>
      </template>
    </el-result>

    <el-card v-else class="box-card">
      <template #header>
        <div class="card-header">
          <span>公告审核</span>
        </div>
      </template>

      <!-- 待审核公告列表 -->
      <el-table :data="pendingNotices" border style="width: 100%" v-loading="loading">
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
        <el-table-column label="提交人" prop="publisherName" width="100" align="center" />
        <el-table-column label="提交时间" prop="createTime" width="170" align="center">
          <template #default="scope">
            {{ formatDateTime(scope.row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" align="center" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="handleView(scope.row)">查看</el-button>
            <el-button size="small" type="success" @click="handleApprove(scope.row)">通过</el-button>
            <el-button size="small" type="danger" @click="handleReject(scope.row)">驳回</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[5, 10, 20, 50]"
        :background="true"
        layout="total, sizes, prev, pager, next, jumper"
        :total="totalRecords"
        @size-change="loadPendingNotices"
        @current-change="loadPendingNotices"
        class="mt-4"
      />
    </el-card>

    <!-- 查看详情弹窗 -->
    <el-dialog v-model="detailDialogVisible" title="公告详情" width="700">
      <el-descriptions :column="2" border v-if="currentNotice">
        <el-descriptions-item label="公告标题">{{ currentNotice.title }}</el-descriptions-item>
        <el-descriptions-item label="分类">
          {{ currentNotice.category === 'NOTICE' ? '通知公告' : currentNotice.category === 'NEWS' ? '新闻动态' : '学术活动' }}
        </el-descriptions-item>
        <el-descriptions-item label="优先级">
          {{ currentNotice.priority === 'HIGH' ? '高' : currentNotice.priority === 'NORMAL' ? '普通' : '低' }}
        </el-descriptions-item>
        <el-descriptions-item label="提交人">{{ currentNotice.publisherName }}</el-descriptions-item>
        <el-descriptions-item label="提交时间">{{ formatDateTime(currentNotice.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="是否置顶">{{ currentNotice.isTop === 1 ? '是' : '否' }}</el-descriptions-item>
        <el-descriptions-item label="摘要" :span="2">{{ currentNotice.summary || '无' }}</el-descriptions-item>
        <el-descriptions-item label="正文内容" :span="2">
          <div v-html="currentNotice.content" style="max-height: 300px; overflow-y: auto;"></div>
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <el-button @click="detailDialogVisible = false">关闭</el-button>
        <el-button type="success" @click="handleApprove(currentNotice)">通过</el-button>
        <el-button type="danger" @click="handleReject(currentNotice)">驳回</el-button>
      </template>
    </el-dialog>

    <!-- 驳回原因弹窗 -->
    <el-dialog v-model="rejectDialogVisible" title="驳回原因" width="500">
      <el-form :model="rejectForm" label-width="100px">
        <el-form-item label="驳回原因">
          <el-input 
            v-model="rejectForm.reason" 
            type="textarea" 
            :rows="4" 
            placeholder="请输入驳回原因" 
            maxlength="500" 
            show-word-limit 
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="rejectDialogVisible = false">取消</el-button>
        <el-button type="danger" @click="submitReject">确认驳回</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import http from '../../utils/request.ts'
import { ElMessage, ElMessageBox } from 'element-plus'
import useUserStore from '@/store/modules/user'

const router = useRouter()
const userStore = useUserStore()

const isAdmin = computed(() => {
  return userStore.roles.includes('admin')
})

interface TbNotice {
  id: number
  title: string
  content: string
  summary: string
  category: 'NOTICE' | 'NEWS' | 'ACADEMIC'
  priority: 'HIGH' | 'NORMAL' | 'LOW'
  status: 'DRAFT' | 'PENDING_REVIEW' | 'PUBLISHED' | 'REVOKED'
  publisherId: number
  publisherName: string
  publishTime: string
  isTop: 0 | 1
  viewCount: number
  attachmentUrl: string
  isDeleted: 0 | 1
  createTime: string
  updateTime: string
}

const loading = ref(false)
const pendingNotices = ref<TbNotice[]>([])
const currentPage = ref(1)
const pageSize = ref(10)
const totalRecords = ref(0)

const detailDialogVisible = ref(false)
const currentNotice = ref<TbNotice | null>(null)

const rejectDialogVisible = ref(false)
const rejectForm = reactive({
  reason: ''
})

const loginUserId = ref(1)

const formatDateTime = (dateStr: string) => {
  if (!dateStr) return '-'
  const date = new Date(dateStr)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const loadPendingNotices = async () => {
  loading.value = true
  try {
    const res = await http({
      url: '/api/notice/all',
      method: 'GET'
    })
    
    const allNotices = res.data as TbNotice[]
    pendingNotices.value = allNotices.filter(n => n.status === 'PENDING_REVIEW')
    totalRecords.value = pendingNotices.value.length
  } catch (err) {
    ElMessage.error('加载待审核公告失败')
    console.error('加载失败：', err)
  } finally {
    loading.value = false
  }
}

const handleView = (row: TbNotice) => {
  currentNotice.value = row
  detailDialogVisible.value = true
}

const handleApprove = async (row: TbNotice | null) => {
  if (!row) return

  try {
    await ElMessageBox.confirm('确认通过该公告吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'success'
    })

    // 更新公告状态为已发布
    const updateData = { ...row, status: 'PUBLISHED' }
    await http({
      url: '/api/notice/update',
      method: 'PUT',
      data: updateData,
      params: {
        userId: loginUserId.value
      }
    })

    ElMessage.success('审核通过！')
    detailDialogVisible.value = false
    loadPendingNotices()
  } catch (err) {
    if (err !== 'cancel') {
      ElMessage.error('审核操作失败')
      console.error('审核失败：', err)
    }
  }
}

const handleReject = (row: TbNotice | null) => {
  if (!row) return
  currentNotice.value = row
  rejectForm.reason = ''
  rejectDialogVisible.value = true
}

const submitReject = async () => {
  if (!rejectForm.reason) {
    ElMessage.warning('请输入驳回原因')
    return
  }

  if (!currentNotice.value) return

  try {
    // 更新公告状态为已驳回
    const updateData = { 
      ...currentNotice.value, 
      status: 'REVOKED',
      summary: `驳回原因：${rejectForm.reason}` // 将驳回原因记录在摘要中
    }
    
    await http({
      url: '/api/notice/update',
      method: 'PUT',
      data: updateData,
      params: {
        userId: loginUserId.value
      }
    })

    ElMessage.success('已驳回该公告！')
    rejectDialogVisible.value = false
    detailDialogVisible.value = false
    loadPendingNotices()
  } catch (err) {
    ElMessage.error('驳回操作失败')
    console.error('驳回失败：', err)
  }
}

onMounted(() => {
  loadPendingNotices()
})
</script>

<style scoped>
.notice-review {
  padding: 20px;
}

.card-header {
  font-size: 18px;
  font-weight: bold;
}

.mt-4 {
  margin-top: 16px;
}
</style>