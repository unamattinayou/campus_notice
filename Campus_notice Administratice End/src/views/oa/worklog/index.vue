
<script lang="js" setup>
import { fetchList, delMaster } from "@/api/oa/worklog";
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { useRoute, useRouter } from 'vue-router'
const route = new useRoute()
const router = new useRouter()

let queryParam = ref({
  pageSize: 10,
  pageNum: 1,
  mobile: null,
  nickName: null,
  total: 0,
})

let resObj = ref({
  listLoading: false,
  list: []
})


const initList = async () => {
  resObj.value.listLoading = true;
  let res = await fetchList(queryParam.value);
  resObj.value.listLoading = false;
  resObj.value.list = res.records;
  // console.log('res.records: ', res.records);
  queryParam.value.total = res.total;
}
initList()

function queryHandle() {
  initList()
}

function restHandle() {
  queryParam.value.nickName = null
  queryParam.value.mobile = null
  initList()
}

function formatDate(date) {
  if (date != null) {
    let d = new Date(date)
    return d.getFullYear() + "-" + d.getMonth() + "-" + d.getDay() + " " + d.getHours() + ":" + d.getMinutes()
  } else {
    return ""
  }
}

function handleSizeChange(val) {
  queryParam.value.pageNum = 1;
  queryParam.value.pageSize = val;
  initList();
}
function handleCurrentChange(val) {
  queryParam.value.pageNum = val;
  initList();
}
function searchWorklogList() {
  initList();
}
function addWorklogHandle() {
  router.push({ path: "/worklog/edit" });
}
function editHandle(row) {
  router.push({ path: "/worklog/edit", query: { id: row.id } })
}

const delHandle = async (row) => {
  const res = await delMaster({ id: row.id })
  console.log('res: ', res);
  if (res == true) {
    ElMessage({
      message: 'ok',
      type: 'success',
    })

    initList()
  }
}
</script>


<template>
  <div class="app-container">
    <el-card style="width: 100%;margin-top: 10px;padding: 5px;" shadow="always">
      <el-form :model="queryParam" ref="queryForm" :inline="true" label-width="68px">
        <el-form-item label="电话号码" prop="mobile">
          <el-input v-model="queryParam.mobile" placeholder="请输入电话号码" clearable />
        </el-form-item>

        <el-form-item label="姓名" prop="nickName">
          <el-input v-model="queryParam.nickName" placeholder="请输入姓名" clearable />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="queryHandle">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="restHandle">重置</el-button>
        </el-form-item>
      </el-form>

      <el-row :gutter="10" class="mb8">
        <el-col :span="22"></el-col>
        <el-col :span="2">
          <el-button type="primary" plain icon="el-icon-plus" @click="addWorklogHandle">新增</el-button>
        </el-col>
      </el-row>
      <div class="table-container">

        <el-table :data="resObj.list" style="width: 100%">
          <el-table-column type="selection" width="60" align="center"></el-table-column>

          <el-table-column prop="id" label="id">
            <template #default="scope">
              {{ scope.row.id }}
            </template>
          </el-table-column>
          <el-table-column prop="nickName" label="姓名">
            <template #default="scope">
              {{ scope.row.nickName }}
            </template>
          </el-table-column>


          <el-table-column prop="mobile" label="联系方式" width="300">
          </el-table-column>
          <el-table-column prop="workdateStr" label="日期" width="180" />
          <!-- <el-table-column label="日期" width="180">
          <template #default="scope">
            {{ formatDate(scope.row.workdate) }}
          </template>
        </el-table-column> -->
          <el-table-column label="操作" align="center">
            <template #default="scope">
              <el-button @click="editHandle(scope.row)">修改</el-button>
              <el-button type="danger" @click="delHandle(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <div class="pagination-container">
          <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange"
            layout="total, sizes,prev, pager, next,jumper" :page-size="queryParam.pageSize" :page-sizes="[1, 10, 15]"
            v-model:current-page="queryParam.pageNum" :total="queryParam.total">
          </el-pagination>
        </div>

      </div>
    </el-card>


  </div>
</template>

<style rel="stylesheet/scss" lang="scss" scoped></style>