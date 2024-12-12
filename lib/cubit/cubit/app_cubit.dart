import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/models/cofee_model.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            currentIndex: 0,
            coffeeList: getCoffeeList(),
            showLikeAnim: false,
          ),
        );
  void likeItem(int coffeeId) {
    final int index =
        getCoffeeList().indexWhere((element) => element.coffeeId == coffeeId);
    print('index is$index');
    final updatedCoffeeList = List<CoffeeModel>.from(state.coffeeList);
    updatedCoffeeList[index] = CoffeeModel(
        coffeeId,
        updatedCoffeeList[index].coffeeName,
        updatedCoffeeList[index].coffeeType,
        updatedCoffeeList[index].rate,
        updatedCoffeeList[index].commentCount,
        updatedCoffeeList[index].image,
        updatedCoffeeList[index].price,
        !updatedCoffeeList[index].isLiked,
        updatedCoffeeList[index].desc,
        updatedCoffeeList[index].buyCount,
        updatedCoffeeList[index].coffeeShopLocation,
        updatedCoffeeList[index].coffeeAddress);
    emit(
      state.copyWith(
          coffeeList: updatedCoffeeList,
          showLikeAnim: true,
          likedItemIndex: index),
    );
  }

  void setShowLikeAnim(bool value) {
    emit(
      state.copyWith(showLikeAnim: value),
    );
  }
}
