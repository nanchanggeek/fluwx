package com.jarvan.fluwx.handler

import com.tencent.mm.opensdk.modelbase.BaseReq
import io.flutter.plugin.common.MethodChannel

object RequestHandlers{
    private var channel: MethodChannel? = null

    fun setMethodChannel(channel: MethodChannel) {
        RequestHandlers.channel = channel
    }

    fun handleRequest(baseReq: BaseReq) {

    }
}
