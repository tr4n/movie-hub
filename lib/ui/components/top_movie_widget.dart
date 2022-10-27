import 'package:flutter/material.dart';
import 'package:moviehub/resources/colors.dart';

import '../../resources/app_sizes.dart';

class Top5MovieWidget extends StatelessWidget {
  final int top;
  final String imageUrl;

  const Top5MovieWidget({required this.top, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Sizes.size30),
      child: Stack(
        children: [
          const SizedBox(width: 160, height: 250),
          Positioned(
            left: 12,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: FadeInImage.assetNetwork(
                placeholder:  "assets/images/img_placeholder.png",
                image: "https://api.lorem.space/image/book?w=150&h=220",
                width: 145,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(bottom: 0, child: _buildTopNumber(top)),
        ],
      ),
    );
  }

  Widget _buildTopNumber(int top) {
    return DefaultTextStyle(
      style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: AppColor.gray242A32,
          shadows: [
            Shadow(
                // bottomLeft
                offset: const Offset(-0.5, -0.5),
                color: AppColor.blue0296E5),
            Shadow(
                // bottomRight
                offset: const Offset(0.5, -0.5),
                color: AppColor.blue0296E5),
            Shadow(
                // topRight
                offset: const Offset(0.5, 0.5),
                color: AppColor.blue0296E5),
            Shadow(
                // topLeft
                offset: const Offset(-1, 1),
                color: AppColor.blue0296E5),
          ]),
      child: Text(top.toString()),
    );
  }
}
