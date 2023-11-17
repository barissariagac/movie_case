import 'package:get/get.dart';
import '../../core/constants/route_constants.dart';
import '../../presentation/search_movies_page/controller/search_movie_page_bindings.dart';
import '../../presentation/search_movies_page/view/search_movie_page.dart';

List<GetPage> getPages = [
  GetPage(
    name: RouteConstant.searchMoviePage,
    page: () => const SearchMoviePage(),
    binding: SearchMovieHomePageBinding(),
  ),
];
