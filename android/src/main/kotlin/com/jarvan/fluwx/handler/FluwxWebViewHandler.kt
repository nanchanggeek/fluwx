package com.jarvan.fluwx.handler

import com.jarvan.fluwx.constant.CallResult
import com.jarvan.fluwx.constant.WechatPluginKeys
import com.tencent.mm.opensdk.modelbiz.OpenWebview
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FluwxWebViewHandler {

    fun openWebView(call: MethodCall, result: MethodChannel.Result) {
        if (WXAPiHandler.wxApi == null) {
            result.error(CallResult.RESULT_API_NULL, "please config  wxapi first", null)
            return
        } else {
            val req = OpenWebview.Req()
            req.url = call.argument("url")
            val done = WXAPiHandler.wxApi!!.sendReq(req)
            result.success(
                    mapOf(
                            WechatPluginKeys.PLATFORM to WechatPluginKeys.ANDROID,
                            WechatPluginKeys.RESULT to done
                    )
            )
        }
    }
}