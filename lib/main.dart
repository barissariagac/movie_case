import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/get_page_constants.dart';
import '../../presentation/search_movies_page/view/search_movie_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      home: const SearchMoviePage(),
      theme: ThemeData.dark(),
    );
  }
}
