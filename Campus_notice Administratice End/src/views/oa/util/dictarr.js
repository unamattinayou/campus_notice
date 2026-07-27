import axios from 'axios'

//  获取下拉选项数据
export let dictDetialArray = []
export const getDictDetailAll = async () => { 
    let res = await axios.get("/oa-api/sysDictDetail/getAll"); 
    dictDetialArray = res.data
    // console.log('***optionsAll***: ', optionsAll );
    localStorage.setItem("dictionary",JSON.stringify(dictDetialArray))
    return dictDetialArray
}
 


export const valueToLabelByDict = (dictId,val) =>{
    let dictionaryObj =  localStorage.getItem('dictionary');   
    let arr = JSON.parse(dictionaryObj)
    let label="" 
    for(let obj of arr){ 
        if(dictId == obj.dictId && obj.value == val){
          label = obj.label
        }
    }
      return label
}

 