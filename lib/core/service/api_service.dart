import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/service/dio_settings.dart';
import '../../model/movie_detail_model.dart';
import '../../model/movie_model.dart';

class ApiService {
  Future<Movie> getMoviePage(int page) async {
    Response? response;
    await dioConnect.get(
      discoverEndpoint,
      queryParameters: {"page": page},
    ).then((value) => response = value);
    return movieFromJson(response!.data);
  }

  Future<Movie> getMovieSearch(String input, int page) async {
    Response? response;

    await dioConnect.get(
      searchEndpoint,
      queryParameters: {"query": input, "page": page},
    ).then((value) => response = value);
    return movieFromJson(response!.data);
  }

  Future<MovieDetail> getMovieDetail(int input) async {
    Response? response;
    await dioConnect
        .get(
          detailEndpoint + input.toString(),
        )
        .then((value) => response = value);
    return movieDetailFromJson(response!.data);
  }
}
