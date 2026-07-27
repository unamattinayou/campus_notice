
<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import http from '@/utils/requestcafuc'
import { reactive } from 'vue'
import { useRouter  } from 'vue-router'

const router = useRouter()

const pmsProductForm = reactive({ 
  name: '',
  deleteStatus: 0, 
  newStatus: 0, 
  originalPrice: 0,
  pic: '', 
  price: null, 
  productCategoryName: '', 
  productCategoryId: '',
  brandId: '',
  brandName: '',
  publishStatus: '', 
  subTitle: '', 
  productSn: 0
})

const imageUrl = ref('') 
//品牌列表
const optionsBrand = ref([])

const handleAvatarSuccess = (response, uploadFile) => { 
  imageUrl.value = URL.createObjectURL(uploadFile.raw) 
    let path = response.path 
    let subpath = path.slice(14);    
    let pic = subpath.replace(/\\/g, "/");   //转义字符
    pmsProductForm.pic = pic.value 
}

const beforeAvatarUpload = (rawFile) => {
  if (rawFile.type !== 'image/jpeg') {
    ElMessage.error('文件必须为 JPG 格式!')
    return false
  } else if (rawFile.size / 1024 / 1024 > 20) {
    ElMessage.error('Avatar picture size can not exceed 2MB!')
    return false
  }
  return true
}




const optionCategory=ref([])
const loadCategory = async () =>{
    let res = await http({
        url: '/pmsProductCategory/nodelist' 
    })  
    optionCategory.value = res   
    

}

const loadBrand = async () =>{
    let res = await http({
        url: '/pmsBrand/list' 
    })  
    let brandArr = res    

    /*
    //语法一：
    let obj = new Object(); 
    for(let obj of brandArr){
        let newobj = new Object();
        newobj.value = obj.id
        newobj.label = obj.name 
        optionsBrand.value.push(newobj) 
    } 
        */

        /** 语法二： */
    optionsBrand.value = brandArr.map(( obj) => ({
      value: `${obj.id}`,
      label: `${obj.name}`,
    }))

}

const onSubmit = async () =>{ 
  console.log('pmsProductForm: ', pmsProductForm);
     let res = await http({
        url: '/product/save',
        method: 'post',
        data: pmsProductForm
    })   
    console.log('res: ', res);
}

function onBack(){
  router.push({path: '/shopping/product/list'})
}

function handleChange(v){
  console.log('v: ', v[v.length-1]);   
  pmsProductForm.productCategoryId = v[v.length-1] 
}

onMounted(()=>{
loadCategory()
loadBrand() 
})

</script>


<template>
<div id="product">
  <el-form :model="pmsProductForm" label-width="auto" style="max-width: 600px">
    <el-form-item label="商品名称">
      <el-input v-model="pmsProductForm.name" />
    </el-form-item>
    <el-form-item>
      <el-upload
        class="avatar-uploader"
        action="/capi/file/upload"
        :show-file-list="false"
        :on-success="handleAvatarSuccess"
        :before-upload="beforeAvatarUpload"
      >
        <img v-if="imageUrl" :src="imageUrl" class="avatar" />
        <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
      </el-upload>
    </el-form-item>
    <el-form-item label="商品价格">
      <el-input  v-model="pmsProductForm.price" placeholder="请输入价格"/>
    </el-form-item>
    <el-form-item  label="商品分类"> 
      <el-cascader
      v-model="value"
      :options="optionCategory"
      :props="props"
      @change="handleChange"
    /> 
    </el-form-item>
    <el-form-item label="品牌"> 
      <el-select-v2
        v-model="pmsProductForm.brandId"
        placeholder="请选择品牌"
        :options="optionsBrand"
      />   
    </el-form-item>
    <el-form-item label="发布状态">
      <el-select v-model="pmsProductForm.publishStatus " placeholder="请选择状态">
        <el-option label="上架" value="1" />
        <el-option label="下架" value="0" />
      </el-select>
    </el-form-item>
 
    <el-form-item>
      <el-button type="primary" @click="onSubmit">保存</el-button>
      <el-button @click="onBack">返回</el-button>
    </el-form-item>
  </el-form>
</div>
</template>

<style scoped>
.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
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

 
#product{
    padding: 20px;
} 
</style>
