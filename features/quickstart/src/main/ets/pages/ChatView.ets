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

    getContext(this).eventHub.on("clickBack", (value: string) => {
      console.log('我是通过eventHub传过来的值', value)
    })
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
    }, 3000)
  }

  onSendMsg (value: string) {
    console.log('onSendMsg:', value)
    this.messageList = [...this.messageList, {
      name: '我',
      msg: value,
      type: 'myself',
      id: Math.random().toString(36).substr(2)
    }]
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom, {velocity: 0})
    }, 200)
  }


  build() {
    Column() {
      Text(this.message)
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

      // 发送消息组件
      // TextAreaExample()
      TextAreaExample({ clickBack: (value) => {
        this.onSendMsg(value)
      } })
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


// input输入框的使用示例：
// @Preview
@Component
struct TextAreaExample {

  @State text: string = ''
  @State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  controller: TextAreaController = new TextAreaController()

  clickBack:(value: string)=>void = (value)=>{}

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        TextArea({
          text: this.text,
          placeholder: '请输入消息',
          controller: this.controller
        })
          .placeholderFont({ size: 16, weight: 400 })
          .width(336)
            // .height(56)
          // .margin(20)
          .fontSize(16)
          .fontColor('#182431')
          .backgroundColor('#FFFFFF')
          .onChange((value: string) => {
            this.text = value
          })
        Button('发送', { buttonStyle: ButtonStyleMode.NORMAL })
          .width(80)
          .height(36)
          .fontColor('#7D7D7D')
          .backgroundColor('#fff')
          .margin({left: -80})
          .border({ width: 1, color: 'rgba(0,0,0,0.1)', radius: 4})
          .onClick(() => {
            console.log(this.text)
            this.clickBack(this.text)
            getContext(this).eventHub.emit("clickBack",this.text)
          })
      }
      // Text(this.text)
      // Button('Set caretPosition 1')
      //   .backgroundColor('#007DFF')
      //   .margin(15)
      //   .onClick(() => {
      //     // 设置光标位置到第一个字符后
      //     this.controller.caretPosition(1)
      //   })
    }.width('100%').height('100%').backgroundColor('#F1F3F5').margin({top: 50})
  }
}