import 'package:equatable/equatable.dart';
import 'package:flutter_coffee/models/card_list_rm.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';

class AppState extends Equatable {
  final int currentIndex;
  final List<CoffeeModelRM> coffeeList;
  final CardListRM cardList;
  final bool showLikeAnim;
  final bool isLoading;
  final CoffeeModelRM coffeeItem;
  final bool userLoggedIn;

  const AppState(
      {required this.currentIndex,
      required this.cardList,
      required this.coffeeList,
      required this.showLikeAnim,
      required this.isLoading,
      required this.coffeeItem,
      required this.userLoggedIn});

  AppState copyWith({
    int? currentIndex,
    List<CoffeeModelRM>? coffeeList,
    CardListRM? cardList,
    bool? showLikeAnim,
    int? likedItemIndex,
    bool? isLoading,
    CoffeeModelRM? coffeeItem,
    bool? userLoggedIn,
  }) {
    return AppState(
        cardList: cardList ?? this.cardList,
        currentIndex: currentIndex ?? this.currentIndex,
        coffeeList: coffeeList ?? this.coffeeList,
        showLikeAnim: showLikeAnim ?? this.showLikeAnim,
        isLoading: isLoading ?? this.isLoading,
        coffeeItem: coffeeItem ?? this.coffeeItem,
        userLoggedIn: userLoggedIn ?? this.userLoggedIn);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        coffeeList,
        showLikeAnim,
        isLoading,
        coffeeItem,
        userLoggedIn,
        cardList
      ];
}
