class LoginModelRM {
  LoginModelRM({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });
  late final String accessToken;
  late final String refreshToken;
  late final String tokenType;

  LoginModelRM.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    return data;
  }
}
