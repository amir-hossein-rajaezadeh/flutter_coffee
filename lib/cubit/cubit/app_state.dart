import 'package:equatable/equatable.dart';
import 'package:flutter_coffee/models/cofee_model.dart';

class AppState extends Equatable {
  final int currentIndex;
  final List<CoffeeModel> coffeeList;
  final bool showLikeAnim;

  const AppState(
      {required this.currentIndex,
      required this.coffeeList,
      required this.showLikeAnim,
     });

  AppState copyWith({
    int? currentIndex,
    List<CoffeeModel>? coffeeList,
    bool? showLikeAnim,
    int? likedItemIndex,
  }) {
    return AppState(
        currentIndex: currentIndex ?? this.currentIndex,
        coffeeList: coffeeList ?? this.coffeeList,
        showLikeAnim: showLikeAnim ?? this.showLikeAnim,
);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        coffeeList,
        showLikeAnim,
      ];
}
