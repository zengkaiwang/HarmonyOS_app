import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

import { NavBarItem, NavBarItemType } from '../view/NavBarItem';
import { Section } from '../view/KnowledgeMapContent';

// @Preview
@Component
export struct KnowledgeMap {
  @State navBarList: NavBarItemType[] = [
    { order: '01', title: '准备与学习' },
    { order: '02', title: '构建应用' },
    { order: '03', title: '应用测试' },
    { order: '04', title: '上架' },
    { order: '05', title: '运营增长' },
    { order: '06', title: '商业变现' },
    { order: '07', title: '更多' }
  ];
  @State sections: Section[] = [];

  private getSections() {
    try {
      getContext(this).resourceManager.getRawFileContent("MapData.json", (error: BusinessError, value: Uint8Array) => {
        const textDecoder = util.TextDecoder.create("utf-8");
        const res = textDecoder.decodeWithStream(value, { stream: false });
        this.sections = JSON.parse(res);
      });
    } catch (error) {
      console.error(`callback getRawFileContent failed, error is ${JSON.stringify(error)}`)
    }
  }

  aboutToAppear(): void {
    this.getSections();
  }

  build() {
    Scroll() {
      Column() {
        Text('知识地图')
          .fontFamily('HarmonyHeiTi-Bold')
          .fontSize(24)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Start)
          .lineHeight(33)
          .fontWeight(700)
          .width('100%')
        Image($r('app.media.knowledge_map_banner'))
          .width('100%')
          .borderRadius(16)
          .margin({ top: 19, bottom: 8 })
        Text('通过循序渐进的学习路径，无经验和有经验的开发者都可以轻松掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程。')
          .fontFamily('HarmonyHeiTi')
          .fontSize(14)
          .fontColor('rgba(0,0,0,0.60)')
          .fontWeight(400)
          .textAlign(TextAlign.Start)
        List({ space: 12 }) {
          ForEach(this.navBarList, (item: NavBarItemType, index: number) => {
            ListItem() {
              NavBarItem({ navBarItem: item })
            }
            .width('100%')
          }, (item: NavBarItemType): string => item.title)
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .padding({ top: 12, right: 16, bottom: 12, left: 16})
      .backgroundColor('#F1F3F5')
    }
    .backgroundColor('#F1F3F5')
    .align(Alignment.TopStart)
    .constraintSize({ minHeight: '100%' })
    .edgeEffect(EdgeEffect.Spring)
  }
}