<script lang="js" setup>
import { reactive, ref } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'
import { useRoute } from 'vue-router'
const route = useRoute()


const imageUrl = ref('') 
const form = ref({
    id: 0,
    content: '',
    categoryAlias: '',
    coverImg: '',
    title: '',
    categoryId: null,
    createUser: 1,
    createTime: '',
    updateTime: '',
})

const categories = ref([])
const getCategories = async () => {
    let result = await axios.get("/oa-api/category/list")
    console.log('result: ', result);
    categories.value = result.data
}
getCategories()



const getArgicleById= async(articleId)=>{
    let result = await axios({
        method: 'get',
        url:'/oa-api/article/getbyid',
        params:{
            id: articleId
        }
    })
 
    // form.title = result.data.title
    // form.id = result.data.id
    // form.categoryId = result.data.categoryId
    // form.content = result.data.content

    form.value = result.data

    imageUrl.value = "http://172.17.10.231/article_img/"+ result.data.coverImg 
    console.log('result.data.title: ', result.data.title);
    console.log('result: ', result);
}
const article_id = route.query.id
getArgicleById(article_id)


const onSave = async () => {
  
    if (form.categoryId == null && form.categoryId != undefined) {
        alert("分类不能为空！")
        return;
    }

    if(article_id!=null && article_id !=undefined){
        // 修改
        let result = await axios({
            method: 'post',
            url: "/oa-api/article/update",
            data: form.value
        })
        if (result.status) {
            ElMessage({
                message: '修改成功！.',
                type: 'success',
            })
        }
        return
    }

    let result = await axios({
        method: 'post',
        url: "/oa-api/article/save",
        data: form.value
    })

    if (result.status) {
        ElMessage({
            message: '保存成功！.',
            type: 'success',
        })
    }
}

const back = () => {
    router.push({ path: '/news/article' })
}


import { Plus } from '@element-plus/icons-vue'

// import { UploadProps } from 'element-plus'



const handleAvatarSuccess = (
    response,
    uploadFile
) => {
    console.log("***",uploadFile.response);
    // form.coverImg = uploadFile.response   //      /api/upload
    form.value.coverImg = uploadFile.response.filename   //    /fileapi/FILE/upload/article_img
    imageUrl.value = URL.createObjectURL(uploadFile.raw)
}

const beforeAvatarUpload = (rawFile) => {
    if (rawFile.type !== 'image/png') {
        ElMessage.error('请上传png格式的图片!')
        return false
    } else if (rawFile.size / 1024 / 1024 > 2) {
        ElMessage.error('文件大小不能超过 2MB!')
        return false
    }
    return true
}

</script>


<template>
<div class="article"> 
    <el-form :model="form" label-width="auto">
        <el-form-item label="标题" style="max-width: 300px">
            <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="分类" style="max-width: 300px">
            <el-select v-model="form.categoryId" placeholder="请选择分类">
                <el-option v-for="item in categories" :key="item.id" :label="item.categoryName" :value="item.id" />
            </el-select>
        </el-form-item>
        <!-- action="/api/upload" -->
        <el-form-item label="封面">
            <el-upload class="avatar-uploader" 
            action="/fileapi/FILE/upload/article_img"
                :show-file-list="false" 
                :on-success="handleAvatarSuccess" 
                :before-upload="beforeAvatarUpload">
                <img v-if="imageUrl" :src="imageUrl" class="avatar" />
                <el-icon v-else class="avatar-uploader-icon">
                    <Plus />
                </el-icon>
            </el-upload>
        </el-form-item>

        <el-form-item label="内容">

            <div class="editor">
                <quill-editor toolbar="full" theme="snow" v-model:content="form.content"
                    contentType="html"></quill-editor>

            </div>

        </el-form-item>
        <el-form-item>

        </el-form-item>
    </el-form>




    <el-row :gutter="20">
        <el-col :span="10">
            <div class="grid-content ep-bg-purple" />
        </el-col>
        <el-col :span="2">
            <div class="grid-content ep-bg-purple" />
            <div class="btn">
                <el-button type="primary" @click="onSave">保存</el-button> 
            </div>
        </el-col>
        <el-col :span="2">
            <div class="grid-content ep-bg-purple" />
            <div class="btn"> 
                <el-button @click="back">返回</el-button>
            </div>
        </el-col>
        <el-col :span="10">
            <div class="grid-content ep-bg-purple" />
        </el-col>
    </el-row>
    </div>
</template>



<style lang="scss" scoped>
.editor {
    width: 100%;
    height: 300px;

}

.btn {
    margin-top: 30px;
}

.avatar-uploader .avatar {
    width: 178px;
    height: 178px;
    display: block;
}

.article{
    padding: 50px;
}
</style>

<style>
.avatar-uploader .el-upload {
    border: 1px dashed var(--el-border-color);
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
    border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    text-align: center;
}
 
</style>