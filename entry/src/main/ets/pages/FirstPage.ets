import router from '@ohos.router'
import { Employee } from '../entiy/Employee'
@Entry
@Component
struct FirstPage {
  @State message: string = '人事工作台'
  @State employee:Employee=new Employee()
  private swiperController:SwiperController=new SwiperController()
  private list01:Array<message>=[
    new message($r('app.media.duanwu'),'    关于2024年端午节放假安排的通知','      尊敬的全体员工，2024年端午节将至，根据国家相关规定，现将放假安排通知如下...'),
    new message($r('app.media.tijian'),'公司年度体检安排','为了保障员工的健康，公司将于2024年7月15日至20日组织年度体检，具体安排如下...'),
  ]


  onClickMovView(empmov:number){
    console.log('查看按钮是否被点击')
    const empmovJson=JSON.stringify(empmov)
    console.log('Encoded Department123: ',empmovJson)
    router.pushUrl({
      url:'pages/Move/My_Move',
      params:{
        empmov:empmovJson
      }
    })
  }

  onClickTryView(emptry:number){
    console.log('查看按钮是否被点击')
    const emptryJson=JSON.stringify(emptry)
    console.log('Encoded Department123: ',emptryJson)
    router.pushUrl({
      url:'pages/Try/My_Try',
      params:{
        emptry:emptryJson
      }
    })
  }
  onClickHolidayView(emphol:number){
    console.log('查看按钮是否被点击')
    const empholJson=JSON.stringify(emphol)
    console.log('Encoded Department123: ',empholJson)
    router.pushUrl({
      url:'pages/Holiday/My_Holiday',
      params:{
        emphol:empholJson
      }
    })
  }
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

          Row(){
            //轮播图
            Swiper(this.swiperController){
              Image($r("app.media.duanwu4"))
                .objectFit(ImageFit.Contain)
              Image($r("app.media.hezuo"))
                .objectFit(ImageFit.Contain)
            }
            .autoPlay(true)
          }
          .width('100%')
          .height(202)

          Row(){

          }.height('40')

          Row(){
            Column({space:10}){
              Image($r('app.media.try'))
                .width(60)
                .onClick(() => this.onClickTryView(this.employee.emp_ID))
              Text('转正申请')
                .fontWeight(FontWeight.Bold)
            }

            Column({space:10}){
              Image($r('app.media.move'))
                .width(60)
                .onClick(() => this.onClickMovView(this.employee.emp_ID))
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
                .onClick(() => this.onClickHolidayView(this.employee.emp_ID))
              Text('请假')
                .fontWeight(FontWeight.Bold)
            }
          }
          .width('90%')
          Column(){
            Text('公告信息')
              .fontWeight(FontWeight.Bold)
              .fontSize(30)

            Row(){
              Blank()
              Text('更多')
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/More_message',
                  })

                })
            }
            .width('90%')
            .margin({bottom:10})
            List({space:20}){
              ForEach(this.list01,
                (item:message)=>{
                  ListItem(){
                    Row(){
                      Image(item.img)
                        .width(100)
                        .width('30%')
                      Column({space:10}){
                        Text(item.msg01).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
                        Text(item.msg02)
                      }
                      .width('60%')
                      .height('15%')
                      .padding({left:10})
                      // .backgroundColor('red')
                      .justifyContent(FlexAlign.SpaceBetween)
                    }
                    .width('100%')
                    // .backgroundColor(Color.Pink)
                  }
                })
            }
            .width('100%')
            .height('100%')
            .layoutWeight(1)
          }.padding({top:2})


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

export class message{
  img:ResourceStr
  msg01:string
  msg02:string

  constructor(img: ResourceStr, msg01: string, msg02: string) {
    this.img=img
    this.msg01=msg01
    this.msg02=msg02
  }
}