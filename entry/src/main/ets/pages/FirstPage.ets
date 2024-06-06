import router from '@ohos.router'
import { employee } from '../entity/employee'
@Entry
@Component
struct FirstPage {
  @State message: string = '人事工作台'
  @State employee:employee=new employee()


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
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Column() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)

          /*Row(){
            Text('花名册')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
          }.width('90%')
          Row(){
            Column(){
              Text('在职员工')

            }

            Column(){

            }

            Column(){
              Text('实习生')

            }
          }
          .width('90%')
          .height(200)
          .backgroundColor('red')
          .justifyContent(FlexAlign.SpaceAround)*/

       /*   Text('人事工作台')
            .fontWeight(FontWeight.Bold)
            .margin({top:10})
*/

          Divider()
            .width('100%')
            .strokeWidth(5)
            .margin({top:15,bottom:15})

          Row(){
            Column({space:10}){
              Image($r('app.media.try'))
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/TryPage',
                    params:{
                      'employee':JSON.stringify(this.employee)
                    }
                  })
                })
              Text('转正申请')
                .fontWeight(FontWeight.Bold)
            }

            Column({space:10}){
              Image($r('app.media.move'))
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/MovePage'
                  })
                })
              Text('调动申请')
                .fontWeight(FontWeight.Bold)
            }

            Column({space:10}){
              Image($r('app.media.dimission'))
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/DimissionPage',
                    params:{
                      'employee':JSON.stringify(this.employee)
                    }
                  })
                })
              Text('离职申请')
                .fontWeight(FontWeight.Bold)
            }

          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({bottom:15})

          Row(){
            Column({space:10}){
              Image($r('app.media.holiday'))
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/HolidayPage'
                  })
                })
              Text('请假')
                .fontWeight(FontWeight.Bold)
            }
          }
          .width('90%')


        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E6E6E6')
      }.tabBar({icon:$r('app.media.home'),text:'首页'})

      TabContent(){
        Column(){
          Row(){
            if(this.employee.gender=='男'){
              Image($r('app.media.boy'))
                .width(100)
            }else if(this.employee.gender=='女'){
              Image($r('app.media.girl'))
                .width(100)
            }
            Column({space:10}){
              Text('       姓名:   '+this.employee.emp_name)
              Text('性别:   '+this.employee.gender)
            }
          }
          .height(150)
          .width('90%')

          Column({space:15}){
            Text(`部门id：       ${this.employee.dep_ID}`)
            Text(`部门名称：  ${this.employee.dep_name}`)
            Text(`岗位id：       ${this.employee.pos_ID}`)
            Text(`岗位名称：  ${this.employee.pos_name}`)
            Text(`电话号码：  ${this.employee.dep_ID}`)
            Text(`员工类型：  ${this.employee.emp_type}`)
            if(this.employee.emp_type=='实习生'){
              Text(`实习情况：  ${this.employee.intern_situation}`)
            }


          }
          .width('90%')
          .padding({left:5})
          .alignItems(HorizontalAlign.Start)

          Row({space:10}){
            Image($r('app.media.SetPassword'))
              .width(35)
            Text('重置密码')
              .fontSize(20)

            Blank()
            Image($r('app.media.next'))
              .width(35)
              .margin({right:10})
          }
          .width('90%')
          .backgroundColor('#F2F2F2')
          .margin({top:20})
          .onClick(()=>{
            router.pushUrl({
              url:'pages/ResetPasswordPage',
              params:{
                'employee':JSON.stringify(this.employee)
              }
            })
          })

          Button('退出登陆')
            .width(100)
            .margin(100)
            .onClick(()=>{
              AlertDialog.show({
                title:'提示',
                message:'是否确认退出该账号',
                primaryButton:{
                  value:'否',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'是',
                  action:()=>{
                    router.clear()
                    router.replaceUrl({
                      url:'pages/Index'
                    })
                  }
                }
              })
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E6E6E6')


      }.tabBar({icon:$r('app.media.mine'),text:'我的'})
    }


  }
}