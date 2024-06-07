import http from '@ohos.net.http';
import  {Movtime} from '../entiy/Movtime'
import  {EmployeeMov} from  '../entiy/EmployeeMov'
import { Baseurl } from '../module/BaseUrl'
export function Find_empmov(emp_ID:number):Promise<EmployeeMov[]>{
  return new Promise<EmployeeMov[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'employeemov/findby'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:{
          emp_ID:emp_ID
        }
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
