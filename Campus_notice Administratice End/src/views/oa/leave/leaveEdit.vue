<script lang="js" setup>
import { ref, reactive, onMounted, onBeforeMount } from 'vue'
import { getDictDetailByDictId, addLeave, getLeaveById } from "@/api/oa/leave";
import { useRoute, useRouter } from 'vue-router'
import { getUserProfile } from "@/api/system/user"
import axios from 'axios'
const router = useRouter()
const route = useRoute()

//定义响应式变量
const leaveForm = ref({
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
})

// 定义用户信息
const userInfo = ref({})

//获取用户信息
const getUserInfo = async () => {
    userInfo.value = await getUserProfile();
    // console.log('userInfo.value: ', userInfo.value);
    leaveForm.value = userInfo.value.data
    console.log('leaveForm.value: ', leaveForm.value);
    leaveForm.value.userName = userInfo.value.data.nickName
    leaveForm.value.userId = userInfo.value.data.userId
}


// 根据id查询tb_leave数据
const fetchLeaveById = async (val) => {
    let result = await getLeaveById(val);
    leaveForm.value = result
    //第二种写法
    // let result = await axios({
    //     method:'get',
    //     url:'/oa-api/leave/getLeaveById',
    //     params:{
    //         id:val
    //     }
    // })
    // leaveForm.value = result.data 
}


//  获取下拉选项数据
const options = ref([])
const getDictDetail = async () => {
    // http://172.17.10.231:6060/sysDictDetail/getListByDictId?dictId=40
    let result = await getDictDetailByDictId(40);
    console.log('result: ', result);
    options.value = result
}


const save = async () => {
    let result = await addLeave(leaveForm.value)
    console.log('result: ', result);
    if(result){
        router.push({ path: "/oa/leave" })
    }
}




function cancle() {
    router.push({ path: "/oa/leave" })
}




// 执行下拉选项数据
getDictDetail()



onBeforeMount(() => {

    //获取路由id
    let id = route.query.id
    console.log('id: ', id);

    if (id != undefined) {
        //修改
        fetchLeaveById(id)
    } else {     //新增
        // // 执行获取用户信息 并初始化用户id 和 用户姓名

        getUserInfo()
    }
})

</script>


<template>
    <div>
        <h3 style="text-align: center;">学员请假审批单</h3>
        <el-form :model="leaveForm" label-width="auto" style="max-width: 900px; margin: 0 auto;">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="申请人">
                        <el-input v-model="leaveForm.userName"  disabled/>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="请假类别">
                        <el-select v-model="leaveForm.regionId" placeholder="请选请假类别">
                            <el-option v-for="item in options" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-form-item label="开始时间" required>
                    <el-form-item prop="date">
                        <el-date-picker v-model="leaveForm.beginTime" type="date" value-format="YYYY-MM-DD"
                            style="width: 100%;">
                        </el-date-picker>
                    </el-form-item>
                </el-form-item>
                <el-form-item label="结束时间" required>
                    <el-form-item prop="date">
                        <el-date-picker v-model="leaveForm.endTime" type="date" value-format="YYYY-MM-DD"
                            style="width: 100%;">
                        </el-date-picker>
                    </el-form-item>
                </el-form-item>
            </el-row>
            <el-row>
                <el-form-item label="请假理由">
                    <el-input type="textarea" rows="6" v-model="leaveForm.description" style="width: 850px;"></el-input>
                </el-form-item>
            </el-row>

            <el-row>
                <el-col>
                    <el-form-item class="btn">
                        <el-button type="primary" @click="save">保存</el-button>
                        <el-button @click="cancle">返回</el-button>
                    </el-form-item>
                </el-col>
            </el-row>

        </el-form>
    </div>
</template>

<style>
.btn {
    text-align: right;
}

.input,
.select {
    width: 90%;
}
</style>