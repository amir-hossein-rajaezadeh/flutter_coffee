import 'package:equatable/equatable.dart';

import '../../../models/card_list_rm.dart';
import '../../../models/coffee_model_rm.dart';
import '../../../models/user_list_rm.dart';

class AdminPannelState extends Equatable {
  final bool isLoading;
  final String selectedImage;
  final String selectedLocation;
  final int selecteeCoffeeSize;
  final UserListRM userList;
  final List<CoffeeModelRM> coffeeList;
  final CardListRM cardList;

  const AdminPannelState(
      {required this.isLoading,
      required this.selectedImage,
      required this.selectedLocation,
      required this.selecteeCoffeeSize,
      required this.userList,
      required this.coffeeList,
      required this.cardList});

  AdminPannelState copyWith(
      {bool? isLoading,
      String? selectedImage,
      String? selectedLocation,
      int? selecteeCoffeeSize,
      UserListRM? userList,
      CardListRM? cardList,
      List<CoffeeModelRM>? coffeeList}) {
    return AdminPannelState(
        selecteeCoffeeSize: selecteeCoffeeSize ?? this.selecteeCoffeeSize,
        isLoading: isLoading ?? this.isLoading,
        selectedImage: selectedImage ?? this.selectedImage,
        selectedLocation: selectedLocation ?? this.selectedLocation,
        userList: userList ?? this.userList,
        coffeeList: coffeeList ?? this.coffeeList,
        cardList: cardList ?? this.cardList);
  }

  @override
  List<Object> get props => [
        isLoading,
        selectedImage,
        userList,
        coffeeList,
        selectedLocation,
        selecteeCoffeeSize
      ];
}
