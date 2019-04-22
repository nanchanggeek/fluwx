/*
 * Copyright (C) 2018 The OpenFlutter Organization
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'package:flutter/foundation.dart';

import '../wechat_type.dart';

const String _url = "url";
const String _reqType = "reqType";

///Base Class for Req
abstract class WeChatReqModel {
  final WeChatReqType reqType;

  WeChatReqModel({
    this.reqType,
  });

  Map toMap();
}

///
/// [WeChatScene] is not supported here due to WeChat's limits.
/// the default value is [MINI_PROGRAM_TYPE_RELEASE]
///
class WeChatReqOpenWebviewModel extends WeChatReqModel {
  final String url;

  WeChatReqOpenWebviewModel({
    String url,
  })  : this.url = url ?? "https://www.baidu.com/",
        super(reqType: WeChatReqType.WEBVIEW);

  @override
  Map toMap() {
    return {
      _url: url,
      _reqType: reqType.toString(),
    };
  }
}
