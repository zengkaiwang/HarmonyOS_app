export interface ChatMsg {
  name: string
  msg: string
  type: string
  id: string
}

@Preview
@Component
export struct ThreeVSThreeChatView {
  @State message: string = '聊天区：';
  @State messageList: Array<ChatMsg> = []
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    this.getMessageList()
  }

  getMessageList() {
    this.messageList = [
      {
        name: '系统',
        msg: '为了维护直播课堂的上课氛围，请勿在直播违法发言',
        type: 'teacher',
        id: '0'
      },
      {
        name: '我',
        msg: '听懂了！666',
        type: 'myself',
        id: '1'
      },
      {
        name: '李小冉',
        msg: '老师太帅了',
        type: 'student',
        id: '3'
      },
      {
        name: '我',
        msg: '听懂了！666',
        type: 'myself',
        id: '4'
      },
      {
        name: '李小冉',
        msg: '老师太帅了',
        type: 'student',
        id: '5'
      }
    ]

    setInterval(() => {
      if (Math.random() < 0.3) {
        this.messageList = [...this.messageList, this.messageList[1]]
      } else if (Math.random() > 0.8) {
        this.messageList = [...this.messageList, this.messageList[0]]
      } else {
        this.messageList = [...this.messageList, this.messageList[2]]
      }
      this.scroller.scrollEdge(Edge.Bottom, {velocity: 0})
    }, 2000)
  }


  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(20)
        .fontWeight('700')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({left: 16})
        .fontFamily('HarmonyHeiTi-Bold')
        .lineHeight(33)
        .onClick(() => { // 点击后回到顶部
          this.scroller.scrollEdge(Edge.Bottom)
        })
      Scroll(this.scroller) {
        Column() {
          ForEach(this.messageList, (item: ChatMsg) => {
            MessageItem({ msgItem: item})
          })
        }
        .alignItems(HorizontalAlign.End)
      }
      // .layoutWeight(1)
      .height(160)
      .scrollBar(BarState.Auto)
      .align(Alignment.TopStart)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Extend(Text) function extendMesText() {
  .fontColor('#fff')
  .fontSize(14)
  .fontWeight('300')
  .lineHeight(20)
}

// @Preview
@Component
export struct MessageItem {
  @Prop msgItem: ChatMsg

  build() {
    Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start, wrap: FlexWrap.NoWrap }) {
      if (this.msgItem.type == 'teacher') {
        Text(this.msgItem.name)
          .extendMesText()
          .backgroundColor('#A38B78')
          .border({ width: 1, color: '#fff', radius: 8})
          .height(20)
          .width(46)
          .lineHeight(18)
          .textAlign(TextAlign.Center)
          .margin({right: 4, top: 2})
      } else {
        Text(`${this.msgItem.name}：`)
          .extendMesText()
      }
      Text(this.msgItem.msg)
        .extendMesText()
    }
    .backgroundColor('#A38B78')
    .padding({top: 6, right: 10, bottom: 6, left: 10})
    .borderRadius(14)
    .margin({top: 6})
    .width('auto')
    .constraintSize({ maxWidth: 280})
  }
}