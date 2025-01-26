class CardListRM {
  CardListRM({
    required this.statusCode,
    required this.detail,
    this.headers,
  });
  late final num statusCode;
  late final CardItem detail;
  late final Null headers;

  CardListRM.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    detail = CardItem.fromJson(json['detail']);
    headers = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['detail'] = detail.toJson();
    _data['headers'] = headers;
    return _data;
  }
}

class CardItem {
  CardItem({
    required this.data,
    required this.price,
  });
  late final List<CardModel> data;
  late final num price;

  CardItem.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => CardModel.fromJson(e)).toList();
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['price'] = price;
    return _data;
  }
}

class CardModel {
  CardModel({
    required this.id,
    required this.user,
    required this.coffee,
    required this.count,
  });
  late num id;
  late final num user;
  late final Coffee coffee;
  late int count;

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    coffee = Coffee.fromJson(json['coffee']);
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user'] = user;
    _data['coffee'] = coffee.toJson();
    _data['count'] = count;
    return _data;
  }
}

class Coffee {
  Coffee({
    required this.id,
    required this.coffeeName,
    required this.coffeeType,
    required this.rate,
    required this.commentCount,
    required this.image,
    required this.price,
    required this.isLiked,
    required this.desc,
    required this.buyCount,
    required this.coffeeShopLocation,
    required this.coffeeAddress,
  });
  late final int id;
  late final String coffeeName;
  late final String coffeeType;
  late final num rate;
  late final num commentCount;
  late final String image;
  late final num price;
  late final num isLiked;
  late final String desc;
  late final num buyCount;
  late final String coffeeShopLocation;
  late final String coffeeAddress;

  Coffee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coffeeName = json['coffeeName'];
    coffeeType = json['coffeeType'];
    rate = json['rate'];
    commentCount = json['commentCount'];
    image = ('http://0.0.0.0:8765/' + json['image']).replaceFirst(
      '//u',
      '/u',
    );
    price = json['price'];
    isLiked = json['isLiked'];
    desc = json['desc'];
    buyCount = json['buyCount'];
    coffeeShopLocation = json['coffeeShopLocation'];
    coffeeAddress = json['coffeeAddress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['coffeeName'] = coffeeName;
    _data['coffeeType'] = coffeeType;
    _data['rate'] = rate;
    _data['commentCount'] = commentCount;
    _data['image'] = image;
    _data['price'] = price;
    _data['isLiked'] = isLiked;
    _data['desc'] = desc;
    _data['buyCount'] = buyCount;
    _data['coffeeShopLocation'] = coffeeShopLocation;
    _data['coffeeAddress'] = coffeeAddress;
    return _data;
  }
}
