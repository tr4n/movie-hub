import 'package:flutter/material.dart';
import 'package:moviehub/extension/context_ext.dart';

import '../../../resources/resources.dart';
import '../components/components.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<StatefulWidget> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  List<String> movies = List.empty();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: movies.isEmpty ? _buildEmptyWatchList() : _buildWatchListMovie(),
    );
  }

  Widget _buildEmptyWatchList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/ic_empty_folder.png",
          width: 76,
          height: 76,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(height: Sizes.size16),
        DefaultTextStyle(
          style: TextStyle(fontSize: 16, color: AppColor.grayEBEBEF),
          child: const Text("There is no movie yet!"),
        ),
        const SizedBox(height: Sizes.size8),
        DefaultTextStyle(
          style: TextStyle(fontSize: 12, color: AppColor.gray92929D),
          child: const Text(
              "Find your movie by Type title, categories, years, etc "),
        ),
      ],
    );
  }

  Widget _buildWatchListMovie() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
          left: Sizes.size22, right: Sizes.size20, top: Sizes.size22),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemMovieInformation(
            title: movies[index],
            rate: "9.5",
            type: "Action",
            releaseDate: "2020",
            duration: "129",
            imageUrl:
                "https://api.lorem.space/image/movie?w=150&h=${215 + index}");
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Sizes.size24);
      },
    );
  }
}
