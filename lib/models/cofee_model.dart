import 'package:latlong2/latlong.dart';

class CoffeeModel {
  final int coffeeId;
  final String coffeeName;
  final String coffeeType;
  final double rate;
  final int commentCount;
  final String image;
  final double price;
  final bool isLiked;
  final String desc;
  final int buyCount;
  final LatLng coffeeShopLocation;
  final String coffeeAddress;

  CoffeeModel(
      this.coffeeId,
      this.coffeeName,
      this.coffeeType,
      this.rate,
      this.commentCount,
      this.image,
      this.price,
      this.isLiked,
      this.desc,
      this.buyCount,
      this.coffeeShopLocation,
      this.coffeeAddress);
}

List<CoffeeModel> getCoffeeList() {
  final List<CoffeeModel> getCoffeeList = [
    CoffeeModel(
        1,
        'Caffe Mocha',
        'Deep Foam',
        4.8,
        230,
        'assets/images/coffee_1.png',
        4.53,
        false,
        'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
        0,
        LatLng(0, 0),
        'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.'),
    CoffeeModel(
        2,
        'Flat White',
        'Espresso',
        5,
        100,
        'assets/images/coffee_2.png',
        3.32,
        false,
        'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
        0,
        LatLng(0, 0),
        'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.'),
    CoffeeModel(
        3,
        'Caffe Mocha',
        'Deep Foam',
        4.8,
        230,
        'assets/images/coffee_3.png',
        5.67,
        false,
        'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
        0,
        LatLng(0, 0),
        'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.'),
    CoffeeModel(
        4,
        'Caffe Latte',
        'Foam',
        8.8,
        800,
        'assets/images/coffee_4.png',
        8.85,
        false,
        'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
        0,
        LatLng(0, 0),
        'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.'),
    CoffeeModel(
        5,
        'Caffe Mocha',
        'Deep Foam',
        4.8,
        230,
        'assets/images/coffee_5.jpeg',
        4.53,
        false,
        'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
        0,
        LatLng(0, 0),
        'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.')
  ];
  return getCoffeeList;
}
