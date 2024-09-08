
import {ArticleClass} from '../model/ArticleClass'

@Component
export struct EnablementView{
  @State enablementList: Array<ArticleClass> = [
    new ArticleClass('1', $r('app.media.enablement_pic1'), 'HarmonyOS第一课',
      '基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-video-courses/video-tutorials-0000001443535745'),
    new ArticleClass('2', $r('app.media.enablement_pic2'), '开发指南',
      '提供系统能力概述、快速入门，用于指导开发者进行场景化的开发。指南涉及到的知识点包括必要的背景知识、符合开发者实际开发场景的操作任务流（开发流程、开发步骤、调测验证）以及常见问题等。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-dev-guide-0000001630265101'),
    new ArticleClass('3', $r('app.media.enablement_pic3'), '最佳实践',
      '针对新发布特性及热点特性提供详细的技术解析和开发最佳实践。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/topic-architecture-0000001678045510'),
    new ArticleClass('4', $r('app.media.enablement_pic4'), 'Codelabs',
      '以教学为目的的代码样例及详细的开发指导，帮助开发者一步步地完成指定场景的应用开发并掌握相关知识。Codelabs将最新的鸿蒙生态应用开发技术与典型场景结合，让开发者快速地掌握开发高质量应用的方法。同时支持互动式操作，通过文字、代码和效果联动为开发者带来更佳的学习体验。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-codelabs/codelabs-0000001443855957'),
    new ArticleClass('5', $r('app.media.enablement_pic5'), 'Sample',
      '面向不同类型的开发者提供的鸿蒙生态应用开发优秀实践，每个Sample Code都是一个可运行的工程，为开发者提供实例化的代码参考。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-samples/samples-0000001162414961'),
    new ArticleClass('6', $r('app.media.enablement_pic6'), 'API参考',
      '面向开发者提供鸿蒙系统开放接口的全集，供开发者了解具体接口使用方法。API参考详细地描述了每个接口的功能、使用限制、参数名、参数类型、参数含义、取值范围、权限、注意事项、错误码及返回值等。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-references/development-intro-0000001580026066'),
    new ArticleClass('7', $r('app.media.enablement_pic7'), 'FAQ',
      '开发者常见问题的总结，开发者可以通过FAQ更高效地解决常见问题。FAQ会持续刷新，及时呈现最新的常见问题。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-faqs/faqs-development-0000001753952202'),
    new ArticleClass('8', $r('app.media.enablement_pic8'), '开发者论坛', '和其他应用开发者交流技术、共同进步。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
  ];
  build() {
    Column() {
      Text('赋能套件')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
        .width('100%')
      Grid() {
        ForEach(this.enablementList, (item: ArticleClass) => {
          GridItem() {
            EnablementItem({ enablementItem: item})
          }
        }, (item:ArticleClass) => item.id)
      }
      .rowsTemplate('1fr')
      .columnsGap(8)
      .scrollBar(BarState.Off)
      .height(169)
      .padding({top:2,left:16,right:16})
    }
    .margin({top: 8})
    .alignItems(HorizontalAlign.Start)
  }
}

// @Preview
@Component
export struct EnablementItem {
  // private title: string = 'HarmonyOS第一课'
  // private brief: string = '基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验'

  @Prop enablementItem: ArticleClass

  build() {
    Column() {
      // Image($r('app.media.enablement_pic1'))
      Image(this.enablementItem.imageSrc)
        .width('100%')
        .objectFit(ImageFit.Cover)
        .height(96)
        .borderRadius({
          topLeft: 16,
          topRight: 16
        })
      Text(this.enablementItem.title)
        .height(19)
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .fontWeight(400)
        .padding({ left: 12, right: 12 })
        .margin({ top: 8 })
      Text(this.enablementItem.brief)
        .height(32)
        .width('100%')
        .fontSize(12)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontWeight(400)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 2 })
    }
    .width(160)
    .height(169)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }
}