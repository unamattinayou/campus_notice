<script lang="js" setup>
import { computed, ref, reactive } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()

const toArticlePage = (val) => { 
    if(val != -1){ 
        router.push({ path: '/news/article_edit', query: {id:val} })
    }else{
        router.push({ path: '/news/article_edit' })
    }
   
}

let articleList = ref([])
let pageNo = ref(1)
let pageSize = ref(10)
let total = ref(0)

const getArticleList = async () => {
    let result = await axios({
        method: 'get',
        url: '/oa-api/article/pagesize',
        params: {
            pageNo: pageNo.value,
            pageSize: pageSize.value
        }
    })
    // let result = await axios.get('/oa-api/article/pagesize?pageNo=1&pageSize=10') 
    articleList.value = result.data.list
    total.value = result.data.total
}
getArticleList()

const handleEdit = (index, row) => {
    console.log(index, row)
    toArticlePage(row.id)

}
const handleDelete = async (index, row) => {
    let result =await axios({
        method:'get',
        url:'/oa-api/article/delete',
        params:{
            id: row.id
        }
    })
    console.log('result',result);
    if(result.status==200){
        ElMessage({
            message: result.statusText,
            type: 'success',
        })
    }
    getArticleList()
}

const formatDate = (date) => {
    if (date != null) {
        let d = new Date(date)
        return d.getFullYear() + "-" + d.getMonth() + "-" + d.getDay() + " " + d.getHours() + ":" + d.getMinutes()
    } else {
        return ""
    }
}

const handleSizeChange = (val) => {
    console.log(`${val} items per page`)
      pageSize.value = val
    getArticleList()
}
const handleCurrentChange = (val) => {
    pageNo.value = val
    getArticleList()

}


</script>

<template>
    <div class="article" >
        <el-row :gutter="20">
            <el-col :span="22">
            </el-col>
            <el-col :span="2">
                <el-button type="success" @click="toArticlePage(-1)">添加</el-button>
            </el-col>
        </el-row>

        <el-row :gutter="20">
            <el-table :data="articleList" style="width: 100%">
                <el-table-column label="编号" prop="id" width="180" />
                <el-table-column label="标题" prop="title" width="180" />
                <el-table-column label="分类" width="180">
                    <template #default="scope">
                        {{ scope.row.categoryName }}
                    </template>
                </el-table-column>
                <el-table-column label="创建时间" width="180">
                    <template #default="scope">
                        {{ formatDate(scope.row.createTime) }}
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template #default="scope">
                        <el-button size="small" @click="handleEdit(scope.$index, scope.row)">
                            修改
                        </el-button>
                        <el-button size="small" type="danger" @click="handleDelete(scope.$index, scope.row)">
                            删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-row>
        <el-row :gutter="20">
            <el-col :span="16">
            </el-col>
            <el-col :span="8">
                <el-pagination v-model:current-page="pageNo" :page-size="pageSize" size="default"
                    layout="total, prev, pager, next" :total="total" @size-change="handleSizeChange"
                    @current-change="handleCurrentChange" />
            </el-col>
        </el-row> 
    </div>

</template>


<style>
.el-row {
    margin-bottom: 20px;
}

.el-row:last-child {
    margin-bottom: 0;
}

.el-col {
    border-radius: 4px;
}

.grid-content {
    border-radius: 4px;
    min-height: 36px;
}

.article{
    padding: 50px;
}

</style>