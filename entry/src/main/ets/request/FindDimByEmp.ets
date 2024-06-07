
import http from '@ohos.net.http';
import { DimUser } from '../entity/dimission';
import { Baseurl } from '../module/BaseUrl';

export function findDimByEmp(id:number):Promise<DimUser>{
  return new Promise<DimUser>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'dimission/findbyemp?emp_ID='+id

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          console.log(JSON.parse(response.result.toString()))
          resolve(JSON.parse(response.result.toString()))
        }
      })
  })
}