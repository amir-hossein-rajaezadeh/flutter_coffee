class RegisterRM {
  RegisterRM({
    required this.statusCode,
    required this.detail,
    this.headers,
  });
  late final int statusCode;
  late final String detail;
  late final Null headers;

  RegisterRM.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    detail = json['detail'];
    headers = null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['detail'] = detail;
    data['headers'] = headers;
    return data;
  }
}
