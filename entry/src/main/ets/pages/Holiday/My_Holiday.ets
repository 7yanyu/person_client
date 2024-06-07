import router from '@ohos.router'
import {FindEmp} from  '../../httpRequest/FindEmpByID'
import {Employee} from '../../entiy/Employee'
import {Holiday} from '../../entiy/Holiday'
import {Find_hol} from '../../httpRequest/Find_Hol'
import {formatDate} from '../../httpRequest/Find_Hol'
import {ADD_Holiday} from '../../httpRequest/Find_Hol'
@Entry
@Component
struct My_Holiday{
  @State message: string = '申请列表'
  @State emp_ID: number = 0
  @State employee:Employee=new Employee
  @State holidays:Holiday[]=[]
  @State holiday:Holiday=new Holiday()
  @State queryType: string = '年假'
  private selectedDate: Date = new Date()
  private selectedDate1: Date = new Date()
  @State start_time:string=''
  @State end_time:string=''
  onPageShow() {
    console.log('onInit called');
    const params = router.getParams() as { emphol: string };
    console.log('Params:', params.emphol)
    if (params && params.emphol) {
      const empholJson = params.emphol;
      console.log('Employee Move JSON1234:', empholJson);
      try {
        const empmovData = JSON.parse(empholJson);
        this.emp_ID = empmovData
        Find_hol(this.emp_ID).then(response=>{
          this.holidays=response
          console.log(JSON.stringify(this.holidays, null, 2))
          console.log(this.holidays.length.toString())
        })

        FindEmp(this.emp_ID).then(response=>{
          this.employee=response
          console.log(this.employee.emp_name)
        })

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

           Row({ space: 40 }) {
             Text(this.message)
               .fontSize(28)
               .textAlign(TextAlign.Center)

           }

         }.padding({ top: 15 })
         .width('90%')
         Column(){
           Row({space:20}){
             Image($r("app.media.holiday")).width(40)
             Row(){
               Text('年假:  ').fontSize('18')
               if(this.employee.annual_holiday){
                 Text(this.employee.annual_holiday.toString()+'天').fontSize('18')
               }
             }.width('25%')
            Row(){
              Text('调休假:  ').fontSize('18')
              if(this.employee.lieu_holiday){
                Text(this.employee.lieu_holiday.toString()+'天').fontSize('18')
              }
            }




           }.width('90%')
         }.height('10%')
          .padding({top:16})

         List({ space: 10 }) {
           ForEach(this.holidays,
             (holiday: Holiday) => {
               ListItem() {
                 Column({ space: 10 }) {
                   Row({ space: 150}) {
                     Row({space:10}){
                       Image($r('app.media.yuan')).width(20)
                       Text(holiday.type)
                         .fontSize(20)
                         .fontWeight(FontWeight.Bold)
                         .fontColor('#333');
                     }
                     Text(holiday.process_state)
                       .fontSize(18)
                       .fontColor(       holiday.process_state == '待处理' ? '#FF9900' :
                           holiday.process_state == '已处理' ? '#659EE8' :
                             holiday.process_state == '已拒绝' ? '#FF0000':
                             '#000000' )
                   }.width('100%')
                   Row(){
                     Text(formatDate(holiday.start_date)+'——'+formatDate(holiday.end_date))
                       .fontSize(15)
                       .fontColor('#666');
                   }.width('95%')
                    .padding({top:5})
                   if(holiday.process_date){
                     Row(){
                       Text(`审批时间：${holiday.process_date}`)
                         .fontSize(14)
                         .fontColor('#999');
                     }.width('95%')
                   }

                   }

                 .padding({ left: 14, right: 14, top: 10, bottom: 10 })
                 .backgroundColor('#fff')
                 .borderRadius(8)
                 .height('100')
               }
             });
         }
         .width('100%')
         .height('90%')
         .padding({ left: 10, right: 10, top: 10 })
         .layoutWeight(1);



       }.height('100%')
       .width('100%')
       .backgroundColor('#E6E6E6')

     }.tabBar('我的记录')
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


