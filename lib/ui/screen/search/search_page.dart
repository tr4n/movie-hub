import 'package:flutter/material.dart';
import 'package:moviehub/ui/components/components.dart';

import '../../../resources/resources.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildSearchResult(["Spiderman", "Helloworld", "AB C", "123", "34234"]),
        const SizedBox(height: Sizes.size16),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size22),
      decoration: BoxDecoration(
          color: AppColor.gray3A3F47,
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 16),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search film\'s name",
                contentPadding: EdgeInsets.symmetric(vertical: Sizes.size10),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Image.asset("assets/icons/ic_search_left.png",
              width: 16, fit: BoxFit.fitWidth),
          const SizedBox(width: 16)
        ],
      ),
    );
  }

  Widget _buildSearchResult(List<String> names) {
    return names.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/img_no_result.png",
                  width: 76,
                  height: 76,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: Sizes.size16),
                DefaultTextStyle(
                  style: TextStyle(fontSize: 16, color: AppColor.grayEBEBEF),
                  child:
                      const Text("We are sorry, we can not find the movie :("),
                ),
                const SizedBox(height: Sizes.size8),
                DefaultTextStyle(
                  style: TextStyle(fontSize: 12, color: AppColor.gray92929D),
                  child: const Text(
                      "Find your movie by Type title, categories, years, etc "),
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  left: Sizes.size22, right: Sizes.size20, top: Sizes.size22),
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemMovieInformation(
                    title: names[index],
                    rate: "9.5",
                    type: "Action",
                    releaseDate: "2020",
                    duration: "129",
                    imageUrl: "https://api.lorem.space/image/book?w=150&h=230");
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: Sizes.size24);
              },
            ),
          );
  }
}
