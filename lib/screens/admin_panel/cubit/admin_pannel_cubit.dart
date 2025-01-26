import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/models/card_list_rm.dart';
import 'package:flutter_coffee/models/user_list_rm.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:latlong2/latlong.dart';
import '../../../service/rest_client.dart';
import '../../../utils/storage.dart';
import '../../widgets/error_handler.dart';
import 'admin_pannel_state.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final dio = Dio();
final client = CoffeeClient(dio);
final SecureStorageService _storageService = SecureStorageService();

class AdminPannelCubit extends Cubit<AdminPannelState> {
  AdminPannelCubit()
      : super(
          AdminPannelState(
            selectedLocation: "",
            isLoading: false,
            selecteeCoffeeSize: 0,
            selectedImage: "",
            userList: UserListRM(
                errorMessage: "",
                statusCode: 400,
                detail:
                    Detail(results: [], totalCount: 0, page: 0, pageSize: 0)),
            coffeeList: const [],
            cardList: CardListRM(
              statusCode: 200,
              detail: CardItem(data: [], price: 0),
            ),
          ),
        );
  void setupInterceptors(BuildContext context) {
    dio.interceptors.add(ErrorInterceptor(context));
  }

  void setSelectedCoffeeSize(int selectedItemIndex) {
    emit(
      state.copyWith(selecteeCoffeeSize: selectedItemIndex),
    );
    print("ssss ${state.selecteeCoffeeSize}");
  }

  Future<void> selectImage() async {
    final File? imageFile;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    emit(
      state.copyWith(selectedImage: croppedFile!.path),
    );
  }

  Future<void> addCoffee(
      String coffeeName,
      String coffeeType,
      double price,
      String desc,
      String coffeeShopLocation,
      String coffeeAddress,
      int rate,
      String coffeeSize,
      BuildContext context) async {
    emit(
      state.copyWith(isLoading: true),
    );

    try {
      final token = await _storageService.readAllData('token');
      print("coffeeShopLocation ${state.selectedLocation}");
      // Prepare FormData
      final formData = FormData.fromMap({
        "coffeeName": coffeeName,
        "coffeeType": coffeeType,
        "rate": rate,
        "commentCount": 1,
        "price": price,
        "isLiked": false,
        "desc": desc,
        "buyCount": 1,
        "coffeeShopLocation": state.selectedLocation,
        "coffeeAddress": coffeeAddress,
        "coffeeSize": state.selecteeCoffeeSize,
        "image": await MultipartFile.fromFile(
          state.selectedImage,
        ),
      });

      // Call the API
      await client.addCoffee(
        "Bearer $token", // Pass token in Authorization header
        formData,
      );

      emit(
        state.copyWith(isLoading: false),
      );
    } catch (e) {
      if (e is DioError) {
        print('Dio Error: ${e.message}');
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      emit(
        state.copyWith(isLoading: false),
      );
    }
  }

  Future<void> getUserList() async {
    emit(
      state.copyWith(isLoading: true),
    );

    try {
      _storageService.readData("token").then(
        (token) async {
          print(token);

          final userList = await client.getUserList("Bearer $token");

          emit(
            state.copyWith(
              userList: userList,
              isLoading: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      print('Error is $e');
    }
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
          userList: null,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      print('Error is $e');
    }
  }

  Future<void> getCardList() async {
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
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      print('Error is $e');
    }
  }

  void selectCoffeeLocationLatLong(LatLng latlong) {
    print("dfgdg${state.selectedLocation}");

    emit(
      state.copyWith(
        selectedLocation: latlong.toString(),
      ),
    );
  }

  void resetData() {
    print("called");
    emit(state.copyWith(selectedImage: "", selectedLocation: ""));
  }
}
