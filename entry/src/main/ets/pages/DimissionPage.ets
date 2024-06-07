import router from '@ohos.router'
import { DimUser } from '../entiy/dimission'
import { Employee } from '../entiy/Employee'
import { ADD_dim } from '../httpRequest/AddDim'
import { findDimByEmp } from '../httpRequest/FindDimByEmp'
@Entry
@Component
struct DimissionPage {
  @State message: string = '离职申请'

  @State dimuser:DimUser=new DimUser()
  @State queryType: string = '男';
  private selectedDate: Date = new Date()

  @State employee:Employee=new Employee()
  @State empId:number=0
  @State dimId:string=''
  @State application:boolean=false


  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { employee: string };
    console.log('Params:', JSON.stringify(params)); // 打印整个 params 对象
    if (params && params.employee) {
      const employeeJson = params.employee;
      console.log('employeeJson:', employeeJson);
      try {
        const employeeData = JSON.parse(employeeJson);
        this.employee = employeeData;
        this.dimuser.emp_ID = this.employee.emp_ID;
        this.dimuser.emp_name = this.employee.emp_name;
        this.empId = this.employee.emp_ID;
        console.log('empId:' + this.dimuser.emp_ID);
        console.log('employee:' + JSON.stringify(this.employee));
        findDimByEmp(this.dimuser.emp_ID)
          .then(response => {
            this.dimuser = response;
            console.log('Response:', JSON.stringify(response));
            this.dimId = response.dim_ID.toString();
            console.log(this.dimuser.process_state)
          })
          .catch(error => {
            console.error('Error fetching dimission data:', error);
          });
        console.log('dimission:' + JSON.stringify(this.dimuser));
        console.log(this.dimId);
      } catch (error) {
        console.error('Failed to parse employee data', error);
      }
    } else {
      console.log('not found');
    }
  }


  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Column() {
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

            Text(this.message)
              .fontSize(30)
              .textAlign(TextAlign.Center)

          }
          .padding({left:10,top:15})
          .width('100%')

          Divider()

          Image($r('app.media.dim'))
            .width(360)
            .margin({top:5,bottom:20})

          if(this.dimuser.process_state){
            Column(){
              Row(){
                if(this.employee.gender=='男'){
                  Image($r('app.media.boy'))
                    .width(100)
                    .margin({left:20,right:10})
                }else if(this.employee.gender=='女'){
                  Image($r('app.media.girl'))
                    .width(100)
                    .margin({left:20,right:10})
                }
                Text(`        亲爱的${this.employee.emp_name}，很遗憾听到您决定离开我们共事的地方。感谢您一直以来的辛勤工作和贡献。您的专业和敬业精神将被深深怀念。祝愿您在未来的职业生涯中取得更大的成就！
        祝好，${this.employee.emp_name}`)
                  .width('60%')
              }
              .width('100%')
              .margin({top:20,bottom:20})
              .backgroundColor('white')

              if(this.dimuser.process_state){
                Row(){
                  Text('处理序号：    '+this.dimId)
                  if(this.dimuser.process_state=='待处理'){
                    Image($r('app.media.ing'))
                      .width(100)
                      .margin({left:20,right:10})
                  }else if(this.dimuser.process_state=='已拒绝'){
                    Image($r('app.media.reject'))
                      .width(100)
                      .margin({left:20,right:10})
                  }else {
                     Image($r('app.media.agree'))
                      .width(100)
                      .margin({left:20,right:10})
                  }
                }
                .justifyContent(FlexAlign.SpaceAround)
              }

            }
          }



        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E6E6E6')
      }.tabBar('公告信息')

      TabContent(){
        Column({space:15}) {
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

            Text(this.message)
              .fontSize(30)
              .textAlign(TextAlign.Center)

          }
          .padding({top:15})
          .width('90%')

          Row({space:30}){
            Text('员工ID')
              .fontSize(20)
            Text(this.empId.toString())


          }
          .width('95%')
          .justifyContent(FlexAlign.Start)


          Row({space:15}){
            Text('员工姓名')
              .fontSize(20)
            TextInput({placeholder:'请输入员工姓名',text:this.employee.emp_name})
              .onChange((value)=>{
                this.dimuser.emp_name=value
              }) .placeholderColor('#C3C3C3')
          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:50}){
            Text('员工性别')
              .fontSize(20)
              .textAlign(TextAlign.Start)

            Select([
              { value: '男'},
              { value: '女' }
            ])
              .value(this.employee.gender)
                // .selected(0)  // 默认选择为“男”
              .font({ size: 18, weight: FontWeight.Medium })
              .fontColor('#7BB6EB')
              .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
              .optionFont({ size: 18, weight: FontWeight.Regular })
              .onSelect((index: number) => {

                this.queryType = index ===0 ? '男' : '女';
                this.dimuser.gender=this.queryType

                console.info('Selected query type:' + this.queryType);
              })


          }
          .width('95%')

          Row({space:15}){
            Text('原岗位名称')
              .fontSize(20)
            TextInput({placeholder:'请输入员工原岗位名称',text:this.employee.pos_name})
              .onChange((value)=>{
                this.dimuser.pos_name=value
              }) .placeholderColor('#C3C3C3')

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:15}){
            Text('原部门名称')
              .fontSize(20)
            TextInput({placeholder:'请输入员工原部门名称',text:this.employee.dep_name})
              .onChange((value)=>{
                this.dimuser.dep_name=value
              }) .placeholderColor('#C3C3C3')

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:20}){
            Text('离职日期')
              .fontSize(20)

            Button(this.dimuser.process_date|| ' 年 / 月 / 日 ')
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
                    this.dimuser.process_date = `${value.year}-${value.month + 1}-${value.day}`
                  }
                })
              })

          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row(){
            Text('离职原因')
              .fontSize(20)
          }
          .width('95%')
          .justifyContent(FlexAlign.Start)
          Row(){
            TextArea({placeholder:'请输入该员工离职的相关原因'})
              .onChange((value)=>{
                this.dimuser.reason=value
              })
              .placeholderColor('#C3C3C3')
              .width('90%')
              .height('150')
          }


          Button('提交')
            .onClick(() => {
              //调用接口，离职
              this.dimuser.gender=this.employee.gender
              this.dimuser.pos_name=this.employee.pos_name
              this.dimuser.pos_ID=this.employee.pos_ID
              this.dimuser.dep_ID=this.employee.dep_ID
              this.dimuser.dep_name=this.employee.dep_name
              this.dimuser.process_state='待处理'
              this.dimuser.date=this.employee.date

              ADD_dim(this.dimuser)
                .then((response)=>{
                  if(response.toString()=='添加成功'){
                    AlertDialog.show({
                      title:'提示',
                      message:'申请成功',
                      primaryButton:{
                        value:'确认',
                        action:()=>{
                          this.application=true
                          findDimByEmp(this.dimuser.emp_ID).then(response=>{
                            this.dimuser.dim_ID=response.dim_ID
                            this.dimId=response.dim_ID.toString()
                          })
                          router.back()
                        }
                      }
                    })
                  }
                })
            })
            .fontColor('black')
            .backgroundColor('#99D9EA')
            .width(100)
            .margin(20)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E6E6E6')
      }.tabBar('申请')
    }

  }
}