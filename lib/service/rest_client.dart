 import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/utils/app_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'rest_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class CoffeeClient {
  factory CoffeeClient(Dio dio, {String baseUrl}) = _CoffeeClient;

  @GET(AppConstants.coffees)
  Future<List<CoffeeModelRM>> getCoffeeList();

  // @MultiPart()
  // @POST('${AppConstants.movies}multi/')
  // Future<MovieRM> postNewMovie(@Body() FormData param);

  @GET('${AppConstants.coffees}/{id}')
  Future<CoffeeModelRM> getCoffeeDetail(@Path("id") id);

  // @GET('${AppConstants.genres}{id}/${AppConstants.movies}')
  // Future<MovieModelRM> getMovieListByGenreId(
  //   @Path("id") id,
  //   @Query('page') int page,
  // );

  // @GET(AppConstants.genres)
  // Future<List<GenresRM>> getGenresList();

}
