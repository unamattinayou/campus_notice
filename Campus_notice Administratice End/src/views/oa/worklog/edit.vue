
<script lang="js" setup>
import { 
  saveAll,
  getAllByid
} from "@/api/oa/worklog";

import { ElMessage } from 'element-plus'
// import { getUserInfo } from "@/utils/auth.js";
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()
let loginUserInfo_ = localStorage.getItem("loginUserInfo")
let loginUserInfo = JSON.parse(loginUserInfo_)

var validatePhone = (rule, value, callback) => {
  // if (value === "") {
  //   callback(new Error("请输入电话号码"));
  // }
  // // 验证电话号码手机号码，包含至今所有号段? ?
  // var ab = /^[1][3,4,5,7,8][0-9]{9}$/;
  // if (ab.test(value) === false) {
  //   callback(new Error("请输入正确电话号码"));
  // }
  // callback();
}

let worklogForm = ref({
  id: null,
  sysdate: null,
  isable: null,
  workdate: null,
  worksummary: null,
  mobile: "",
  submitdate: null,
  del: 1,
  userId: 0,
  orgId: 0,
  deptId: 0,
  isauth: null,
  attachment: null,
  nickName: null,    // 
  worklogDetailList: []   // 
})

let worklogDetailForm = ref({
  id: null,
  worktype: null,
  workdesc: null,
  no: null,
  worktime: null,
  del: null,
  jobType: null,
  notes: null,
  noteType: null,
  worklogId: null
})

let rules = ref(
  {
    mobile: [
      { required: true, message: "手机号码不能为空" },
      {
        validator: validatePhone,
        message: "请输入正确的手机号码",
        trigger: "blur"
      }
    ]
  }
)



let worklogDetailList = ref([])
let editDetailState = ref("add")   //update表示修改   add表示新增
let dialogFormVisible = ref(false) //控制弹出框： true打开弹窗， false 关闭弹窗



const saveHandle = async () => {
  let res = await saveAll(worklogForm.value)
  if (res) {
    ElMessage({
      message: 'ok',
      type: 'success',
    })
    router.push({path:'/worklog/index'})
  }

}

function backHandle() {
  router.push({ path: '/worklog/index' })
}

function addDetailHandle() {
  editDetailState.value = "add"
  dialogFormVisible.value = true;
}

function addDetailAppendHandle() {
  if (editDetailState.value == "add") {
    let obj = new Object()
    obj.worktype = worklogDetailForm.value.worktype
    obj.worktime = worklogDetailForm.value.worktime
    obj.workdesc = worklogDetailForm.value.workdesc 
    worklogForm.value.worklogDetailList.push(obj)
    worklogDetailForm.value = new Object()

  }else{
 
  }
  dialogFormVisible.value = false;
}


function updateDetailHandle(row) {
  editDetailState.value = "update"
  worklogDetailForm.value = row
  dialogFormVisible.value = true;
}

function handleClose() {
  dialogFormVisible.value = false
}
function delDetailHandle(row,index) {
  console.log('index: ', index);
  worklogForm.value.worklogDetailList.splice(index,1)
}

const getTbWorklogByid = async (params) => {
  let res = await getAllByid(params);
  worklogForm.value = res
  console.log('res: ', res);
  // worklogForm.value.nickName
  worklogDetailList.value = res.detailList
}

function initEdit() {
  const id = route.query.id;
  if (id === undefined) {
    worklogForm.value.nickName = loginUserInfo.nickName
    worklogForm.value.userId = loginUserInfo.userId
    return
  } else { 
    const params = { id: id }
    getTbWorklogByid(params)
  }
}
initEdit()
// 获取cookies 内容
</script>

