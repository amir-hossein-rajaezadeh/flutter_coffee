import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee/models/card_list_rm.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/models/error_rm.dart';
import 'package:flutter_coffee/models/login_model_rm.dart';
import 'package:flutter_coffee/models/register_rm.dart';
import 'package:flutter_coffee/screens/widgets/error_handler.dart';
import 'package:flutter_coffee/service/rest_client.dart';
import 'package:flutter_coffee/utils/storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/utils.dart';
import 'app_state.dart';
import 'package:latlong2/latlong.dart';

final dio = Dio();
final client = CoffeeClient(dio);

final SecureStorageService _storageService = SecureStorageService();

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
              coffeeItem: CoffeeModelRM(),
              currentIndex: 0,
              coffeeList: const [],
              cardList: CardListRM(
                statusCode: 200,
                detail: CardItem(data: [], price: 0),
              ),
              isLoading: false,
              showLikeAnim: false,
              userLoggedIn: false),
        );
  void setupInterceptors(BuildContext context) {
    dio.interceptors.add(ErrorInterceptor(context));
  }

  void chechUserLoginStatus(BuildContext context) async {
    const kSecureClearFlag = 'SOMETHING';
    final pref = await SharedPreferences.getInstance();

    final hasRunBefore = pref.getBool(kSecureClearFlag) ?? false;
    if (!hasRunBefore) {
      _storageService.deleteAccessTokenSecure();
      _storageService.deleteRefreshTokenSecure();

      pref.setBool(kSecureClearFlag, true);
    }
    _storageService.readAllData('token').then((value) {
      if (value != null) {
        context.push("/main");

        emit(state.copyWith(userLoggedIn: true));
      } else {
        context.push("/login");

        emit(state.copyWith(userLoggedIn: false));
      }
    });
  }

  LatLng getCoffeeLocation() {
    if (state.coffeeItem.coffeeShopLocation == null) {
      throw Exception("Coffee shop location is null");
    }

    final locationString = state.coffeeItem.coffeeShopLocation!;
    final regex = RegExp(r'LatLng\(latitude:([-\d.]+), longitude:([-\d.]+)\)');
    final match = regex.firstMatch(locationString);

    if (match == null || match.groupCount != 2) {
      throw Exception("Invalid coffee shop location format");
    }

    final latitude = double.tryParse(match.group(1)!);
    final longitude = double.tryParse(match.group(2)!);

    if (latitude == null || longitude == null) {
      throw Exception("Invalid latitude or longitude values");
    }

    print("coffee object is $locationString");
    print("lat long is $latitude, $longitude");

    return LatLng(latitude, longitude);
  }

  LatLng getHomeLocation(LatLng coffeeLocation, {bool moveUp = true}) {
    const adjustment = 0.004; // Adjust this value as needed
    final newLatitude = moveUp
        ? coffeeLocation.latitude + adjustment
        : coffeeLocation.latitude - adjustment;
    return LatLng(newLatitude, coffeeLocation.longitude);
  }

  Future<void> likeItem(int coffeeId) async {
    emit(state.copyWith(isLoading: true));
    print("called");
    _storageService.readAllData('token').then((token) async {
      try {
        await client.likeCoffee("Bearer $token", coffeeId);
        getCoffeeDetail(coffeeId);
        emit(
          state.copyWith(isLoading: false, currentIndex: 0),
        );
      } catch (e) {
        print('error is $e');
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      }
    });
  }

  void setShowLikeAnim(bool value) {
    emit(
      state.copyWith(showLikeAnim: value),
    );
  }

  Future<void> getCoffeeList() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final coffeeList = await client.getCoffeeList();
      emit(
        state.copyWith(
          coffeeList: coffeeList,
          isLoading: false,
        ),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> registerUser(String username, String password, String firstname,
      String lastname, BuildContext context) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      Map<String, dynamic> body = {
        "username": username,
        "password": password,
        "first_name": firstname,
        "last_name": lastname,
      };
      final RegisterRM response =
          await client.register(body).onError((error, stackTrace) {
        print("$error   Andfff   $stackTrace");
        return RegisterRM(statusCode: 5, detail: 'detail');
      });
      _storageService.saveData("firstname", firstname);
      _storageService.saveData("lastname", lastname);
      _storageService.saveData("username", username);

      print(jsonEncode(response));

      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      context.push("/login");
    } catch (e) {
      print('error is $e');
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<void> loginUser(
      String username, String password, BuildContext context) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final LoginModelRM response = await client.login(username, password);

      saveTokens(response.accessToken, response.refreshToken);
      Utils.clearRoutesAndNavigateLogin(context, "/main");
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } catch (e) {
      print('error is $e');
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getUser(
      String username, String password, BuildContext context) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final LoginModelRM response = await client.login(username, password);

      saveTokens(response.accessToken, response.refreshToken);
      Utils.clearRoutesAndNavigateLogin(context, "/main");
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } catch (e) {
      print('error is $e');
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getCardList() async {
    print("Calledd");
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      _storageService.readAllData('token').then(
        (token) async {
          final cardList = await client.getCardList("Bearer $token");
          emit(
            state.copyWith(
              cardList: cardList,
              isLoading: false,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      print('Error getting card list: $e');
      print('Stack trace: $stackTrace');
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      throw Exception('Failed to get card list');
    }
  }

  Future<void> addItemToCart(
      int coffeeId, int count, BuildContext context) async {
    emit(
      state.copyWith(currentIndex: 0),
    );

    const String orderListRoute = '/orderList';

    print("count is $count");
    _storageService.readAllData('token').then(
      (token) async {
        final String currentUrl = GoRouterState.of(context).uri.toString();
        final Map<String, dynamic> body = {
          'coffee': coffeeId.toString(),
          'count': currentUrl != orderListRoute ? count.toString() : '1',
          'token': "Bearer $token",
        };
        try {
          print("count $count");
          if (orderListRoute == currentUrl) {
            await client.addItemToCart(body);
            emit(
              state.copyWith(currentIndex: 1),
            );
          } else {
            await client.addItemToCart(body);
            context.push(
              orderListRoute,
            );
          }
        } catch (e) {}
      },
    );
  }

  Future<void> removeItemFromCart(int coffeeId, BuildContext context) async {
    emit(
      state.copyWith(currentIndex: 0, isLoading: true),
    );

    _storageService.readAllData('token').then(
      (token) async {
        try {
          await client.removeItemFromCart("Bearer $token", coffeeId);
          await getCardList();
          emit(
            state.copyWith(
              isLoading: false,
            ),
          );
        } catch (e) {
          if (e is DioError && e.error is ErrorRM) {
            final error = e.error as ErrorRM;
            print('Error: ${error.detail} ');
          } else {
            print('Unexpected error: $e');
          }
        }
      },
    );
  }

  Future<void> getCoffeeDetail(int id) async {
    print("get Coffee Detail called");
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final coffeeItem = await client.getCoffeeDetail(id);
      print("server like is ${coffeeItem.isLiked}");
      emit(
        state.copyWith(
          coffeeItem: coffeeItem,
          currentIndex: 1,
          isLoading: false,
        ),
      );

      print("coffee Item is ${coffeeItem.isLiked}");
    } catch (e) {
      print('Error is $e');
    }
  }

  void saveTokens(String accessToken, String refreshToken) {
    _storageService.saveAccessTokenSecure(accessToken);
    _storageService.saveRefreshTokenSecure(refreshToken);
    _storageService.saveData("token", accessToken);
    _storageService.saveData("refreash", refreshToken);
  }

  Future<String> getUserInfoFromLocalDatabase(String value) async {
    String returnedValue = '';
    switch (value) {
      case 'isAdmin':
        returnedValue =
            await _storageService.readData("isSuperUser") ?? "false";
        break;
      case 'fullname':
        returnedValue =
            "${await _storageService.readData("firstname")} ${await _storageService.readData("lastname")}";
        break;
      case 'firstname':
        returnedValue = await _storageService.readData("username") ?? "";
        break;
      case 'lastname':
        returnedValue = await _storageService.readData("lastname") ?? "";
        break;
      case 'username':
        returnedValue = await _storageService.readData("username") ?? "";
      default:
        returnedValue = '';
    }

    return returnedValue;
  }

  Future<void> logout(BuildContext context) async {
    await _storageService.clearAllSecureData();
    await _storageService.clearAllPreferences();

    emit(
      state.copyWith(userLoggedIn: false),
    );

    Utils.clearRoutesAndNavigateLogin(context, "/login");
  }
}
