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
        .domStorageAccess(true)
        .javaScriptAccess(true)
        .onPageBegin((data) => {
          // 注册JavaScript接口
          this.webviewController.registerJavaScriptProxy(
            this.jsBridge, 
            'talAndroidJsBridge', 
            ['postMethod'], // 同步方法列表
            [], // 异步方法列表
            '*' // 权限配置，允许所有URL访问
          );
        })
    }
    .width('100%')
    .height('100%')
  }
}