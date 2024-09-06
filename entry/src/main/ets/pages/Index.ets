@Entry
@Component
struct Index {
  @State message: string = '快速开始';

  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(24)
        .fontWeight('700')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({left: 16})
        .fontFamily('HarmonyHeiTi-Bold')
        .lineHeight(33)
      Banner()
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Preview
@Component
struct Banner {
  build() {
    Image($r('app.media.banner_pic1'))
      .objectFit(ImageFit.Contain)
      .width('100%')
      .padding({top: 11, right: 16, left: 16, })
      .borderRadius(16)
  }
}