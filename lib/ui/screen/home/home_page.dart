import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/home_bloc/home_bloc.dart';
import 'package:moviehub/blocs/home_bloc/home_event.dart';
import 'package:moviehub/ui/screen/detail/detail_page.dart';

import '../../../blocs/home_bloc/home_state.dart';
import '../../../common/common.dart';
import '../../../data/platform/network/api/urls.dart';
import '../../../resources/resources.dart';
import '../../components/top_movie_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  final _tabs = HomeTab.values;
  final bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => bloc..add(HomeGetDataEvent(_selectedTabIndex)),
      child: _homeBody(),
    );
  }

  Widget _homeBody() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _topTrendingMovies(state),
            _buildTabs(),
            const SizedBox(height: 20),
            _tabMovies(state),
          ],
        ),
      );
    });
  }

  Widget _topTrendingMovies(HomeState state) {
    if (state is HomeLoadSuccess) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: state.trendingMovies
                .take(10)
                .mapIndexed((index, movie) =>
                    TopTrendingMovieWidget(top: index + 1, movie: movie))
                .toList(),
          ),
        ),
      );
    } else if (state is HomeLoadingState) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is HomeLoadFailure) {
      CustomSnackBar.of(context).show(state.error.toString());
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: _selectedTabIndex,
      child: TabBar(
        isScrollable: true,
        indicatorColor: AppColor.gray3A3F47,
        indicatorPadding: const EdgeInsets.only(
            top: Sizes.size16, left: Sizes.size16, right: Sizes.size16),
        tabs: _tabs.map((tab) => Tab(text: tab.name)).toList(),
        onTap: (index) {
          _selectedTabIndex = index;
          bloc.add(HomeGetDataEvent(index));
        },
      ),
    );
  }

  Widget _tabMovies(state) {
    if (state is HomeLoadSuccess) {
      return GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: 100 / 145,
          children: state.tabMovies.map((movie) {
            return InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.size16),
                child: Image.network(
                  // placeholder: "assets/images/img_placeholder.png",
                  movie.posterPath != null
                      ? "${Urls.w342ImagePath}${movie.posterPath}"
                      : "https://api.lorem.space/image/movie?w=100&h=145",
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(movie: movie)),
                );
              },
            );
          }).toList());
    } else if (state is HomeLoadingState) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is HomeLoadFailure) {
      CustomSnackBar.of(context).show(state.error.toString());
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }
}
