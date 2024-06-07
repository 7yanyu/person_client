import router from '@ohos.router'
import { Employee } from '../entiy/Employee'
import { reset } from '../entiy/reset'
import { resetPassword } from '../httpRequest/ResetPassword'
@Entry
@Component
struct ResetPasswordPage {
  @State message: string = '重置密码'

  @State employee:Employee=new Employee()

  @State Password:string=''
  @State newPassword1:string=''
  @State newPassword2:string=''
  @State resetEmp:reset=new reset()

  @State flag:number=0

  onPageShow(){
    console.log('onInit called'); // 确认 onInit 被调用
    const params=router.getParams() as {employee:string}
    console.log('Params:', params); // 打印整个 params 对象
    if(params && params.employee){
      const employeeJson=params.employee
      console.log('employeeJson:',employeeJson)
      try {
        const employeeData=JSON.parse(employeeJson)
        this.employee=employeeData
        console.log('employee:'+JSON.stringify(this.employee))
      }catch (error){
        console.error('Failed to parse employee data', error);
      }
    }else {
      console.log('not found')
    }
  }


  build() {
    Column({space:20}) {
      Row(){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            router.back()
          })
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({left:70})
      }
      .width('90%')
      .margin({top:10})

      Row(){
        Text('原密码:')
        TextInput({placeholder:'请填写原密码'})
          .onChange(value=>{
            this.Password=value
            if(this.Password!=this.employee.password){
              this.flag=1
            }
          })
      }
      Row(){
        Text('新密码:')
        TextInput({placeholder:'请填写新密码'})
          .onChange(value=>{
            this.newPassword1=value
          })
      }
      Row(){
        Text('确认新密码:')
        TextInput({placeholder:'再次填写确认新密码'})
          .onChange(value=>{
            this.newPassword2=value
            if(this.newPassword2!=this.newPassword1){
              this.flag=2
            }else if(this.Password==this.employee.password&&this.newPassword2==this.newPassword1){
              this.flag=3
            }

          })
      }

      Button('提交')
        .onClick(()=>{
          if(this.flag==3){
            this.resetEmp.emp_ID=this.employee.emp_ID
            this.resetEmp.password=this.newPassword1
            //修改密码
            resetPassword(this.resetEmp)
              .then(response=>{
                if(response){
                  AlertDialog.show({
                    title:'提示',
                    message:'修改成功',
                    primaryButton:{
                      value:'确认',
                      action:()=>{
                        /* router.clear()
                         router.replaceUrl({
                           url:'pages/Index'
                         })*/
                      }
                    }
                  })
                }else{
                  AlertDialog.show({
                    title:'提示',
                    message:'修改失败',
                    primaryButton:{
                      value:'确认',
                      action:()=>{}
                    }
                  })
                }
              })

          }else if(this.flag==1){
            AlertDialog.show({
              title:'提示',
              message:'原密码输入错误',
              primaryButton:{
                value:'确认',
                action:()=>{}
              }
            })
          }else if(this.flag==2){
            AlertDialog.show({
              title:'提示',
              message:'新密码不匹配，请重新填写',
              primaryButton:{
                value:'确认',
                action:()=>{}
              }
            })
          }else{
            AlertDialog.show({
              title:'提示',
              message:'请填写对应信息',
              primaryButton:{
                value:'确认',
                action:()=>{}
              }
            })
          }
        })

    }
    .width('100%')
    .height('100%')
  }
}