<template>
  <div class="app-container">
    <div class="grid-content bg-purple-dark">
      <el-card class="operate-container" shadow="always">
        <el-form :inline="true" :model="worklogForm" class="demo-form-inline">
          <h2 style=" text-align: center;">工作周报</h2>
          <el-row>
            <el-col :span="1">&nbsp;</el-col>
            <el-col :span="7">
              <el-form-item label="姓名">
                <el-input v-model="worklogForm.nickName" placeholder="姓名" readonly></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="电话" prop="mobile">
                <el-input v-model="worklogForm.mobile" placeholder="电话"></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="日期">
                <el-date-picker v-model="worklogForm.workdate" type="date" placeholder="选择日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row>
            <el-col :span="24">
              <el-form-item label="工作总结">
                <el-input v-model="worklogForm.worksummary" style="width: 970px;margin-left: 20px;" :autosize="{ minRows: 4, maxRows: 8 }"
                  type="textarea" placeholder="请输入工作总结" />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
    </div>

    <el-row>
      <div class="grid-content bg-purple-dark"  style="width: 100%;">
        <el-card class="operate-container" shadow="always">
          <el-row>
            <el-col :span="21">
            </el-col>
            <el-col :span="2">
              <el-button class="btn-add" type="primary" @click="addDetailHandle" size="default">
                新增工作明细
              </el-button>
            </el-col>
            <el-col :span="1">
            </el-col>
          </el-row>


          <!-- 列表展示 -->
          <el-row> 
            <el-table :data="worklogForm.worklogDetailList" >
              <el-table-column type="index" label="编号" width="100"></el-table-column>
              <!-- <el-table-column prop="worktype" label="工作类型" width="200" />  -->
              <el-table-column label="工作类型">
                <template #default="scope">
                  {{ scope.row.worktype == 1 ? "前端开发" : scope.row.worktype == 2 ? "后端开发" : "数据库设计" }}
                </template>
              </el-table-column>
              <el-table-column prop="workdesc" label="工作描述" width="500" />
              <el-table-column prop="worktime" label="工作用时" />
              <el-table-column label="操作" align="center" width="200" fixed="right">
                <template #default="scope">
                  <el-button @click="updateDetailHandle(scope.row)">修改</el-button>
                  <el-button type="danger" @click="delDetailHandle(scope.row,scope.$index)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-row>
        </el-card>
      </div>
    </el-row>


    <el-dialog v-model="dialogFormVisible" :title="editDetailState === 'add' ? '新增工作明细' : '修改工作明细'" width="500"
      :before-close="handleClose">
      <span> </span>
      <template #footer>
        <div class="dialog-footer">
          <el-form :model="worklogDetailForm" style="max-width: 350px;margin: 0 auto;">
            <el-form-item label="工作类型">
              <el-select class="el-input-length" v-model="worklogDetailForm.worktype" placeholder="请选择工作类型">
                <el-option label="前端开发" value="1"></el-option>
                <el-option label="后台开发" value="2"></el-option>
                <el-option label="数据库设计" value="3"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="工作描述">
              <el-input v-model="worklogDetailForm.workdesc" placeholder="工作描述" clearable />
            </el-form-item>
            <el-form-item label="工作用时">
              <el-input v-model="worklogDetailForm.worktime" placeholder="工作用时" clearable />
            </el-form-item>
          </el-form>


          <el-button @click="dialogFormVisible = false">关闭</el-button>
          <el-button type="primary" @click="addDetailAppendHandle">
            确定
          </el-button>
        </div>
      </template>
    </el-dialog>



    <el-row>
      <el-col :span="10">&nbsp;</el-col>
      <el-col :span="4">
        <el-button type="primary" @click="saveHandle">保存</el-button>
        <el-button type="default" @click="backHandle">返回</el-button>
      </el-col>
      <el-col :span="10">&nbsp;</el-col>
    </el-row>
  </div>
</template>

<style>
.el-row {
  margin-bottom: 20px;

  &:last-child {
    margin-bottom: 0;
  }
}

.el-col {
  border-radius: 4px;
}

.bg-purple-dark {
  /* background: #e1e4e8; */
}

.bg-purple {
  background: #d3dce6;
}

.bg-purple-light {
  background: #e5e9f2;
}

.grid-content {
  margin: 30px 30px;
  border-radius: 4px;
  min-height: 36px;
}

.row-bg {
  padding: 10px 0;
  background-color: #f9fafc;
}

.el-input-length {
  width: 300px;
}
</style>
