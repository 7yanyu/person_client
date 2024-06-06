
import http from '@ohos.net.http';
import { reset } from '../entity/reset';
import { Baseurl } from '../module/BaseUrl';

export function resetPassword(pass:reset):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest = http.createHttp()
    const url=Baseurl()+'employee/setpassword'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(pass)
      }
    )
      .then(response=>{
        if(response.result=='修改成功'){
          resolve(true)
        }else{
          resolve(false)
        }
      })
  })
}