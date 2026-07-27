<template>
  <div class="notice-edit">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>{{ isEdit ? '编辑公告' : '新增公告' }}</span>
        </div>
      </template>

      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="公告标题" prop="title">
              <el-input v-model="form.title" placeholder="请输入公告标题" maxlength="200" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="分类" prop="category">
              <el-select v-model="form.category" placeholder="请选择分类" style="width: 100%">
                <el-option label="通知公告" value="NOTICE" />
                <el-option label="新闻动态" value="NEWS" />
                <el-option label="学术活动" value="ACADEMIC" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="优先级" prop="priority">
              <el-select v-model="form.priority" placeholder="请选择优先级" style="width: 100%">
                <el-option label="高" value="HIGH" />
                <el-option label="普通" value="NORMAL" />
                <el-option label="低" value="LOW" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="是否置顶">
              <el-switch 
                v-model="form.isTop" 
                :active-value="1" 
                :inactive-value="0" 
                active-text="置顶" 
                inactive-text="不置顶" 
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="公告摘要" prop="summary">
          <el-input 
            v-model="form.summary" 
            type="textarea" 
            :rows="2" 
            placeholder="请输入公告摘要（可选）" 
            maxlength="500" 
            show-word-limit 
          />
        </el-form-item>

        <el-form-item label="公告正文" prop="content">
          <el-input 
            v-model="form.content" 
            type="textarea" 
            :rows="8" 
            placeholder="请输入公告正文内容" 
            maxlength="5000" 
            show-word-limit 
          />
        </el-form-item>

        <el-form-item label="附件链接">
          <el-input v-model="form.attachmentUrl" placeholder="请输入附件URL（可选）" />
        </el-form-item>

        <el-form-item v-if="isEdit && isAdmin" label="发布状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择发布状态" style="width: 200px">
            <el-option label="草稿" value="DRAFT" />
            <el-option label="待审核" value="PENDING_REVIEW" />
            <el-option label="已发布" value="PUBLISHED" />
            <el-option label="已撤回" value="REVOKED" />
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleSubmit(0)">保存草稿</el-button>
          <el-button type="success" @click="handleSubmit(1)">提交审核</el-button>
          <el-button @click="handleCancel">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import http from '../../utils/request.ts'
import { ElMessage, FormInstance, FormRules } from 'element-plus'
import useUserStore from '@/store/modules/user'

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
const formRef = ref<FormInstance>()

const isEdit = computed(() => {
  return !!route.params.id
})

const form = reactive<TbNotice>({
  id: 0,
  title: '',
  content: '',
  summary: '',
  category: 'NOTICE',
  priority: 'NORMAL',
  status: 'DRAFT',
  publisherId: 0,
  publisherName: '管理员',
  publishTime: '',
  isTop: 0,
  viewCount: 0,
  attachmentUrl: '',
  isDeleted: 0,
  createTime: '',
  updateTime: ''
})

const rules = reactive<FormRules>({
  title: [
    { required: true, message: '请输入公告标题', trigger: 'blur' },
    { min: 2, max: 200, message: '标题长度在 2 到 200 个字符', trigger: 'blur' }
  ],
  category: [
    { required: true, message: '请选择分类', trigger: 'change' }
  ],
  priority: [
    { required: true, message: '请选择优先级', trigger: 'change' }
  ],
  content: [
    { required: true, message: '请输入公告正文', trigger: 'blur' }
  ]
})

const loginUserId = ref(1)

const loadNotice = async () => {
  const id = Number(route.params.id)
  if (!id) return

  // 优先从query参数获取完整数据
  const queryData = route.query.data as string
  if (queryData) {
    try {
      const noticeData = JSON.parse(decodeURIComponent(queryData))
      Object.assign(form, noticeData)
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
      const notice = notices.find(n => n.id === id)
      if (notice) {
        Object.assign(form, notice)
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
    Object.assign(form, res.data)
  } catch (err) {
    ElMessage.error('加载公告信息失败')
    console.error('加载公告失败：', err)
  }
}

const handleSubmit = async (publishType: number) => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const submitData = { ...form }
        
        if (isEdit.value && isAdmin.value) {
          // 管理员编辑时，保留手动选择的发布状态
        } else if (publishType === 1) {
          // 提交审核：状态设为待审核，等待管理员审核通过后发布
          submitData.status = 'PENDING_REVIEW'
        } else {
          // 保存草稿
          submitData.status = 'DRAFT'
        }

        if (isEdit.value) {
          // 更新
          await http({
            url: '/api/notice/update',
            method: 'PUT',
            data: submitData,
            params: {
              userId: loginUserId.value
            }
          })
          // 更新缓存
          updateNoticeCache(submitData)
          ElMessage.success(isEdit.value && isAdmin.value ? '公告更新成功！' : '公告已更新，等待管理员审核！')
        } else {
          // 新增
          const res = await http({
            url: '/api/notice/publish',
            method: 'POST',
            data: submitData,
            params: {
              userId: loginUserId.value
            }
          })
          // 更新缓存
          addNoticeCache(res.data)
          ElMessage.success(publishType === 1 ? '公告已提交，等待管理员审核通过后发布！' : '草稿保存成功！')
        }

        router.push('/')
      } catch (err) {
        ElMessage.error('保存失败，请检查输入内容或联系管理员')
        console.error('保存公告异常：', err)
      }
    }
  })
}

const handleCancel = () => {
  router.push('/')
}

const updateNoticeCache = (notice: TbNotice) => {
  const cachedList = sessionStorage.getItem('noticeList')
  if (cachedList) {
    try {
      const notices = JSON.parse(cachedList) as TbNotice[]
      const index = notices.findIndex(n => n.id === notice.id)
      if (index !== -1) {
        notices[index] = notice
        sessionStorage.setItem('noticeList', JSON.stringify(notices))
      }
    } catch (e) {
      console.error('更新缓存失败', e)
    }
  }
}

const addNoticeCache = (notice: TbNotice) => {
  const cachedList = sessionStorage.getItem('noticeList')
  if (cachedList) {
    try {
      const notices = JSON.parse(cachedList) as TbNotice[]
      notices.unshift(notice)
      sessionStorage.setItem('noticeList', JSON.stringify(notices))
    } catch (e) {
      console.error('添加缓存失败', e)
    }
  }
}

onMounted(() => {
  if (isEdit.value) {
    loadNotice()
  }
})
</script>

<style scoped>
.notice-edit {
  padding: 20px;
}

.card-header {
  font-size: 18px;
  font-weight: bold;
}

.el-form {
  max-width: 1200px;
}
</style>