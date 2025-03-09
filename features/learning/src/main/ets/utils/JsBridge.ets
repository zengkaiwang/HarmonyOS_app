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
  result: object;
  error: string | null;
  continue: string;
}

// JavaScript桥接类
export class JsBridge {
  private webController: webview.WebviewController | null = null;
  
  setWebController(controller: webview.WebviewController) {
    this.webController = controller;
  }
  
  postMethod(data: string, domain: string): void {
    console.info(`Received data: ${data} for domain: ${domain}`);
    
    try {
      const jsonData: JsRequest = JSON.parse(data);
      const methodName = jsonData.taljsfname;
      const params = jsonData.params;
      const callbackId = jsonData.callbackid;
      
      // 处理不同的方法调用
      switch (methodName) {
        case 'deviceInformation':
          this.handleDeviceInfo(callbackId);
          break;
        case 'netWorkStatus':
          this.handleNetworkStatus(callbackId);
          break;
        // 其他方法...
        default:
          console.warn(`未知方法: ${methodName}`);
      }
    } catch (error) {
      console.error(`数据处理错误: ${error}`);
    }
  }
  
  private handleDeviceInfo(callbackId: string) {
    // 获取设备信息
    const deviceInfo: DeviceInfo = {
      platform: 'HarmonyOS',
      version: '4.0'
    };
    
    // 发送回调
    this.sendCallback(callbackId, deviceInfo);
  }
  
  private handleNetworkStatus(callbackId: string) {
    // 获取网络状态
    const networkStatus: NetworkStatus = {
      connected: true,
      type: 'WIFI'
    };
    
    // 发送回调
    this.sendCallback(callbackId, networkStatus);
  }
  
  private sendCallback(callbackId: string, result: object, error: string | null = null) {
    if (!this.webController) return;
    
    const callbackData: CallbackData = {
      callbackid: callbackId,
      result: result,
      error: error,
      continue: '0'
    };
    
    this.webController.runJavaScript(
      `window.app_executeCallBack(${JSON.stringify(callbackData)})`,
      (err, res) => {
        if (err) {
          console.error(`执行回调出错: ${err}`);
        }
      }
    );
  }
} 