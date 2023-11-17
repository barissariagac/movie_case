import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/api_constants.dart';
import '../../movie_detail_page/view/movie_detail_page.dart';
import '../../search_movies_page/controller/search_movie_page_controller.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({
    super.key,
    required this.controller,
  });
  final SearchMoviePageController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.6),
        itemCount: controller.discoverMovie.value.results == null
            ? 0
            : controller.discoverMovie.value.results!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () async {
              await controller.getMovieDetails(
                  controller.discoverMovie.value.results![index]);
              Get.to(
                () => const MovieDetailPage(),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: null ==
                                  controller.discoverMovie.value.results![index]
                                      .posterPath
                              ? Colors.grey[800]
                              : null,
                        ),
                        width: (Get.width / 3) * 0.88,
                        height: (Get.width / 3) * 1.3,
                        child: null ==
                                controller.discoverMovie.value.results![index]
                                    .posterPath
                            ? const Center(child: Icon(Icons.image_outlined))
                            : Image.network(
                                height: (Get.width / 3) * 1.3,
                                imageBaseUrl +
                                    controller.discoverMovie.value
                                        .results![index].posterPath!,
                                fit: BoxFit.cover,
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  }
                                  return AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(seconds: 3),
                                    curve: Curves.easeOut,
                                    child: child,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return IndexedStack(
                                    index: loadingProgress == null ? 0 : 1,
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      child,
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade900,
                                        highlightColor: Colors.grey.shade800,
                                        child: Container(
                                          height: double.maxFinite,
                                          width: 120,
                                          color: Colors.grey.shade900,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        color: Colors.black54,
                        child: Text(
                            controller
                                .discoverMovie.value.results![index].voteAverage
                                .toString(),
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: (Get.width / 3) * 0.88,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                  ),
                  child: Center(
                    child: Text(
                      controller.discoverMovie.value.results![index].title ??
                          "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
