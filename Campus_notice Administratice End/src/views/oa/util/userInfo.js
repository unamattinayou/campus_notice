import { getUserProfile } from "@/api/system/user"

 
export let userInfo = {}


//获取用户信息
export const getUserInfo = async () => {
    let loginUserInfo  = await getUserProfile(); 
    userInfo = loginUserInfo.data
    let arr = []
    let obj = loginUserInfo.data.roles
    for (let item of obj) {
      arr.push(item.roleId)
    } 
    userInfo.roleIds=arr
    console.log('$$$userInfo:$$ ', userInfo);
    userInfo.password=null
    localStorage.setItem("loginUserInfo",JSON.stringify(userInfo))
    return userInfo
}


 