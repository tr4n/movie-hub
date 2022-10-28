import 'package:flutter/material.dart';
import 'package:moviehub/ui/components/top_movie_widget.dart';

import '../../../resources/resources.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  final _tabs = ["Now playing", "Upcoming", "Top rated", "Popular"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [_buildTop5(), _buildTabs()],
      ),
    );
  }

  Widget _buildTop5() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          children: [1, 2, 3, 4, 5].map((e) => Top5MovieWidget(top: e, imageUrl: "")).toList(),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        DefaultTabController(
          length: _tabs.length,
          // body: Text(_tabs[_selectedTabIndex]),
          child: TabBar(
            isScrollable: true,
            indicatorColor: AppColor.gray3A3F47,
            indicatorPadding: const EdgeInsets.only(
                top: Sizes.size16, left: Sizes.size16, right: Sizes.size16),
            tabs: _tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: 100 / 145,
          children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: FadeInImage.assetNetwork(
                placeholder:  "assets/images/img_placeholder.png",
                image: "https://api.lorem.space/image/movie?w=150&h=${240 + e}",
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
        // Center(
        //   child: Text(_tabs[_selectedTabIndex]),
        // )
      ],
    );
  }
}
