import router from '@ohos.router'
@Entry
@Component
struct MovePage {
  @State message: string = ' 调动申请'

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