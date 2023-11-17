import 'package:get/get.dart';

import 'search_movie_page_controller.dart';

class SearchMovieHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMoviePageController>(
      () => SearchMoviePageController(),
    );
  }
}
