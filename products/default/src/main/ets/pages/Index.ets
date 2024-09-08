import { QuickStartPage } from '@ohos/quickstart'
import { CourseLearning } from '@ohos/learning'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // QuickStartPage()
      CourseLearning()
    }
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}