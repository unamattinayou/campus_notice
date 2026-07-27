<template>
  <div class="app-container">
    <!-- 搜索区域 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" label-width="80px">
      <el-form-item label="用户名" prop="username">
        <el-input
          v-model="queryParams.username"
          placeholder="请输入用户名"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="角色" prop="role">
        <el-select v-model="queryParams.role" placeholder="请选择角色" clearable style="width: 200px">
          <el-option label="管理员" value="ADMIN" />
          <el-option label="教师" value="TEACHER" />
          <el-option label="学生" value="STUDENT" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleQuery">搜索</el-button>
        <el-button @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain @click="handleAdd">新增</el-button>
      </el-col>
    </el-row>

    <!-- 用户列表 -->
    <el-table v-loading="loading" :data="userList" border>
      <el-table-column label="用户ID" prop="id" width="80" align="center" />
      <el-table-column label="用户名" prop="username" width="120" align="center" />
      <el-table-column label="真实姓名" prop="realName" width="120" align="center" />
      <el-table-column label="角色" prop="role" width="100" align="center">
        <template #default="scope">
          <el-tag :type="getRoleTagType(scope.row.role)">
            {{ getRoleLabel(scope.row.role) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="手机号" prop="phone" width="130" align="center" />
      <el-table-column label="邮箱" prop="email" width="180" align="center" />
      <el-table-column label="部门" prop="department" width="150" align="center" />
      <el-table-column label="创建时间" prop="createTime" width="170" align="center" />
      <el-table-column label="操作" width="200" align="center" fixed="right">
        <template #default="scope">
          <el-button size="small" type="primary" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-show="total > 0"
      v-model:current-page="queryParams.pageNum"
      v-model:page-size="queryParams.pageSize"
      :page-sizes="[10, 20, 50, 100]"
      :background="true"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      class="mt-4"
    />

    <!-- 添加或修改用户对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="userRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="用户名" prop="username">
              <el-input v-model="form.username" placeholder="请输入用户名" :disabled="form.id !== 0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="真实姓名" prop="realName">
              <el-input v-model="form.realName" placeholder="请输入真实姓名" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="密码" prop="password" v-if="form.id === 0">
              <el-input v-model="form.password" type="password" placeholder="请输入密码" show-password />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="角色" prop="role">
              <el-select v-model="form.role" placeholder="请选择角色" style="width: 100%">
                <el-option label="管理员" value="ADMIN" />
                <el-option label="教师" value="TEACHER" />
                <el-option label="学生" value="STUDENT" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入手机号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="部门" prop="department">
          <el-input v-model="form.department" placeholder="请输入部门/院系" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listUser, getUser, addUser, updateUser, delUser } from '@/api/shopping/user'

const loading = ref(true)
const userList = ref([])
const total = ref(0)
const title = ref('')
const open = ref(false)

const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  username: '',
  role: ''
})

const form = reactive({
  id: 0,
  username: '',
  password: '',
  realName: '',
  role: 'STUDENT',
  phone: '',
  email: '',
  department: ''
})

const rules = reactive({
  username: [
    { required: true, message: '用户名不能为空', trigger: 'blur' },
    { min: 2, max: 30, message: '用户名长度在 2 到 30 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '用户密码不能为空', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  realName: [
    { required: true, message: '真实姓名不能为空', trigger: 'blur' }
  ],
  role: [
    { required: true, message: '角色不能为空', trigger: 'change' }
  ]
})

const userRef = ref(null)

function getList() {
  loading.value = true
  listUser(queryParams).then(response => {
    const data = response.data || {}
    userList.value = data.rows || []
    total.value = data.total || 0
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function getRoleTagType(role) {
  const typeMap = {
    'ADMIN': 'danger',
    'TEACHER': 'success',
    'STUDENT': ''
  }
  return typeMap[role] || ''
}

function getRoleLabel(role) {
  const labelMap = {
    'ADMIN': '管理员',
    'TEACHER': '教师',
    'STUDENT': '学生'
  }
  return labelMap[role] || role
}

function handleQuery() {
  queryParams.pageNum = 1
  getList()
}

function resetQuery() {
  queryParams.username = ''
  queryParams.role = ''
  handleQuery()
}

function handleAdd() {
  resetForm()
  open.value = true
  title.value = '添加用户'
}

function handleUpdate(row) {
  resetForm()
  const userId = row.id
  getUser(userId).then(response => {
    Object.assign(form, response.data || response)
    open.value = true
    title.value = '修改用户'
  })
}

function submitForm() {
  userRef.value?.validate(valid => {
    if (valid) {
      if (form.id !== 0) {
        updateUser(form).then(() => {
          ElMessage.success('修改成功')
          open.value = false
          getList()
        })
      } else {
        addUser(form).then(() => {
          ElMessage.success('新增成功')
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  ElMessageBox.confirm('是否确认删除用户"' + row.username + '"？', '警告', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    return delUser(row.id)
  }).then(() => {
    getList()
    ElMessage.success('删除成功')
  }).catch(() => {})
}

function resetForm() {
  form.id = 0
  form.username = ''
  form.password = ''
  form.realName = ''
  form.role = 'STUDENT'
  form.phone = ''
  form.email = ''
  form.department = ''
  userRef.value?.resetFields()
}

function cancel() {
  open.value = false
  resetForm()
}

function handleSizeChange() {
  queryParams.pageNum = 1
  getList()
}

function handleCurrentChange() {
  getList()
}

onMounted(() => {
  getList()
})
</script>

<style scoped>
.mb8 {
  margin-bottom: 8px;
}
.mt-4 {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}
</style>
