import 'package:flutter/cupertino.dart';
import 'package:moviehub/extension/context_ext.dart';
import 'package:moviehub/resources/colors.dart';

import '../../resources/app_sizes.dart';

class Top5MovieWidget extends StatelessWidget {
  final int _top;
  final String _imageUrl;

  const Top5MovieWidget(this._top, this._imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Sizes.size30),
      child: Stack(
        children: [
          const SizedBox(width: 160, height: 250),
          Positioned(
            left: 12,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: Image.network(
                "https://image.shutterstock.com/image-photo/mountains-under-mist-morning-amazing-260nw-1725825019.jpg",
                width: 145,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(bottom: 0, child: _buildTopNumber(_top)),
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
          color: AppColor.colorGray242A32,
          shadows: [
            Shadow(
                // bottomLeft
                offset: const Offset(-0.5, -0.5),
                color: AppColor.colorBlue0296E5),
            Shadow(
                // bottomRight
                offset: const Offset(0.5, -0.5),
                color: AppColor.colorBlue0296E5),
            Shadow(
              // topRight
                offset: const Offset(0.5, 0.5),
                color: AppColor.colorBlue0296E5),
            Shadow(
              // topLeft
                offset: const Offset(-1, 1),
                color: AppColor.colorBlue0296E5),
          ]),
      child: Text(top.toString()),
    );
  }
}
