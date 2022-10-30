import 'package:flutter/material.dart';
import 'package:moviehub/extension/context_ext.dart';

import '../../data/model/movie.dart';
import '../../data/platform/network/api/urls.dart';
import '../../resources/resources.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedTabIndex = 0;
  final _tabs = ["About Movie", "Reviews", "Cast"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size8),
            child: Image.asset("assets/icons/ic_left_arrow.png",
                width: Sizes.size20, height: Sizes.size20),
          ),
          onTap: () => Navigator.pop(context),
        ),
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
          child: Text("Movie"),
        ),
        backgroundColor: AppColor.gray242A32,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildMovieBackdrop(),
          const SizedBox(height: Sizes.size16),
          _buildMovieInformation(),
          const SizedBox(height: Sizes.size24),
          _buildTabs(),
          Expanded(child: _buildCasts()),
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
            image: widget.movie.backdropPath != null
                ? "${Urls.w500ImagePath}${widget.movie.backdropPath}"
                : "https://api.lorem.space/image/movie?w=375&h=210",
            width: context.getWidth(),
            height: 210,
            fit: BoxFit.cover,
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
                child: Image.network(
                  // placeholder: "assets/images/img_placeholder.png",
                  widget.movie.posterPath != null
                      ? "${Urls.w500ImagePath}${widget.movie.posterPath}"
                      : "https://api.lorem.space/image/movie?w=95&h=120",
                  width: 95,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Sizes.size12),
              Padding(
                padding: const EdgeInsets.only(bottom: Sizes.size8),
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  child: Text(widget.movie.originalTitle ?? ""),
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
                    child: Text(widget.movie.voteAverage.toString()),
                  ),
                ],
              )),
        )
      ],
    );
  }

  Widget _buildMovieInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/ic_calendar_blank.png",
          width: 16,
          height: 16,
          color: AppColor.gray696974,
        ),
        const SizedBox(width: Sizes.size4),
        DefaultTextStyle(
          style: TextStyle(fontSize: 12, color: AppColor.gray696974),
          child: Text(widget.movie.releaseDate?.substring(0, 4) ?? ""),
        ),
        Container(
          height: Sizes.size16,
          margin: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          width: Sizes.size1,
          color: AppColor.gray696974,
        ),
        Image.asset(
          "assets/icons/ic_clock.png",
          width: 16,
          height: 16,
          color: AppColor.gray696974,
        ),
        const SizedBox(width: Sizes.size4),
        DefaultTextStyle(
          style: TextStyle(fontSize: 12, color: AppColor.gray696974),
          child: const Text("148 minutes"),
        ),
        Container(
          height: Sizes.size16,
          margin: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          width: Sizes.size1,
          color: AppColor.gray696974,
        ),
        Image.asset(
          "assets/icons/ic_ticket.png",
          width: 16,
          height: 16,
          color: AppColor.gray696974,
        ),
        const SizedBox(width: Sizes.size4),
        DefaultTextStyle(
          style: TextStyle(fontSize: 12, color: AppColor.gray696974),
          child: const Text("Action"),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: Sizes.size32),
      child: DefaultTabController(
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
    );
  }

  Widget _buildAboutMovie() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 12, color: Colors.white),
      child: Text(
          "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."),
    );
  }

  Widget _buildReviews() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 12, color: Colors.white),
      child: Text(
          "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."),
    );
  }

  Widget _buildCasts() {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(8),
      crossAxisCount: 3,
      mainAxisSpacing: 18,
      crossAxisSpacing: 14,
      childAspectRatio: 100 / 145,
      children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((e) {
        return _buildItemCast("Tom Holland",
            "https://api.lorem.space/image/face?w=150&h=${150 + e}");
      }).toList(),
    );
  }

  Widget _buildItemCast(String name, String avatar) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/img_placeholder.png",
            image: avatar,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: Sizes.size8),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.white),
          child: Text(name),
        ),
      ],
    );
  }
}
