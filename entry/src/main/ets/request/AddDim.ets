import http from '@ohos.net.http';
import { DimUser } from '../entity/dimission';
import { Baseurl } from '../module/BaseUrl';

export function ADD_dim(dimuser:DimUser):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'dimission/addDim'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(dimuser)
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