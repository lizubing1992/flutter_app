import 'package:http/http.dart' as http;
import 'dart:async';

class Netutil {
  /// GET请求
  /// [params] 参数
  static Future<String> get(String url, {Map<String, dynamic> params}) async {
    if (params != null && params.length > 0) {
      StringBuffer _sbf = new StringBuffer('?');
      params.forEach((key, value) {
        _sbf.write('$key=$value&');
      });
      String _paramStr = _sbf.toString();
      _paramStr = _paramStr.substring(0, _paramStr.length - 1);
      url += _paramStr;
    }
    http.Response _response = await http.get(url);
    return _response.body;
  }

  /// POSt请求
  /// [params] 参数
  static Future<String> post(String url, dynamic params,
      {Map<String, String> headers}) async {
    http.Response _response =
        await http.post(url, body: params, headers: headers);
    return _response.body;
  }
}
