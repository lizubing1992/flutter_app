/// Api接口返回基本数据结构
class ApiBasicResult {
  final bool error;
  final String msg;

  ApiBasicResult({this.error, this.msg});

  factory ApiBasicResult.fromJson(Map<String, dynamic> json) =>
      new ApiBasicResult(error: json['error'], msg: json['msg']);
}
