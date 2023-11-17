import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/page_state_constants.dart';
import '../../../core/service/api_service.dart';

import '../../../model/movie_detail_model.dart';
import '../../../model/movie_model.dart';

class SearchMoviePageController extends GetxController {
  Rx<Movie> discoverMovie = Movie().obs;
  Rx<Movie> searchMovie = Movie().obs;
  Rx<MovieDetail> detailMovie = MovieDetail().obs;
  Rx<TextEditingController> searchBarTextController =
      TextEditingController().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  Rx<int> discoverPage = 1.obs;
  Rx<int> searchPage = 1.obs;
  Rx<String> previousSearch = "".obs;
  Rx<double> positionCounter = 750.00.obs;
  Rx<FocusNode> focus = FocusNode().obs;

  Rx<PageState> status = Rx<PageState>(PageState.loadingState);
  Future<void> getDiscoverMovies() async {
    try {
      if (discoverPage.value == 1) {
        status.value = PageState.loadingState;
      }
      await ApiService().getMoviePage(discoverPage.value).then(
            (data) => discoverPage.value == 1
                ? discoverMovie.value = data
                : discoverMovie.value.results!.addAll(data.results!),
          );
    } catch (e) {
      log('Error while getting data is $e');
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {
      status.value = PageState.discoverState;
    }
  }

  Future<void> getSearchMovies() async {
    try {
      await ApiService()
          .getMovieSearch(searchBarTextController.value.text, searchPage.value)
          .then(
            (data) => previousSearch.value
                    .contains(searchBarTextController.value.text)
                ? searchPage.value == 1
                    ? searchMovie.value = data
                    : searchMovie.value.results!.addAll(data.results!)
                : searchMovie.value = data,
          );
    } catch (e) {
      log('Error while getting data is $e');
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {
      status.value = PageState.searchState;
    }
  }

  Future<void> getMovieDetails(Result movie) async {
    try {
      await ApiService()
          .getMovieDetail(movie.id!)
          .then((data) => detailMovie.value = data);
    } catch (e) {
      log('Error while getting data is $e');
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    }
  }

  @override
  Future<void> onInit() async {
    scrollController.value.addListener(
      () async {
        if (scrollController.value.position.pixels ==
            scrollController.value.position.maxScrollExtent) {
          switch (status.value) {
            case PageState.discoverState:
              if (discoverMovie.value.totalPages! > discoverPage.value) {
                discoverPage.value++;
              }
              await getDiscoverMovies();
              discoverMovie.refresh();
              break;
            case PageState.searchState:
              if (searchMovie.value.totalPages! > searchPage.value) {
                searchPage.value++;
              }
              await getSearchMovies();
              searchMovie.refresh();
              break;
            default:
          }
        }
      },
    );
    searchBarTextController.value.addListener(() {
      if (searchBarTextController.value.text.length > 2) {
        previousSearch.value = searchBarTextController.value.text;
        getSearchMovies();
        searchMovie.refresh();
      }
    });
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  InternalFinalCallback<void> get onStart {
    getDiscoverMovies();
    return super.onStart;
  }

  @override
  void onClose() {}
}
