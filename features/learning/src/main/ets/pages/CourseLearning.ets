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
        .fileAccess(true)
        .onPageBegin((data) => {
          console.info('页面开始加载: ' + data);
          
          // 在页面开始加载时注册JavaScript桥接
          try {
            console.info('开始注册JavaScript桥接');
            
            // 注册JavaScript桥接 - 使用异步方法列表
            this.webviewController.registerJavaScriptProxy(
              this.jsBridge, 
              'talAndroidJsBridge', 
              [], // 同步方法列表为空
              ['postMethod'] // 异步方法列表
            );
            
            console.info('JavaScript桥接注册成功');
          } catch (error) {
            console.error(`注册JavaScript桥接出错: ${error}`);
          }
        })
        .onPageEnd((data) => {
          console.info('页面加载完成: ' + data);
          
          // 在页面加载完成后注入JavaScript代码
          setTimeout(() => {
            // 注入桥接初始化代码
            this.webviewController.runJavaScript(
              `
              // 创建一个全局桥接对象
              window.talAndroidJsBridge = {
                postMethod: function(data, domain) {
                  // 使用 prompt 协议来调用原生方法
                  return prompt('talAndroidJsBridge:' + domain, data);
                }
              };
              
              console.log("JavaScript桥接已手动初始化");
              
              // 检查桥接是否可用
              console.log("检查全局对象:");
              for (let key in window) {
                if (key.includes('Bridge') || key.includes('bridge')) {
                  console.log("- " + key + ": " + typeof window[key]);
                }
              }
              
              if (window.talAndroidJsBridge) {
                console.log("JavaScript桥接已初始化成功");
                document.getElementById('result').innerHTML = '<p style="color:green">JavaScript桥接已初始化成功</p>';
              } else {
                console.error("JavaScript桥接未初始化");
                document.getElementById('result').innerHTML = '<p style="color:red">错误: JavaScript桥接未初始化</p>';
              }
              `,
              (error, result) => {
                if (error) {
                  console.error('运行JavaScript出错: ' + JSON.stringify(error));
                } else {
                  console.info('运行JavaScript成功: ' + result);
                }
              }
            );
          }, 500); // 延迟500毫秒，确保页面已完全加载
        })
        .onErrorReceive((error) => {
          console.error('WebView错误: ' + JSON.stringify(error));
        })
        .onHttpErrorReceive((event) => {
          console.error('HTTP错误: ' + JSON.stringify(event));
        })
        .onInterceptRequest((event) => {
          // 拦截请求，处理特殊协议
          const url = event.request.getRequestUrl();
          console.info('拦截请求: ' + url);
          
          if (url.startsWith('talAndroidJsBridge:')) {
            console.info('拦截到桥接请求');
            return null;
          }
          
          return null;
        })
    }
    .width('100%')
    .height('100%')
  }
}