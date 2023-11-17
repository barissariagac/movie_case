import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/page_state_constants.dart';
import '../controller/search_movie_page_controller.dart';
import '../widget/discover_widget.dart';
import '../widget/search_widget.dart';
import '../widget/shimmer_widget.dart';

class SearchMoviePage extends GetView<SearchMoviePageController> {
  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<SearchMoviePageController>(
        init: SearchMoviePageController(),
        builder: (controller) => Scaffold(
          body: SingleChildScrollView(
            controller: controller.scrollController.value,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SearchBar(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.only(left: 10)),
                      leading: const Icon(Icons.search),
                      controller: controller.searchBarTextController.value,
                      focusNode: controller.focus.value,
                    )),
                switch (controller.status()) {
                  PageState.loadingState => const ShimmerWidget(),
                  PageState.searchState => SearchWidget(controller: controller),
                  PageState.discoverState => DiscoverWidget(
                      controller: controller,
                    )
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
