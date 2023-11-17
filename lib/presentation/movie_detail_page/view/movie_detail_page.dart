import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/api_constants.dart';
import '../../../model/movie_detail_model.dart';
import '../../search_movies_page/controller/search_movie_page_controller.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchMoviePageController>(
      init: SearchMoviePageController(),
      builder: (controller) {
        MovieDetail movie = controller.detailMovie.value;
        List<String> genres = [];
        if (movie.genres != []) {
          for (var element in movie.genres!) {
            genres.add(element.name!);
          }
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(movie.title ?? ""),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: null == movie.backdropPath
                    ? null
                    : DecorationImage(
                        image:
                            NetworkImage(imageBaseUrl + movie.backdropPath!))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: null == movie.posterPath ? Colors.grey[300] : null,
                    ),
                    width: (Get.width / 3) * 0.88,
                    height: (Get.width / 3) * 1.3,
                    child: null == movie.posterPath
                        ? const Center(child: Icon(Icons.image_outlined))
                        : Image.network(
                            height: (Get.width / 3) * 1.3,
                            imageBaseUrl + movie.posterPath!,
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
                            loadingBuilder: (context, child, loadingProgress) {
                              return IndexedStack(
                                index: loadingProgress == null ? 0 : 1,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  child,
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: double.maxFinite,
                                      width: 120,
                                      color: Colors.grey.shade300,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 240,
                        child: Text(movie.overview!),
                      ),
                      Text(genres
                          .toString()
                          .substring(1, genres.toString().length - 1)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