           Row({ space: 15 }) {
             Image($r("app.media.holiday1"))
               .width(35)
             Text('请假')
               .fontSize(28)
               .textAlign(TextAlign.Center)
           }

         }.padding({ top: 15 })
         .width('90%')
         Row(){}.height('15')
         Column(){

           Row({space:45}) {
             Row({space:5}){
               Text('*')
                 .fontSize(22)
                 .fontColor('#FF0000')
               Text('请假类型')
                 .fontSize(20)
             }.width('35%')


             Select([
               { value: '年假'},
               { value: '调休' }
             ])
               .value('请选择')
               .selected(0)  // 默认选择为“年假”
               .font({ size: 18, weight: FontWeight.Medium })
               .fontColor('#7BB6EB')
               .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
               .optionFont({ size: 18, weight: FontWeight.Regular })
               .onSelect((index: number) => {

                 this.queryType = index ===0 ? '年假' : '调休';
                 this.holiday.type=this.queryType
                 console.info('Selected query type:' + this.holiday.type);
               })
           }.width('80%')

           Row({space:45}) {
             Row({ space: 5 }) {
               Text('*')
                 .fontSize(22)
                 .fontColor('#FF0000')
               Text('开始时间')
                 .fontSize(20)
             }.width('33%')


             Button(this.start_time || ' 请选择 ')
               .backgroundColor('#F5F5F5')
               .fontColor('#459ED4')
               .onClick(() => {
                 DatePickerDialog.show({
                   start: new Date("2000-1-1"),
                   end: new Date("2100-12-31"),
                   selected: this.selectedDate,
                   onAccept: (dateValue: DatePickerResult) => {
                     // 保存日期选择
                     const selectedDate = new Date(dateValue.year, dateValue.month, dateValue.day);

                     // 打印调试信息
                     console.info("DatePickerDialog:onAccept()" + JSON.stringify(dateValue));

                     // 显示时间选择对话框
                     TimePickerDialog.show({
                       selected: new Date(selectedDate.setHours(12, 0)), // 默认时间
                       onAccept: (timeValue: TimePickerResult) => {
                         selectedDate.setHours(timeValue.hour, timeValue.minute);

                         // 打印调试信息
                         console.info("TimePickerDialog:onAccept()" + JSON.stringify(timeValue));

                         // 设置 this.holiday.start_date 包含日期和时间
                         this.start_time= `${selectedDate.getFullYear()}-${String(selectedDate.getMonth() + 1).padStart(2, '0')}-${String(selectedDate.getDate()).padStart(2, '0')} ${String(selectedDate.getHours()).padStart(2, '0')}:${String(selectedDate.getMinutes()).padStart(2, '0')}`;
                         this.holiday.start_date = `${selectedDate.getFullYear()}-${String(selectedDate.getMonth() + 1).padStart(2, '0')}-${String(selectedDate.getDate()).padStart(2, '0')}T${String(selectedDate.getHours()).padStart(2, '0')}:${String(selectedDate.getMinutes()).padStart(2, '0')}`;
                       }
                     });
                   }
                 });
               })
           }.width('80%')

           Row({space:45}) {
             Row({ space: 5 }) {
               Text('*')
                 .fontSize(22)
                 .fontColor('#FF0000')
               Text('结束时间')
                 .fontSize(20)
             }.width('33%')

             Button(this.end_time|| ' 请选择 ')
               .backgroundColor('#F5F5F5')
               .fontColor('#459ED4')
               .onClick(() => {
                 DatePickerDialog.show({
                   start: new Date("2000-1-1"),
                   end: new Date("2100-12-31"),
                   selected: this.selectedDate1,
                   onAccept: (dateValue: DatePickerResult) => {
                     // 保存日期选择
                     const selectedDate = new Date(dateValue.year, dateValue.month, dateValue.day);

                     // 打印调试信息
                     console.info("DatePickerDialog:onAccept()" + JSON.stringify(dateValue));

                     // 显示时间选择对话框
                     TimePickerDialog.show({
                       selected: new Date(selectedDate.setHours(12, 0)), // 默认时间
                       onAccept: (timeValue: TimePickerResult) => {
                         selectedDate.setHours(timeValue.hour, timeValue.minute);

                         // 打印调试信息
                         console.info("TimePickerDialog:onAccept()" + JSON.stringify(timeValue));

                         this.end_time= `${selectedDate.getFullYear()}-${String(selectedDate.getMonth() + 1).padStart(2, '0')}-${String(selectedDate.getDate()).padStart(2, '0')} ${String(selectedDate.getHours()).padStart(2, '0')}:${String(selectedDate.getMinutes()).padStart(2, '0')}`;
                         this.holiday.end_date = `${selectedDate.getFullYear()}-${String(selectedDate.getMonth() + 1).padStart(2, '0')}-${String(selectedDate.getDate()).padStart(2, '0')}T${String(selectedDate.getHours()).padStart(2, '0')}:${String(selectedDate.getMinutes()).padStart(2, '0')}`;
                       }
                     });
                   }
                 });
               })
           }.width('80%')
             .padding({top:5})

         }.width('95%')
         .padding({ top: 15, bottom: 10 })
         .backgroundColor('#fff')
         .borderRadius(8)
         .height('25%')


         Button('提交')
           .onClick(() => {
             this.holiday.emp_ID=this.employee.emp_ID
             //调用接口，调动
             ADD_Holiday(this.holiday)
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















       }.height('100%')
       .width('100%')
       .backgroundColor('#E6E6E6')

     }.tabBar('请假申请')
























   }
















 }















}