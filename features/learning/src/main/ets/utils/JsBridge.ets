import { webview } from '@kit.ArkWeb';

// 定义接口类型
export interface JsRequest {
  taljsfname: string;
  params: JsParams;
  callbackid: string;
}

// 参数类型 - 使用具体属性而非索引签名
export interface JsParams {
  // 常用参数定义
  id?: string;
  name?: string;
  value?: string | number | boolean;
  type?: string;
  data?: string;
  // 可以根据实际需要添加更多具体属性
}

// 设备信息类型
export interface DeviceInfo {
  platform: string;
  version: string;
}

// 网络状态类型
export interface NetworkStatus {
  connected: boolean;
  type: string;
}

// 回调数据类型
export interface CallbackData {
  callbackid: string;
  result: DeviceInfo | NetworkStatus | Record<string, never>;
  error: string | null;
  continue: string;
}

// JavaScript桥接类
export class JsBridge {
  private webController: webview.WebviewController | null = null;
  
  setWebController(controller: webview.WebviewController) {
    this.webController = controller;
    console.info('WebController已设置');
  }
  
  // 处理来自JavaScript的请求
  // 注意：方法名必须与注册时完全一致
  postMethod(data: string, domain: string, callback: (result: string) => void): void {
    console.info(`接收到异步数据: ${data}, 域名: ${domain}`);
    
    if (!this.webController) {
      const errorMsg = 'WebController未初始化，无法处理请求';
      console.error(errorMsg);
      callback(JSON.stringify({ error: errorMsg }));
      return;
    }
    
    try {
      const jsonData: JsRequest = JSON.parse(data);
      const methodName = jsonData.taljsfname;
      const callbackId = jsonData.callbackid;
      
      console.info(`处理方法: ${methodName}, 回调ID: ${callbackId}`);
      
      // 处理不同的方法调用
      switch (methodName) {
        case 'deviceInformation':
          // 获取设备信息
          const deviceInfo: DeviceInfo = {
            platform: 'HarmonyOS',
            version: '4.0'
          };
          
          // 发送回调
          this.sendCallback(callbackId, deviceInfo);
          break;
          
        case 'netWorkStatus':
          // 获取网络状态
          const networkStatus: NetworkStatus = {
            connected: true,
            type: 'WIFI'
          };
          
          // 发送回调
          this.sendCallback(callbackId, networkStatus);
          break;
          
        default:
          console.warn(`未知方法: ${methodName}`);
          // 返回错误信息
          this.sendCallback(callbackId, {} as Record<string, never>, `未知方法: ${methodName}`);
      }
      
      // 返回成功信息
      callback(JSON.stringify({ success: true }));
    } catch (error) {
      const errorMsg = `数据处理错误: ${error}`;
      console.error(errorMsg);
      callback(JSON.stringify({ error: errorMsg }));
    }
  }
  
  // 同步方法版本 - 用于处理 prompt 协议
  onJsPrompt(url: string, message: string): string {
    console.info(`接收到 prompt 请求: ${url}, 消息: ${message}`);
    
    if (!url.startsWith('talAndroidJsBridge:')) {
      return '';
    }
    
    const domain = url.substring('talAndroidJsBridge:'.length);
    
    if (!this.webController) {
      const errorMsg = 'WebController未初始化，无法处理请求';
      console.error(errorMsg);
      return JSON.stringify({ error: errorMsg });
    }
    
    try {
      const jsonData: JsRequest = JSON.parse(message);
      const methodName = jsonData.taljsfname;
      const callbackId = jsonData.callbackid;
      
      console.info(`处理方法: ${methodName}, 回调ID: ${callbackId}, 域名: ${domain}`);
      
      // 处理不同的方法调用
      switch (methodName) {
        case 'deviceInformation':
          // 获取设备信息
          const deviceInfo: DeviceInfo = {
            platform: 'HarmonyOS',
            version: '4.0'
          };
          
          // 发送回调
          this.sendCallback(callbackId, deviceInfo);
          break;
          
        case 'netWorkStatus':
          // 获取网络状态
          const networkStatus: NetworkStatus = {
            connected: true,
            type: 'WIFI'
          };
          
          // 发送回调
          this.sendCallback(callbackId, networkStatus);
          break;
          
        default:
          console.warn(`未知方法: ${methodName}`);
          // 返回错误信息
          this.sendCallback(callbackId, {} as Record<string, never>, `未知方法: ${methodName}`);
      }
      
      // 返回成功信息
      return JSON.stringify({ success: true });
    } catch (error) {
      const errorMsg = `数据处理错误: ${error}`;
      console.error(errorMsg);
      return JSON.stringify({ error: errorMsg });
    }
  }
  
  private sendCallback(callbackId: string, result: DeviceInfo | NetworkStatus | Record<string, never>, error: string | null = null) {
    if (!this.webController) {
      console.error('WebController未初始化，无法发送回调');
      return;
    }
    
    const callbackData: CallbackData = {
      callbackid: callbackId,
      result: result,
      error: error,
      continue: '0'
    };
    
    const jsCode = `window.app_executeCallBack(${JSON.stringify(callbackData)})`;
    console.info(`执行JavaScript: ${jsCode}`);
    
    this.webController.runJavaScript(
      jsCode,
      (err, res) => {
        if (err) {
          console.error(`执行回调出错: ${JSON.stringify(err)}`);
        } else {
          console.info(`执行回调成功: ${res}`);
        }
      }
    );
  }
} 