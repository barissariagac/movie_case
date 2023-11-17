import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.6),
        itemCount: 12,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: (Get.width / 3) * 1.3,
                      width: (Get.width / 3) * 0.88,
                      child: Container(
                        height: double.maxFinite,
                        width: 120,
                        color: Colors.grey.shade900,
                      ))
                ],
              ),
              Container(
                height: 40,
                width: (Get.width / 3) * 0.88,
                color: Colors.grey.shade900,
              ),
            ],
          );
        },
      ),
    );
  }
}
