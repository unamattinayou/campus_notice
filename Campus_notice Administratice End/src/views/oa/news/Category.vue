<template>
    <div class="article">

        <el-button type="success" @click="addCategoryDiaglog">添加</el-button>

        <el-table :data="categories" style="width: 100%">
            <el-table-column label="分类编号" prop="id" width="100px" />
            <el-table-column label="分类名称" prop="categoryName" width="200px" />
            <el-table-column align="right" width="300px">
                <template #header>
                    <el-input v-model="search" size="small" placeholder="Type to search" />
                </template>
                <template #default="scope">
                    <el-button size="small" @click="handleUpdate(scope.$index, scope.row)">
                        修改
                    </el-button>
                    <el-button size="small" type="danger" @click="handleDelete(scope.$index, scope.row)">
                        删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <el-dialog v-model="dialogFormVisible" title="请输入信息" width="500">
            <el-form :model="form">
                <el-form-item label="分类名称" :label-width="formLabelWidth">
                    <el-input v-model="form.categoryName" autocomplete="off" />
                </el-form-item>
                <el-form-item label="分类别名" :label-width="formLabelWidth">
                    <el-input v-model="form.categoryAlias" autocomplete="off" />
                </el-form-item>

            </el-form>
            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取消</el-button>
                    <el-button type="primary" @click="editCategory">
                        确认
                    </el-button>
                </div>
            </template>
        </el-dialog>

    </div>
</template>

<script lang="js" setup>
import { computed, ref, reactive } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const search = ref('')





const categories = ref([])
const getCategories = async () => {
    let result = await axios.get("/oa-api/category/list")
    console.log('result: ', result);
    categories.value = result.data
}
getCategories()


const dialogFormVisible = ref(false)
const formLabelWidth = '140px'

const form = ref({
    id: null,
    categoryName: "",
    categoryAlias: "",
    createUser: 1,
    createTime: null,
    updateTime: null
})
const editStatus = ref("")


const addCategoryDiaglog = () => {
    dialogFormVisible.value = true
    editStatus.value = "save"
}

const saveCategory = async () => {
    // 保存数据
    let result = await axios({
        method: 'post',
        url: '/oa-api/category/save',
        data: form.value
    })

    //增加提示信息
    if (result.status == 200) {
        ElMessage({
            message: '保存成功！.',
            type: 'success',
        })
        getCategories()
    }
    //关闭对话框
    dialogFormVisible.value = false
}

const updateCategory = async () => {
    let result = await axios({
        method: 'post',
        url: '/oa-api/category/update',
        data: form.value
    })


    //增加提示信息
    if (result.status == 200) {
        ElMessage({
            message: '修改成功！.',
            type: 'success',
        })
        getCategories()
    }
    //关闭对话框
    dialogFormVisible.value = false
}

const editCategory = () => {
    if (editStatus.value == "save") {
        saveCategory()
    } else if (editStatus.value == "update") {
        updateCategory()
    }
}


// 修改数据
const handleUpdate = async (index, row) => {
    console.log(index, row)
    editStatus.value = "update"
    //打开对话框
    dialogFormVisible.value = true
    form.value = row

}

// 删除数据
const handleDelete = async (index, row) => {
    console.log('row: ', row);
    let result = await axios.get("/oa-api/category/delete?id=" + row.id)
    getCategories()
}



</script>

<style scoped>
.article{
    padding: 50px;
}
</style>