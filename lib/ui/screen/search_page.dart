import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/search_bloc/search_cubit.dart';
import 'package:moviehub/blocs/search_bloc/search_state.dart';
import 'package:moviehub/ui/components/components.dart';
import 'package:moviehub/ui/screen/detail_page.dart';

import '../../../resources/resources.dart';
import '../../data/model/models.dart';
import '../../extension/extensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _cubit = SearchCubit();
  final _textController = TextEditingController();
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (query.length < 3) return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _cubit.search(query);
    });
  }

  _onNavigateToDetail(Movie movie) {
    _textController.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(movie: movie)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => _cubit,
      child: _searchBody(),
    );
  }

  Widget _searchBody() {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      return Column(
        children: [
          _buildSearchBar(),
          _buildSearchContent(state),
          const SizedBox(height: Sizes.size16),
        ],
      );
    });
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size22),
      decoration: BoxDecoration(
          color: AppColor.gray3A3F47,
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size16))),
      child: TextField(
        controller: _textController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search film's name",
          prefixIcon:
              Icon(Icons.search, color: Colors.white54, size: Sizes.size16),
        ),
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        onChanged: _onSearchChanged,
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  Widget _buildSearchContent(SearchState state) {
    final loadedState = cast<SearchLoadedState>(state);
    if (state is SearchLoadFailure || loadedState?.movies.isNotEmpty != true) {
      return _searchEmpty();
    }
    if (loadedState != null) {
      return _searchResult(loadedState);
    }
    return _searchLoading();
  }

  Widget _searchResult(SearchLoadedState state) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: Sizes.size22, right: Sizes.size20, top: Sizes.size22),
        itemCount: state.movies.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemMovieInformation(
            movie: state.movies[index],
            onTap: () => _onNavigateToDetail(state.movies[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: Sizes.size24);
        },
      ),
    );
  }

  Widget _searchLoading() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _searchEmpty() {
    return Expanded(
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
            child: const Text("We are sorry, we can not find the movie :("),
          ),
          const SizedBox(height: Sizes.size8),
          DefaultTextStyle(
            style: TextStyle(fontSize: 12, color: AppColor.gray92929D),
            child: const Text(
                "Find your movie by Type title, categories, years, etc "),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
