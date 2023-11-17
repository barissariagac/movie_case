import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

Dio dioConnect = Dio(
  BaseOptions(
    baseUrl: movieBaseUrl,
    queryParameters: {"api_key": apiKey},
  ),
);
