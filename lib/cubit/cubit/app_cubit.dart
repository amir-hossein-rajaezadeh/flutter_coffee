import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/models/login_model_rm.dart';
import 'package:flutter_coffee/models/register_rm.dart';
import 'package:flutter_coffee/service/rest_client.dart';
import 'package:flutter_coffee/utils/storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';

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
              isLoading: false,
              showLikeAnim: false,
              userLoggedIn: false),
        );
  void chechUserLoginStatus(BuildContext context) async {
    const kSecureClearFlag = 'SOMETHING';
    final pref = await SharedPreferences.getInstance();

    final hasRunBefore = pref.getBool(kSecureClearFlag) ?? false;
    if (!hasRunBefore) {
      _storageService.deleteAccessTokenSecure();
      _storageService.deleteRefreshTokenSecure();

      pref.setBool(kSecureClearFlag, true);
    }
    _storageService.readAccessTokenSecure().then((value) {
      if (value != null) {
        context.push("/main");

        emit(state.copyWith(userLoggedIn: true));
      } else {
        context.push("/login");

        emit(state.copyWith(userLoggedIn: false));
      }
    });
  }

  void likeItem(int coffeeId) {}

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

  Future<void> registerUser(String usernamme, String password, String firstname,
      String lasName, BuildContext context) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      Map<String, dynamic> body = {
        "username": usernamme,
        "password": password,
        "first_name": firstname,
        "last_name": lasName,
      };
      final RegisterRM response =
          await client.register(body).onError((error, stackTrace) {
        print("$error   Andfff   $stackTrace");
        return RegisterRM(statusCode: 5, detail: 'detail');
      });

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

      print(jsonEncode(response));
      saveTokens(response.accessToken, response.refreshToken);
      context.push("/main");

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

  Future<void> addItemToCart(int coffeeId, BuildContext context) async {
    _storageService.readAccessTokenSecure().then(
      (token) async {
        final Map<String, dynamic> body = {
          'coffee': coffeeId.toString(),
          'count': '1'
        };

        final response = await client.addItemToCart(
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWlyIiwiZXhwIjoxNzM0MzkzOTM0fQ.Tj7XY7oYtISZnMcReHld-3rKMRoc0w5povHo4-_sfh8",
            body); // Add the token as a header
        print("sdsdsdsd ${response['detail']}");
      },
    );
  }

  Future<void> getCoffeeDetail(int id) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final coffeeItem = await client.getCoffeeDetail(id);
      emit(
        state.copyWith(
          coffeeItem: coffeeItem,
          isLoading: false,
        ),
      );
    } catch (e) {
      print('Error is $e');
    }
  }
}

void saveTokens(String accessToken, String refreshToken) {
  _storageService.saveAccessTokenSecure(accessToken);
  _storageService.saveRefreshTokenSecure(refreshToken);
}
