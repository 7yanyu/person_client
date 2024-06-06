import router from '@ohos.router'
import { DimUser } from '../entity/dimission'
import { employee } from '../entity/employee'
import { ADD_dim } from '../request/AddDim'
@Entry
@Component
struct DimissionPage {
  @State message: string = '离职申请'

  @State dimuser:DimUser=new DimUser()
  @State queryType: string = '男';
  private selectedDate: Date = new Date()

  @State employee:employee=new employee()
  @State empId:string=''


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
        this.dimuser.emp_ID=this.employee.emp_ID
        this.dimuser.emp_name=this.employee.emp_name
        this.empId=this.employee.emp_ID.toString()
        console.log('empId:'+this.empId)
        console.log('employee:'+JSON.stringify(this.employee))
      }catch (error){
        console.error('Failed to parse employee data', error);
      }
    }else {
      console.log('not found')
    }
  }


  build() {
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
        Text(this.empId)


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
  }
}