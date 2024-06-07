
import http from '@ohos.net.http';
import { Employee } from '../entiy/Employee';
import { Baseurl } from '../module/BaseUrl';

export function FindEmp(id:number):Promise<Employee>{
  return new Promise<Employee>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+`employee/findbyID?id=${id}`

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          console.log('result:'+response.result.toString())
          resolve(JSON.parse(response.result.toString()))
        }
      })
  })
}