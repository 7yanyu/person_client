
import http from '@ohos.net.http'
import { empLogin } from '../entity/empLogin'
import { Baseurl } from '../module/BaseUrl'


export function Login(emp:empLogin):Promise<string> {
  return new Promise<string>((resolve,reject)=>{

    let httpRequest=http.createHttp()
    const url=Baseurl()+'employee/login'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(emp)
      }
    )
      .then(response=>{
        if(response.result=='登陆成功'){
          resolve('登陆成功')
        }else {
          resolve('登陆失败')
        }
      })
      .catch(error=>{
        console.log('error message:'+error)
        reject(error)
      })
  })

}