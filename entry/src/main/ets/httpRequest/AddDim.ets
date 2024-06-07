import http from '@ohos.net.http';
import { DimUser } from '../entiy/dimission';
import { Baseurl } from '../module/BaseUrl';

export function ADD_dim(dimuser:DimUser):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'dimission/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData: {
          "emp_ID":dimuser.emp_ID,
          "emp_name":dimuser.emp_name,
          "gender":dimuser.gender,
          "process_date":dimuser.process_date,
          "reason":dimuser.reason,
          "dep_ID":dimuser.dep_ID,
          "dep_name":dimuser.dep_name,
          "pos_ID":dimuser.pos_ID,
          "pos_name":dimuser.pos_name,
          "date":dimuser.date,
          "process_state":dimuser.process_state

        }
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
          console.log(JSON.stringify(dimuser))
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log(JSON.stringify(dimuser))

          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}