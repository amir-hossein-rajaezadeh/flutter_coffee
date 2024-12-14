class CoffeeModelRM {
  int? _id;
  String? _coffeeName;
  String? _coffeeType;
  double? _rate;
  int? _commentCount;
  String? _image;
  double? _price;
  int? _isLiked;
  String? _desc;
  int? _buyCount;
  String? _coffeeShopLocation;
  String? _coffeeAddress;

  CoffeeModelRM(
      {int? id,
      String? coffeeName,
      String? coffeeType,
      double? rate,
      int? commentCount,
      String? image,
      double? price,
      int? isLiked,
      String? desc,
      int? buyCount,
      String? coffeeShopLocation,
      String? coffeeAddress}) {
    if (id != null) {
      _id = id;
    }
    if (coffeeName != null) {
      _coffeeName = coffeeName;
    }
    if (coffeeType != null) {
      _coffeeType = coffeeType;
    }
    if (rate != null) {
      _rate = rate;
    }
    if (commentCount != null) {
      _commentCount = commentCount;
    }
    if (image != null) {
      _image = image;
    }
    if (price != null) {
      _price = price;
    }
    if (isLiked != null) {
      _isLiked = isLiked;
    }
    if (desc != null) {
      _desc = desc;
    }
    if (buyCount != null) {
      _buyCount = buyCount;
    }
    if (coffeeShopLocation != null) {
      _coffeeShopLocation = coffeeShopLocation;
    }
    if (coffeeAddress != null) {
      _coffeeAddress = coffeeAddress;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get coffeeName => _coffeeName;
  set coffeeName(String? coffeeName) => _coffeeName = coffeeName;
  String? get coffeeType => _coffeeType;
  set coffeeType(String? coffeeType) => _coffeeType = coffeeType;
  double? get rate => _rate;
  set rate(double? rate) => _rate = rate;
  int? get commentCount => _commentCount;
  set commentCount(int? commentCount) => _commentCount = commentCount;
  String? get image => _image;
  set image(String? image) => _image = image;
  double? get price => _price;
  set price(double? price) => _price = price;
  int? get isLiked => _isLiked;
  set isLiked(int? isLiked) => _isLiked = isLiked;
  String? get desc => _desc;
  set desc(String? desc) => _desc = desc;
  int? get buyCount => _buyCount;
  set buyCount(int? buyCount) => _buyCount = buyCount;
  String? get coffeeShopLocation => _coffeeShopLocation;
  set coffeeShopLocation(String? coffeeShopLocation) =>
      _coffeeShopLocation = coffeeShopLocation;
  String? get coffeeAddress => _coffeeAddress;
  set coffeeAddress(String? coffeeAddress) => _coffeeAddress = coffeeAddress;

  CoffeeModelRM.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _coffeeName = json['coffeeName'];
    _coffeeType = json['coffeeType'];
    _rate = json['rate'];
    _commentCount = json['commentCount'];
    _image = ('http://0.0.0.0:8000/' + json['image']).replaceFirst(
      '//u',
      '/u',
    );

    _price = json['price'];
    _isLiked = json['isLiked'];
    _desc = json['desc'];
    _buyCount = json['buyCount'];
    _coffeeShopLocation = json['coffeeShopLocation'];
    _coffeeAddress = json['coffeeAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['coffeeName'] = _coffeeName;
    data['coffeeType'] = _coffeeType;
    data['rate'] = _rate;
    data['commentCount'] = _commentCount;
    data['image'] = _image;
    data['price'] = _price;
    data['isLiked'] = _isLiked;
    data['desc'] = _desc;
    data['buyCount'] = _buyCount;
    data['coffeeShopLocation'] = _coffeeShopLocation;
    data['coffeeAddress'] = _coffeeAddress;
    return data;
  }
}
