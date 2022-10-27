import 'package:flutter/material.dart';
import 'package:moviehub/extension/context_ext.dart';

import '../../../resources/resources.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedTabIndex = 0;
  final _tabs = ["Now playing", "Upcoming", "Top rated", "Popular"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.all(Sizes.size8),
            child: Image.asset("assets/icons/ic_left_arrow.png",
                width: Sizes.size20, height: Sizes.size20)),
        centerTitle: true,
        actions: [
          Image.asset("assets/icons/ic_book_mark_filled.png",
              width: Sizes.size18, height: Sizes.size24),
          const SizedBox(width: Sizes.size24),
        ],
        title: const DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          child: Text("Detail"),
        ),
        backgroundColor: AppColor.gray242A32,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildMovieBackdrop(),
        ],
      ),
    );
  }

  Widget _buildMovieBackdrop() {
    return Stack(
      children: [
        SizedBox(width: context.getWidth(), height: 270),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Sizes.size16),
            bottomRight: Radius.circular(Sizes.size16),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/img_placeholder.png",
            image: "https://api.lorem.space/image/movie?w=375&h=220",
            width: context.getWidth(),
            height: 210,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.size16),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/img_placeholder.png",
                  image: "https://api.lorem.space/image/movie?w=95&h=120",
                  width: 95,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: Sizes.size12),
              const Padding(
                padding: EdgeInsets.only(bottom: Sizes.size8),
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  child: Text("Spiderman No Way Home"),
                ),
              ),
              const SizedBox(width: Sizes.size30),
            ],
          ),
        ),
        Positioned(
          top: 178,
          right: 12,
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8, vertical: Sizes.size4),
              decoration: BoxDecoration(
                  color: AppColor.gray3A3F47,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Sizes.size8))),
              child: Wrap(
                alignment: WrapAlignment.end,
                runAlignment: WrapAlignment.end,
                children: [
                  Image.asset(
                    "assets/icons/ic_star.png",
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: Sizes.size4),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.orangeFF8700,
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text("9.5"),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
