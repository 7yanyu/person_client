import router from '@ohos.router'
import { employee } from '../entity/employee';
@Entry
@Component
struct TryPage {
  @State message: string = '转正申请'
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

      }.padding({top:15})
      .width('90%')
    }
    .width('100%')
    .height('100%')
  }
}