<template>
  <div class="app-container">

    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="申请人" prop="userName">
        <el-input v-model="queryParams.userName" placeholder="请输入申请人姓名" clearable />
      </el-form-item>

      <el-form-item label="审核状态" prop="checkName">
        <el-input v-model="queryParams.checkName" placeholder="请输入审核状态名称" clearable />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh">重置</el-button>
      </el-form-item>
    </el-form>


    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" @click="handleUpdate"
          v-hasPermi="['oa:leave:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="leaveList">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="申请人姓名" align="center" prop="userName" />
      <el-table-column label="请假类别ID" align="center">
        <template #default="scope">
          {{ valueToLabel(scope.row.regionId) }}
        </template>
      </el-table-column>
      <!-- <el-table-column label="销假经办人签字" align="center" prop="agent" /> -->
      <el-table-column label="请假审批状态，0默认" align="center">
        <template #default="scope">
          {{ valueToLabelByDict(41,scope.row.leaveStatus) }}
        </template>
      </el-table-column>
      <!-- <el-table-column label="审核状态" align="center" prop="checkStatus" />
      <el-table-column label="审核状态名称" align="center" prop="checkName" /> -->
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" class="scope_btn" @click="updateHandle(scope.row)" v-if="is_show_edit_btn(scope.row)">修改
          </el-button>
          <el-button type="danger" class="scope_btn" @click="doAuth(scope.row, 1)" v-if="is_show_auth_btn(scope.row)">审核
          </el-button>
          <el-button type="success" class="scope_btn" @click="viewAuth(scope.row, 0)" v-if="view_show(scope.row)">查看
          </el-button>
          <el-button type="danger" class="scope_btn" @click="deleteHandle(scope.row)" v-if="is_show_edit_btn(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>


    <el-pagination v-model:currentPage="queryParams.pageNo" v-model:page-size="queryParams.pageSize" :page-sizes="[5, 10]"
      layout="total, sizes, prev, pager, next, jumper" :total="queryParams.total" @size-change="handleSizeChange"
      @current-change="handleCurrentChange" />
 
     
  </div>
</template>

<script setup>
import { getDictDetailByDictId, listLeave, getLeaveById, delLeave, addLeave, updateLeave } from "@/api/oa/leave";
import { getUserProfile } from "@/api/system/user"
import useUserStore from '@/store/modules/user'
import { ElMessage } from 'element-plus'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
const router = useRouter()

const loading = ref(true)
const leaveList = ref([])

import {valueToLabelByDict,getDictDetailAll} from '@/views/oa/util/dictarr.js' 
import {getUserInfo, userInfo } from '@/views/oa/util/userInfo.js'  
// getDictDetailAll() //获取字典表
// getUserInfo()      //获取用户信息
// console.log("*********",userInfo.roleIds);
import { useCounterStore } from '@/views/oa/store/modules/datastore' 
const datastore = useCounterStore() 
const userStore = useUserStore()
const dict_json = localStorage.getItem('dictionary');   


const data = reactive({
  form: {
  },
  queryParams: {
    pageNo: 1,
    pageSize: 5,
    total: 0,
    id: null,
    userId: 0,
    userName: '',
    regionId: 0,
    beginTime: '',
    endTime: '',
    description: '',
    teacherOption: '',
    teacherUserid: 0,
    classTeacherOption: '',
    classTeacherUserid: 0,
    deanOption: '',
    deanUserid: 0,
    classmate: '',
    agent: '',
    leaveStatus: 0,
    checkStatus: 0,
    checkName: '',
    del: 0
  },
  rules: {
    userName: [{ required: true, message: '请输入申请人', trigger: 'blur' }],
    region_id: [{ required: true, message: '请选择请假类别', trigger: 'change' }],
    date: [{ required: true, message: '请选择请假时间', trigger: 'change' }],
    description: [{ required: true, message: '请输入请假理由', trigger: 'blur' }],
  },
})
const title = ref()
const showSearch = ref(true)

const { queryParams, form, rules } = toRefs(data);

const roleList = ref([])
const userInfoObj = ref([])

const fetchUserInfo = async () => {
  let userinfo = await getUserProfile(); 
  let arr = []
  userInfoObj.value = userinfo.data 
  let obj = userinfo.data.roles
  for (let item of obj) {
    arr.push(item.roleId)
  }
  roleList.value = arr 

}
fetchUserInfo()


//  获取下拉选项数据
const options = ref([])
const optionsLeaveAll = ref([])
const getDictDetail = async () => {
  let result = await getDictDetailByDictId(40);
  options.value = result
}
getDictDetail()

 

function is_show_auth_btn(row) {
  let leaveStatus = row.leaveStatus
  let show = false
  let roleArr = roleList.value
  //班主任审批
  if (leaveStatus == 0 && roleArr.includes(100)) {
    show = true
  }
  //系主任审批
  if (leaveStatus == 1 && roleArr.includes(101)) {
    show = true
  }
  //副院长审批
  if (leaveStatus == 2 && roleArr.includes(102)) {
    show = true
  }
  return show
}

function is_show_edit_btn(row){
  let show = false
  if(row.userId == userInfoObj.value.userId){
    show = true
  }
  return show 
}


function valueToLabel(val) {
  let arr = options.value
  let label = ""
  // console.log('***arr: ', arr);
  for (let obj of arr) {
    if (obj.value == val) {
      label = obj.label
    }
  }
  return label
}
 

function view_show() { }


/** 查询请假列表 */
const getList = async () => {
  loading.value = true;
  let response = await listLeave(queryParams.value) 
  leaveList.value = response.records;
  queryParams.value.total = response.total;
  loading.value = false;
}
getList()


/** 新增按钮操作 */
function handleAdd() {
  // title.value = "添加请假";
  router.push({ path: "/oa/leave/edit" })
}

/** 新增按钮操作 */
function handleUpdate(row) {
  // title.value = "添加请假";
  router.push({ path: "/leave/edit", query: { row: row, show_status: 1 } })
}


const deleteHandle = async (row) => {
  let res = await delLeave(row.id);
  if (res == true) {
    ElMessage({
      message: '删除成功！',
      type: 'warning',
    })
  } 
  getList()
}
 

function handleQuery() {
  getList()
}

function cancel() {
}

function submitForm() {
  getList()
}

function handleSizeChange(val) {
  queryParams.pageNo = val
  getList()
}

function handleCurrentChange(val) {
  queryParams.pageNum = val
  getList()
}

/**
 * 保存数据
 */
const submit = async () => {
  //console.log(form.value);
  const res = await addLeave(form.value)
  open.value = false
  getList()
  reset()
}

/** 表单重置 */
function reset() {
  form.value = {
    userName: undefined,
    date: undefined,
    description: undefined,
  };
}

//审核按钮是否显示
function doAuth(row, value) {
  if (row.userid == useUserStore().id) {
    ElMessage({
      message: '不能审批自己填写的请假条！',
      type: 'warning',
    })
    return
  }

  router.push({ path: "/oa/leave/auth", query: { id: row.id } })
}

function updateHandle(row) {
  router.push({ path: "/oa/leave/edit", query: { id: row.id } })
}


</script>
