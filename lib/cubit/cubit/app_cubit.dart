import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/service/rest_client.dart';

import 'app_state.dart';

final dio = Dio();
final client = CoffeeClient(dio);

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            coffeeItem: CoffeeModelRM(),
            currentIndex: 0,
            // coffeeList: getCoffeeList(),
            coffeeList: const [],
            isLoading: false,
            showLikeAnim: false,
          ),
        );
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

  Future<void> likeMovie(int coffeeId, BuildContext context) async {
    // if (movieName.isNotEmpty && movieDirector.isNotEmpty) {
    //   emit(
    //     state.copyWith(
    //       isLoading: true,
    //     ),
    //   );
    //   try {
    //     FormData formData = FormData.fromMap({
    //       "title": movieName,
    //       'imdb_id': 'tt0232500',
    //       'director': movieDirector,
    //       'country': state.selectedCountryName!.split(' ')[1],
    //       'imdb_rating': state.movieRate,
    //       'year': state.selectedMovieDate!.split("-")[0],
    //       if (state.selectedImage != '')
    //         "poster": await MultipartFile.fromFile(
    //           state.selectedImage!,
    //           filename: state.selectedImage!,
    //         ),
    //     });
    //     await client.postNewMovie(formData);
    //     // ignore: use_build_context_synchronously
    //     context.pop();
    //     emit(
    //       state.copyWith(
    //         isLoading: false,
    //       ),
    //     );
    //   } catch (e) {
    //     print('error is $e');
    //     emit(
    //       state.copyWith(
    //         hasError: true,
    //         isLoading: false,
    //       ),
    //     );
    //   }
    // }
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
