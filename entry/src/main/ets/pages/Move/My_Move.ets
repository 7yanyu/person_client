import router from '@ohos.router'
import {EmployeeMov} from '../../entiy/EmployeeMov'
import {Find_empmov} from  '../../httpRequest/Find_empmov'
import {ADD_Move} from '../../httpRequest/Add_Move'
import {Employee} from '../../entiy/Employee'
import {FindEmp} from  '../../httpRequest/FindEmpByID'
@Entry
@Component
struct My_Move{
  @State message: string = '调动记录'
  @State emp_ID: number = 0
  @State empmovs: EmployeeMov[] = []
  private selectedDate: Date = new Date()
  @State empmov:EmployeeMov=new EmployeeMov(0,0,'',0,'',0,'',0,'',0,'','','','')
  @State queryType: string = '岗位间调动'
  @State employee:Employee=new Employee

  onPageShow() {
    console.log('onInit called');
    const params = router.getParams() as { empmov: string };
    console.log('Params:', params.empmov)
    if (params && params.empmov) {
      const empmovJson = params.empmov;
      console.log('Employee Move JSON1234:', empmovJson);
      try {
        const empmovData = JSON.parse(empmovJson);
        this.emp_ID = empmovData
        this.empmov.emp_ID=empmovData
        FindEmp(this.emp_ID).then(response=>{
          this.employee=response
          console.log(this.employee.emp_name)
          this.empmov.emp_name=this.employee.emp_name
          console.log(this.employee.emp_name)
          this.empmov.before_dep=this.employee.dep_ID
          this.empmov.before_pos=this.employee.pos_ID
        })
        console.log(this.emp_ID.toString())
      } catch (e) {
        console.error('Failed to parse empmov data', e);
      }
    }
  }

  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Column() {
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

              Button('查询')
                .fontColor('black')
                .backgroundColor('#99D9EA')
                .width('20%')
                .fontSize(13)
                .onClick(() => {
                  //清空已有数据
                  this.empmovs = []
                  //根据部门ID进行查询
                  Find_empmov(this.emp_ID).then((empmovs) => {
                    this.empmovs = empmovs
                    console.log(JSON.stringify(this.empmovs, null, 2))
                    console.log(this.empmovs.length.toString())

                  }).catch(error => {
                    console.error('Error fetching department:', error);
                    this.empmovs = []; // 确保在错误情况下清空显示的数据

                  })

                })
            }

          }.padding({ top: 15 })
          .width('90%')

          List({ space: 10 }) {
            ForEach(this.empmovs,
              (empmov: EmployeeMov) => {
                ListItem() {
                  Row({ space: 10 }) {
                    if(this.employee.gender=='男'){
                      Image($r("app.media.boy"))
                        .width(100)
                    }
                    else{
                      Image($r("app.media.girl"))
                        .width(80)
                    }
                    Column() {
                      Text(empmov.movtype)
                        .fontSize(18)
                        .fontColor('#444')
                        .fontWeight(FontWeight.Bold)
                      Text(empmov.mov_date).fontSize(18)
                        .fontColor('#444')
                        .fontWeight(FontWeight.Bold)

                    }
                    .alignItems(HorizontalAlign.Start)
                    Column(){
                      if(empmov.process_state=='已处理')
                      {
                        Text(empmov.process_state).fontSize(18)
                          .fontColor('#659EE8')
                          .fontWeight(FontWeight.Bold)
                      }
                      else if(empmov.process_state=='已拒绝')
                      {
                        Text(empmov.process_state).fontSize(18)
                          .fontColor('red')
                          .fontWeight(FontWeight.Bold)
                      }
                      else{
                        Text(empmov.process_state).fontSize(18)
                          .fontColor('#CCCCCC')
                          .fontWeight(FontWeight.Bold)

                      }

                    }.padding({left:15})
                  }
                  .width('100%')
                  .padding({ left: 14, right: 14 })
                  .backgroundColor('#fff')
                  .borderRadius(8)
                }
              }
            )
          }.width('100%')
           .height('90%')

          .padding({ left: 10, right: 10,top:10 })
          .layoutWeight(1)

        }.height('100%')
        .width('100%')
        .backgroundColor('#E6E6E6')
      }.tabBar('我的记录')

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


            Text('申请调动')
              .fontSize(28)
              .textAlign(TextAlign.Center)


          }.padding({top:15})
          .width('90%')

          Row({space:60}){
            Text('员工姓名')
              .fontSize(20)
           Text(this.empmov.emp_name).fontSize('20').fontColor('#858585').textAlign(TextAlign.Center)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:50}){
            Text('调动类型')
              .fontSize(20)
              .textAlign(TextAlign.Start)

            Select([
              { value: '岗位间调动'},
              { value: '部门间调动' }
            ])
              .selected(0)  // 默认选择为“岗位间调动”
              .font({ size: 18, weight: FontWeight.Medium })
              .fontColor('#7BB6EB')
              .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
              .optionFont({ size: 18, weight: FontWeight.Regular })
              .onSelect((index: number) => {

                this.queryType = index ===0 ? '岗位间调动' : '部门间调动';
                this.empmov.movtype=this.queryType

                console.info('Selected query type:' + this.queryType);
              })


          }
          .width('95%')


          Row({space:70}){
            Text('原部门ID')
              .fontSize(20)
            Text(this.empmov.before_dep.toString()).fontSize('20').fontColor('#858585').textAlign(TextAlign.Center)


          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:15}){
            Text('转入部门ID')
              .fontSize(20)
            TextInput({placeholder:'请输入转入部门ID'})
              .onChange((value)=>{
                const id=parseInt(value)
                this.empmov.after_dep=id
              }) .placeholderColor('#C3C3C3')

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)


          Row({space:75}){
            Text('原岗位ID')
              .fontSize(20)
            Text(this.empmov.before_pos.toString()).fontSize('20').fontColor('#858585').textAlign(TextAlign.Center)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:15}){
            Text('转入岗位ID')
              .fontSize(20)
            TextInput({placeholder:'请输入转入岗位ID'})
              .onChange((value)=>{
                const id=parseInt(value)
                this.empmov.after_pos=id
              }) .placeholderColor('#C3C3C3')

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)
          Row({space:35}){
            Text('调动时间')
              .fontSize(20)

            Button(this.empmov.mov_date|| ' 年 / 月 / 日 ')
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
                    this.empmov.mov_date = `${value.year}-${value.month + 1}-${value.day}`
                  }
                })
              })

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row(){
            Text('调动原因')
              .fontSize(20)

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)
          Row(){
            TextArea({placeholder:'请输入该员工调动的相关原因'})
              .onChange((value)=>{
                this.empmov.reason=value
              })
              .placeholderColor('#C3C3C3')
              .width('90%')
              .height('125')
          }

          Button('提交')
            .onClick(() => {
              //调用接口，调动
              ADD_Move(this.empmov)
                .then((response)=>{
                  if(response.toString()=='添加成功'){
                    AlertDialog.show({
                      title:'提示',
                      message:'申请成功，等待处理',
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



        }.width('100%')
        .height('100%')
        .backgroundImageSize({width:'100%',height:'100%'})

      }.tabBar('申请调动')


    }

  }
}

/*Column() {
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

      Button('查询')
        .fontColor('black')
        .backgroundColor('#99D9EA')
        .width('20%')
        .fontSize(13)
        .onClick(() => {
          //清空已有数据
          this.empmovs = []
          //根据部门ID进行查询
          Find_empmov(this.emp_ID).then((empmovs) => {
            this.empmovs = empmovs
            console.log(JSON.stringify(this.empmovs, null, 2))
            console.log(this.empmovs.length.toString())

          }).catch(error => {
            console.error('Error fetching department:', error);
            this.empmovs = []; // 确保在错误情况下清空显示的数据

          })

        })
    }

  }.padding({ top: 15 })
  .width('90%')

  List({ space: 10 }) {
    ForEach(this.empmovs,
      (empmov: EmployeeMov) => {
        ListItem() {
          Row({ space: 10 }) {
            Image($r('app.media.move'))
              .width(100)
            Column() {
              Text(empmov.movtype)
                .fontSize(18)
                .fontColor('#444')
                .fontWeight(FontWeight.Bold)
              Text(empmov.mov_date).fontSize(18)
                .fontColor('#444')
                .fontWeight(FontWeight.Bold)

            }
            .alignItems(HorizontalAlign.Start)
            Column(){
              if(empmov.process_state=='已处理')
              {
                Text(empmov.process_state).fontSize(18)
                  .fontColor('#659EE8')
                  .fontWeight(FontWeight.Bold)
              }
              else if(empmov.process_state=='已拒绝')
              {
                Text(empmov.process_state).fontSize(18)
                  .fontColor('red')
                  .fontWeight(FontWeight.Bold)
              }
              else{
                Text(empmov.process_state).fontSize(18)
                  .fontColor('#CCCCCC')
                  .fontWeight(FontWeight.Bold)

              }

            }.padding({left:15})
          }
          .width('100%')
          .padding({ left: 14, right: 14 })
          .backgroundColor('#fff')
          .borderRadius(8)
        }
      }
    )
  }
  .padding({ left: 10, right: 10 })
  .layoutWeight(1)

}.height('100%')
.width('100%')
.backgroundColor('#E6E6E6')*/