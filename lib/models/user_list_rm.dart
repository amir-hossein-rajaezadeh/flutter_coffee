class UserListRM {
  UserListRM({
    required this.statusCode,
    required this.detail,
    required this.errorMessage,
    this.headers,
  });
  late final int statusCode;
  late final Detail detail;

  late final String errorMessage;
  late final Null headers;

  UserListRM.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (statusCode != 200) {
      errorMessage = json["detail"];
    }
    detail = statusCode == 200
        ? Detail.fromJson(json["detail"])
        : Detail(results: [], totalCount: 0, page: 0, pageSize: 0);
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

class Detail {
  Detail({
    required this.results,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });
  late final List<UserItem> results;
  late final int totalCount;
  late final int page;
  late final int pageSize;

  Detail.fromJson(Map<String, dynamic> json) {
    results =
        List.from(json['results']).map((e) => UserItem.fromJson(e)).toList();
    totalCount = json['total_count'];
    page = json['page'];
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['results'] = results.map((e) => e.toJson()).toList();
    data['total_count'] = totalCount;
    data['page'] = page;
    data['page_size'] = pageSize;
    return data;
  }
}

class UserItem {
  UserItem({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.isSuperuser,
  });
  late final int id;
  late final String username;
  late final String password;
  late final String firstName;
  late final String lastName;
  late final int isSuperuser;

  UserItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isSuperuser = json['is_superuser'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['is_superuser'] = isSuperuser;
    return data;
  }
}
