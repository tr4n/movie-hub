import 'package:flutter/cupertino.dart';
import 'package:moviehub/extension/context_ext.dart';
import 'package:moviehub/resources/colors.dart';

class Top5MovieWidget extends StatelessWidget {
  final int _top;
  final String _imageUrl;

  const Top5MovieWidget(this._top, this._imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 32,
          child: Image.network(
            "https://image.shutterstock.com/image-photo/mountains-under-mist-morning-amazing-260nw-1725825019.jpg",
            // width: 145,
            // height: 210,
            fit: BoxFit.fill,
          ),
        ),
        Positioned( child: _buildTopNumber(_top))
      ],
    );
  }

  Widget _buildTopNumber(int top) {
    return DefaultTextStyle(
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 48,
          color: AppColor.colorGray242A32,
          shadows: [
            Shadow(
                // bottomLeft
                offset: const Offset(-1, -1),
                color: AppColor.colorBlue0296E5),
            Shadow(
                // bottomRight
                offset: const Offset(1, -1),
                color: AppColor.colorBlue0296E5),
            Shadow(
                // topRight
                offset: const Offset(1, 1),
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
