import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/models/login_model_rm.dart';
import 'package:flutter_coffee/models/register_rm.dart';
import 'package:flutter_coffee/utils/app_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class CoffeeClient {
  factory CoffeeClient(Dio dio, {String baseUrl}) = _CoffeeClient;

  @GET(AppConstants.coffees)
  Future<List<CoffeeModelRM>> getCoffeeList();

  @POST(AppConstants.login)
  Future<LoginModelRM> login(
    @Query('username') String username,
    @Query('password') String password,
  );

  @POST(AppConstants.register)
  Future<RegisterRM> register(@Body() Map<String, dynamic> body);

  @GET('${AppConstants.coffees}/{id}')
  Future<CoffeeModelRM> getCoffeeDetail(@Path("id") id);

  @POST(AppConstants.cart)
  Future<dynamic> addItemToCart(
        @Header("Authorization") String token, @Body() Map<String, dynamic> body);
}
