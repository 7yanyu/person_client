import http from '@ohos.net.http';
import {EmployeeMov} from  '../entiy/EmployeeMov'
import { Baseurl } from '../module/BaseUrl'
export function ADD_Move(empmov:EmployeeMov):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employeemov/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(empmov),
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