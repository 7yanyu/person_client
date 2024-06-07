import router from '@ohos.router'
import { Employee } from '../entiy/Employee'
@Entry
@Component
struct More_message {
  @State message: string = '公告信息'
  @State employee:Employee=new Employee()
  private swiperController:SwiperController=new SwiperController()
  private list01: Array<message> = [
    new message($r('app.media.duanwu'), '关于2024年端午节放假安排的通知', '尊敬的全体员工，2024年端午节将至，根据国家相关规定，现将放假安排通知如下...'),
    new message($r('app.media.tijian'), '公司年度体检安排', '为了保障员工的健康，公司将于2024年7月15日至20日组织年度体检，具体安排如下...'),
    new message($r('app.media.tijian'), '新员工入职培训通知', '欢迎新员工加入我们的团队！入职培训将于2024年6月10日开始，详细安排如下...'),
    new message($r('app.media.tijian'), '2024年度优秀员工评选活动', '公司将于2024年8月1日启动年度优秀员工评选活动，欢迎大家踊跃参与，具体细则如下...'),
    new message($r('app.media.duanwu'), '2024年Q3季度会议安排', '尊敬的各位同事，2024年第三季度会议将于2024年9月15日在总部会议室召开，请各部门提前准备相关报告...'),
    new message($r('app.media.duanwu'), '2024年安全生产培训', '为了进一步提高员工的安全意识，公司将于2024年10月5日组织安全生产培训，具体安排如下...'),
    new message($r('app.media.duanwu'), '公司年度团建活动通知', '公司将于2024年11月20日组织年度团建活动，欢迎大家积极参与，具体安排如下...'),
    new message($r('app.media.duanwu'), '2024年年终福利发放通知', '尊敬的全体员工，为了感谢大家一年来的辛勤工作，公司将于2024年12月25日发放年终福利，具体安排如下...'),
    new message($r('app.media.duanwu'), '关于2024年公司战略发布会的通知', '公司将于2024年1月10日召开年度战略发布会，届时将公布公司的发展方向和主要目标，请大家准时参加...'),


  ]

  build(){
    Column(){
      Row() {
        Column() {
          Image($r("app.media.back"))
            // .fitOriginalSize(true)
            .width(30)
            .onClick(() => {
              router.back()
            })
        }.width('30%')
        .alignItems(HorizontalAlign.Start)

        Row({ space: 40 }) {
          Text(this.message)
            .fontSize(28)
            .textAlign(TextAlign.Center)

        }

      }.padding({ top: 15 })
        .width('95%')


      Row(){

      }.height('20')
      List({space:10}){
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
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .width('100%')
              .padding({ left: 10, right: 2 })
              .backgroundColor('#fff')
              .borderRadius(8)
              // .backgroundColor(Color.Pink)
            }
          })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .width('90%')







    }.width('100%')
    .height('100%')
    .backgroundColor('#E6E6E6')
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