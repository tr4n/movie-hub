import 'package:flutter/material.dart';
import 'package:moviehub/data/model/movie.dart';
import 'package:moviehub/resources/colors.dart';

import '../../data/platform/network/api/urls.dart';
import '../../resources/app_sizes.dart';
import '../screen/detail_page.dart';

class TopTrendingMovieWidget extends StatelessWidget {
  final int top;
  final Movie movie;

  const TopTrendingMovieWidget(
      {required this.top, required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: Sizes.size30),
        child: Stack(
          children: [
            const SizedBox(width: 160, height: 250),
            Positioned(
              left: 12,
              bottom: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.size16),
                child: Image.network(
                  // placeholder: "assets/images/img_placeholder.png",
                  movie.posterPath != null
                      ? "${Urls.w342ImagePath}${movie.posterPath}"
                      : "https://api.lorem.space/image/book?w=145&h=210",
                  width: 145,
                  height: 210,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(bottom: 0, child: _buildTopNumber(top)),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(movie: movie)),
        );
      },
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
