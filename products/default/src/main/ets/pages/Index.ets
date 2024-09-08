import { QuickStartPage } from '@ohos/quickstart'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      QuickStartPage()
    }
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}