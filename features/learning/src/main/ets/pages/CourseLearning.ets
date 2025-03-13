import { webview } from '@kit.ArkWeb';
import { JsBridge } from '../utils/JsBridge';

@Component
export struct CourseLearning {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private jsBridge: JsBridge = new JsBridge();
  
  aboutToAppear() {
    // 设置WebController
    this.jsBridge.setWebController(this.webviewController);
  }

  build() {
    Column() {
      Web({
        // 从资源目录加载HTML文件
        src: 'resource://rawfile/index.html',
        controller: this.webviewController
      })
        .javaScriptAccess(true)
        .onControllerAttached(() => {
          // this.controller.loadUrl($rawfile("index.html"));
          this.webviewController.registerJavaScriptProxy(
            this.jsBridge,
            "talAndroidJsBridge",
            ["webTest", "webString", "postMethod"]
          );
        })
    }
    .width('100%')
    .height('100%')
  }
}