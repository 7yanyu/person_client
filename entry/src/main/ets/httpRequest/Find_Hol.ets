import http from '@ohos.net.http';
import  {Holiday} from '../entiy/Holiday'
import { Baseurl } from '../module/BaseUrl'
export function Find_hol(emp_ID:number):Promise<Holiday[]>{
  return new Promise<Holiday[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+`holiday/findbyemp?emp_ID=${emp_ID}`

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET,

      }
    )
      .then(response=>{
        if(response.result){
          let responseData=(JSON.parse(response.result.toString()))
          // console.log(responseData)
          if (Array.isArray(responseData)) {
            resolve(responseData);
          } else {
            resolve([responseData]);
          }
        }else{
          reject('请求错误'+response.cookies)
        }
      })
  })
}
export function ADD_Holiday(holiday:Holiday):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/holiday/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(holiday),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}
export function formatDate(dateString) {

    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;

}
