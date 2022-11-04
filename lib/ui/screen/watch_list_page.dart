import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/watch_list_bloc/watch_list_cubit.dart';
import 'package:moviehub/blocs/watch_list_bloc/watch_list_state.dart';
import 'package:moviehub/extension/extensions.dart';

import '../../../resources/resources.dart';
import '../../data/model/models.dart';
import '../components/components.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<StatefulWidget> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  final _cubit = WatchListCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchListCubit>(
      create: (context) => _cubit..getWatchList(),
      child: SizedBox(
        width: context.getWidth(),
        child: _watchListBody(),
      ),
    );
  }

  Widget _watchListBody() {
    return BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
      if (state is WatchListLoadingState) {
        return const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CircularProgressIndicator(),
        );
      }
      final loadedState = cast<WatchListLoadedState>(state);
      if (state is WatchListLoadFailure ||
          loadedState?.favorites.isNotEmpty != true) {
        return _buildEmptyWatchList();
      }
      return loadedState != null
          ? _buildWatchListMovie(loadedState)
          : const SizedBox();
    });
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

  Widget _buildWatchListMovie(WatchListLoadedState state) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
          left: Sizes.size22, right: Sizes.size20, top: Sizes.size22),
      itemCount: state.favorites.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemMovieInformation(
            movie: Movie.fromFavorite(state.favorites[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Sizes.size24);
      },
    );
  }
}
