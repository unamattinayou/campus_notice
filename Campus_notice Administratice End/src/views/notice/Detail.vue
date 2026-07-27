<template>
  <div class="notice-detail">
    <el-card class="box-card" v-if="notice">
      <template #header>
        <div class="card-header">
          <span class="title">{{ notice.title }}</span>
          <div class="meta-info">
            <el-tag 
              :type="notice.priority === 'HIGH' ? 'danger' : notice.priority === 'NORMAL' ? '' : 'info'" 
              size="small"
            >
              {{ notice.priority === 'HIGH' ? '高优先级' : notice.priority === 'NORMAL' ? '普通' : '低优先级' }}
            </el-tag>
            <el-tag v-if="notice.isTop === 1" type="danger" size="small">置顶</el-tag>
          </div>
        </div>
      </template>

      <div class="notice-meta">
        <el-row :gutter="20">
          <el-col :span="8">
            <div class="meta-item">
              <span class="label">发布人：</span>
              <span class="value">{{ notice.publisherName }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="meta-item">
              <span class="label">发布时间：</span>
              <span class="value">{{ formatDateTime(notice.publishTime) }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="meta-item">
              <span class="label">浏览次数：</span>
              <span class="value">{{ notice.viewCount }} 次</span>
            </div>
          </el-col>
        </el-row>
        <el-row :gutter="20" class="mt-10">
          <el-col :span="8">
            <div class="meta-item">
              <span class="label">分类：</span>
              <el-tag size="small">
                {{ notice.category === 'NOTICE' ? '通知公告' : notice.category === 'NEWS' ? '新闻动态' : '学术活动' }}
              </el-tag>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="meta-item">
              <span class="label">状态：</span>
              <el-tag 
                :type="notice.status === 'PUBLISHED' ? 'success' : notice.status === 'DRAFT' ? '' : 'warning'" 
                size="small"
              >
                {{ notice.status === 'DRAFT' ? '草稿' : notice.status === 'PUBLISHED' ? '已发布' : '已撤回' }}
              </el-tag>
            </div>
          </el-col>
        </el-row>
      </div>

      <el-divider />

      <div class="notice-summary" v-if="notice.summary">
        <h4>摘要</h4>
        <p>{{ notice.summary }}</p>
      </div>

      <div class="notice-content">
        <h4>正文内容</h4>
        <div class="content-text" v-html="notice.content"></div>
      </div>

      <div class="notice-attachment" v-if="notice.attachmentUrl">
        <h4>附件</h4>
        <el-link :href="notice.attachmentUrl" target="_blank" type="primary">
          <el-icon><Download /></el-icon>
          下载附件
        </el-link>
      </div>

      <el-divider />

      <div class="action-buttons">
        <el-button @click="goBack">返回列表</el-button>
        <el-button type="primary" @click="handleEdit" v-if="canEdit">编辑</el-button>
      </div>
    </el-card>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import http from '../../utils/request.ts'
import { ElMessage } from 'element-plus'
import { Download } from '@element-plus/icons-vue'

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
  publishTime: string
  isTop: 0 | 1
  viewCount: number
  attachmentUrl: string
  isDeleted: 0 | 1
  createTime: string
  updateTime: string
}

const route = useRoute()
const router = useRouter()
const notice = ref<TbNotice | null>(null)

const canEdit = computed(() => {
  return notice.value && (notice.value.status === 'DRAFT' || notice.value.status === 'REVOKED')
})

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

const loadDetail = async () => {
  const id = Number(route.params.id)
  if (!id) {
    ElMessage.error('公告ID不存在')
    return
  }

  // 优先从query参数获取完整数据
  const queryData = route.query.data as string
  if (queryData) {
    try {
      notice.value = JSON.parse(decodeURIComponent(queryData))
      return
    } catch (e) {
      console.error('解析query数据失败', e)
    }
  }

  // 其次从sessionStorage缓存获取
  const cachedList = sessionStorage.getItem('noticeList')
  if (cachedList) {
    try {
      const notices = JSON.parse(cachedList) as TbNotice[]
      const found = notices.find(n => n.id === id)
      if (found) {
        notice.value = found
        return
      }
    } catch (e) {
      console.error('解析缓存数据失败', e)
    }
  }

  // 最后尝试调用API获取
  try {
    const res = await http({
      url: `/api/notice/detail/${id}`,
      method: 'GET'
    })
    notice.value = res.data
  } catch (err) {
    ElMessage.error('加载公告详情失败')
    console.error('加载详情失败：', err)
  }
}

const goBack = () => {
  router.push('/')
}

const handleEdit = () => {
  if (notice.value) {
    router.push(`/notice/edit/${notice.value.id}`)
  }
}

onMounted(() => {
  loadDetail()
})
</script>

<style scoped>
.notice-detail {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header .title {
  font-size: 24px;
  font-weight: bold;
}

.meta-info {
  display: flex;
  gap: 10px;
}

.notice-meta {
  margin-bottom: 20px;
}

.meta-item {
  display: flex;
  align-items: center;
}

.meta-item .label {
  color: #666;
  margin-right: 8px;
}

.meta-item .value {
  color: #333;
}

.mt-10 {
  margin-top: 10px;
}

.notice-summary,
.notice-content,
.notice-attachment {
  margin: 20px 0;
}

.notice-summary h4,
.notice-content h4,
.notice-attachment h4 {
  margin-bottom: 10px;
  color: #333;
}

.content-text {
  padding: 15px;
  background: #f5f7fa;
  border-radius: 4px;
  line-height: 1.8;
}

.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>