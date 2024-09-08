import { QuickStartPage } from '@ohos/quickstart'
import { CourseLearning } from '@ohos/learning'
import { KnowledgeMap } from '@ohos/map';
import { KnowledgeMapContent } from '@ohos/map';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // QuickStartPage()
      // CourseLearning()
      // KnowledgeMap()
      KnowledgeMapContent()
    }
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}