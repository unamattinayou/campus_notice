import { getUserProfile } from "@/api/system/user"

export const useCounterStore = defineStore('datastore', {
  state: () => {
    return { userInfo: {} }
  },
  // 也可以这样定义
  // state: () => ({ count: 0 })
  actions: {
    async fetchUserInfo() {  
       let res = await getUserProfile() 
       this.userInfo = res.data
       let arr = [] 
       for (let item of res.data.roles) {
        console.log('item: ', item); 
        arr.push(item.roleId)
      } 
      this.userInfo.roleIds = arr 
    },
  },
})
  