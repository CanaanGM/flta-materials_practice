import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:recipes/network/spoonacular_model.dart';

import '../data/models/models.dart';
import 'model_response.dart';
import 'query_result.dart';
import 'service_interface.dart';
import 'package:http/http.dart' as http;

import 'spoonacular_converter.dart';

part 'spoonacular_service.chopper.dart';

const String apiKey = 'f6a6b82c4c224d00b5f2187960f49a00';
const String apiUrl = 'https://api.spoonacular.com/';

@ChopperApi()
abstract class SpoonacularService extends ChopperService
    implements ServiceInterface {
  @override
  @Get(path: 'recipes/{id}/information?includeNutrition=false')
  Future<RecipeDetailsResponse> queryRecipe(
    @Path('id') String id,
  );

  @override
  @Get(path: 'recipes/complexSearch')
  Future<RecipeResponse> queryRecipes(
    @Query('query') String query,
    @Query('offset') int offset,
    @Query('number') int number,
  );
  static SpoonacularService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [
        MyResponseInterceptor(),
        HttpLoggingInterceptor(),
      ],
      converter: SpoonacularConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$SpoonacularService(),
      ],
    );

    return _$SpoonacularService(client);
  }
}

class MyResponseInterceptor implements Interceptor {
  MyResponseInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    chain.request.parameters['apiKey'] = apiKey;
    final params = Map<String, dynamic>.from(chain.request.parameters);
    params['apiKey'] = apiKey;

    return chain.proceed(chain.request.copyWith(parameters: params));
  }
}
