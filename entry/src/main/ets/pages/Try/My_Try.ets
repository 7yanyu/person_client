import router from '@ohos.router'
import {FindEmp} from  '../../httpRequest/FindEmpByID'
import {Employee} from '../../entiy/Employee'
import {Process} from '../../entiy/Process'
import {ADD_Try} from '../../httpRequest/Add_Try'
@Entry
@Component
struct My_Try{
  @State message: string = '消息通知'
  @State emp_ID: number = 0
  @State employee:Employee=new Employee
  @State process:Process=new Process()
  private selectedDate: Date = new Date()

  onPageShow() {
    console.log('onInit called');
    const params = router.getParams() as { emptry: string };
    console.log('Params:', params.emptry)
    if (params && params.emptry) {
      const emptryJson = params.emptry;
      console.log('Employee Move JSON1234:', emptryJson);
      try {
        const emptryData = JSON.parse(emptryJson);
        this.emp_ID = emptryData
        this.process.id=this.emp_ID
        console.log('process'+this.process.id.toString())
        FindEmp(this.emp_ID).then(response=>{
          this.employee=response
          console.log(this.employee.emp_name)
          console.log('Employee Confirm Process:', this.employee.confirm_process);

        })
        console.log(this.emp_ID.toString())
      } catch (e) {
        console.error('Failed to parse empmov data', e);
      }
    }
  }
  build(){
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
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

            Text(this.message)
              .fontSize(28)
              .textAlign(TextAlign.Center)



          }.padding({ top: 15,bottom:20 })
          .width('90%')

          Column(){

            Row({space:10}){
              Image($r("app.media.welcome1"))
                .width(100)
              Column({space:20}){
                Text('    恭喜你正式步入职场！愿你在新的岗位上大放异彩，不断成长和进步。期待你的精彩表现，加油！！').fontSize('20').textAlign(TextAlign.Start)
                Text(this.employee.date).fontSize('15').textAlign(TextAlign.End)
              }.width('60%')


            }.width('100%')

          } .width('95%')
          .height('25%')
          .padding({ left: 14, right: 14 ,top:20,bottom:30})
          .backgroundColor('#fff')
          .borderRadius(8)

          Column(){

          }.height('25')


          if(this.employee.confirm_process=='已处理'){
            Column(){

              Row({space:10}){
                if(this.employee.gender=='男'){
                  Image($r("app.media.boy"))
                    .width(100)
                    .height(110)
                }
                else{

                  Image($r("app.media.girl"))
                    .width(100)
                    .height(110)
                }
                Column({space:20}){
                  Text('     恭喜你顺利转正，这是你辛勤付出的回报，也是你职业生涯的新起点，祝你一帆风顺，步步高升！').fontSize('20').textAlign(TextAlign.Start)
                  Text(this.employee.confirm_date).fontSize('15').textAlign(TextAlign.End)
                }.width('60%')


              }.width('100%')

            } .width('95%')
            .height('25%')
            .padding({ left: 14, right: 14 ,top:20})
            .backgroundColor('#fff')
            .borderRadius(8)



          }
          else if(this.employee.confirm_process=='待处理'){
            Column(){
              Row({space:10}){
                Image($r("app.media.boy"))
                  .width(100)
                Column({space:20}){
                  Text(' 你的转正申请正在处理，请耐心等待回复').fontSize('20').textAlign(TextAlign.Start).fontColor('#BFBFBF')
                  Text(this.employee.confirm_date).fontSize('15').textAlign(TextAlign.End)
                }.width('60%')


              }.width('100%')

            }.width('95%')
            .height('22%')
            .padding({ left: 14, right: 14 ,top:20})
            .backgroundColor('#fff')
            .borderRadius(8)

          }
          else if(this.employee.confirm_process=='已拒绝'){
            Column(){

              Row({space:10}){
                Image($r("app.media.boy"))
                  .width(100)
                .height(125)
                Column({space:20}){
                  Text('    非常感谢您在试用期内的辛勤工作和贡献,我们对您在此期间的表现给予了高度关注,并对您的努力表示诚挚的感谢,经过认真评估和综合考虑，公司决定目前不予转正').fontSize('20').textAlign(TextAlign.Start)
                  Text(this.employee.confirm_date).fontSize('15').textAlign(TextAlign.End)
                }.width('60%')


              }.width('100%')

            } .width('95%')
            .height('35%')
            .padding({ left: 14, right: 14 ,top:20})
            .backgroundColor('#fff')
            .borderRadius(8)

          }



        }.height('100%')
        .width('100%')
        .backgroundColor('#E6E6E6')



      }.tabBar('转正记录')

      TabContent(){
        Column({space:15}){
          Row(){
            Column(){
              Image($r("app.media.back"))
                // .fitOriginalSize(true)
                .width(30)
                .onClick(()=>{
                  router.back()
                })
            }.width('30%')
            .alignItems(HorizontalAlign.Start)


            Text('申请转正')
              .fontSize(28)
              .textAlign(TextAlign.Center)

          }.padding({top:15})
          .width('90%')

          Row({space:60}){
            Text('员工姓名')
              .fontSize(20)
            Text(this.employee.emp_name).fontSize('20').fontColor('#858585').textAlign(TextAlign.Center)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:60}){
            Text('入职时间')
              .fontSize(20)
            Text(this.employee.date).fontSize('20').fontColor('#858585').textAlign(TextAlign.Center)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:30}){
            Text('部门ID(名称):')
              .fontSize(20)
            Text(`${this.employee.dep_ID} (${this.employee.dep_name})`).fontSize('20').fontColor('#858585').textAlign(TextAlign.Start)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:30}){
            Text('岗位ID(名称):')
              .fontSize(20)
            Text(`${this.employee.pos_ID} (${this.employee.pos_name})`).fontSize('20').fontColor('#858585').textAlign(TextAlign.Start)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)


          Row({space:35}){
            Text('转正时间：')
              .fontSize(22)

            Button(this.process.date|| ' 年 / 月 / 日 ')
              .backgroundColor('#F5F5F5')
              .fontColor('#459ED4')
              .onClick(() => {
                DatePickerDialog.show({
                  start: new Date("2000-1-1"),
                  end: new Date("2100-12-31"),
                  selected: this.selectedDate,
                  onAccept: (value: DatePickerResult) => {
                    // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                    this.selectedDate.setFullYear(value.year, value.month, value.day)
                    console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                    this.process.date = `${value.year}-${value.month + 1}-${value.day}`
                  }
                })
              })

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Button('提交')
            .onClick(() => {
              //调用接口，调动
              ADD_Try(this.process)
                .then((response)=>{
                  if(response.toString()=='已成功发出申请'){
                    AlertDialog.show({
                      title:'提示',
                      message:'已成功申请，请等待处理',
                      primaryButton:{
                        value:'返回',
                        action:()=>{
                          router.back()
                        }
                      },

                    })
                  }
                  else{
                    AlertDialog.show({
                      title:'提示',
                      message:'实习时间不足三个月,申请失败',
                      primaryButton:{
                        value:'返回',
                        action:()=>{
                          router.back()
                        }
                      },

                    })

                  }
                })


            })
            .fontColor('black')
            .backgroundColor('#99D9EA')
            .width(100)
            .margin(20)



















        }.height('100%')
        .width('100%')
        .backgroundColor('#E6E6E6')



      }.tabBar('申请转正')


    }







  }

}