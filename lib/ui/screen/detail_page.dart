import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/detail_bloc/detail_cubit.dart';
import 'package:moviehub/blocs/detail_bloc/detail_state.dart';
import 'package:moviehub/common/type/detail_tab.dart';
import 'package:moviehub/extension/context_ext.dart';

import '../../common/common.dart';
import '../../data/model/models.dart';
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
  static const double _endReachedThreshold = 200;
  final ScrollController _controller = ScrollController();
  final _tabs = ["About Movie", "Reviews", "Cast"];
  final _cubit = DetailCubit();

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final isLoading =
        cast<DetailLoadedState>(_cubit.state)?.isLoadingMore == true;
    if (!_controller.hasClients || isLoading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _cubit.loadReviewData(widget.movie.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailCubit>(
      create: (context) => _cubit..loadDataFirstTime(widget.movie.id),
      child: _detailBody(),
    );
  }

  Widget _detailBody() {
    return BlocBuilder<DetailCubit, DetailState>(builder: (context, state) {
      final loadedState = cast<DetailLoadedState>(state);
      if (loadedState != null) {
        _selectedTabIndex = loadedState.tabId;
      }
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
            _buildMovieBackdrop(state),
            const SizedBox(height: Sizes.size16),
            _buildMovieInformation(state),
            const SizedBox(height: Sizes.size16),
            _buildTabs(state),
            Expanded(
                child: _selectedTabIndex == DetailTab.aboutMovie.id
                    ? _buildAboutMovie(state)
                    : _selectedTabIndex == DetailTab.reviews.id
                        ? _buildReviews(state)
                        : _buildCasts(state)),
          ],
        ),
      );
    });
  }

  Widget _buildMovieBackdrop(DetailState state) {
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

  Widget _buildMovieInformation(DetailState state) {
    final loadedState = cast<DetailLoadedState>(state);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
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
          ],
        ),
        loadedState?.movie.runtime != null
            ? Row(
                children: [
                  const SizedBox(width: 30),
                  Image.asset(
                    "assets/icons/ic_clock.png",
                    width: 16,
                    height: 16,
                    color: AppColor.gray696974,
                  ),
                  const SizedBox(width: Sizes.size4),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 12, color: AppColor.gray696974),
                    child: Text("${loadedState?.movie.runtime ?? 0} minutes"),
                  )
                ],
              )
            : const SizedBox(),
        loadedState?.movie.genres?.isNotEmpty == true
            ? Row(
                children: [
                  const SizedBox(width: 30),
                  Image.asset(
                    "assets/icons/ic_ticket.png",
                    width: 16,
                    height: 16,
                    color: AppColor.gray696974,
                  ),
                  const SizedBox(width: Sizes.size4),
                  DefaultTextStyle(
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, color: AppColor.gray696974),
                      softWrap: true,
                      child: Text(loadedState?.movie.listGenresString() ?? "")),
                ],
              )
            : const SizedBox()
      ],
    );
  }

  Widget _buildTabs(DetailState state) {
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
          onTap: (index) {
            _cubit.changeTab(widget.movie.id, index);
          },
        ),
      ),
    );
  }

  Widget _buildAboutMovie(DetailState state) {
    final loadedState = cast<DetailLoadedState>(state);

    return Container(
      margin: const EdgeInsets.all(Sizes.size24),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 12, color: Colors.white, height: 1.5),
        child: Text(loadedState?.movie.overview ?? ""),
      ),
    );
  }

  Widget _buildReviews(DetailState state) {
    final loadedState = cast<DetailLoadedState>(state);
    final reviews = loadedState?.reviews ?? List.empty();
    return Container(
      margin: const EdgeInsets.only(
          top: Sizes.size24, left: Sizes.size24, right: Sizes.size24),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return _itemReview(reviews[index]);
        },
      ),
    );
  }

  Widget _buildCasts(DetailState state) {
    final loadedState = cast<DetailLoadedState>(state);
    if (loadedState == null) {
      return const SizedBox();
    }
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(8),
      crossAxisCount: 3,
      mainAxisSpacing: 18,
      crossAxisSpacing: 14,
      childAspectRatio: 100 / 145,
      children: loadedState.casts.map(_buildItemCast).toList(),
    );
  }

  Widget _buildItemCast(Cast cast) {
    final profileImage = cast.profilePath != null
        ? "${Urls.w342ImagePath}${cast.profilePath}"
        : "https://api.lorem.space/image/face?w=100&h=${(cast.id ?? 0) % 10 + 100}";
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            profileImage,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: Sizes.size8),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.white),
          child: Text(cast.name ?? ""),
        ),
      ],
    );
  }

  Widget _itemReview(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.size16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Sizes.size8),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  review.getAvatarAuthorUrl(),
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: Sizes.size8),
              DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: AppColor.blue0296E5),
                child: Text(review.authorDetails?.rating?.toString() ?? ""),
              ),
            ],
          ),
          const SizedBox(width: Sizes.size12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  child: Text(review.getAuthorName()),
                ),
                const SizedBox(height: Sizes.size8),
                DefaultTextStyle(
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Text(review.content ?? "", maxLines: 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
