import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/components/title.dart';
import 'package:movieapp/components/vertical_movie_card.dart';
import 'package:movieapp/models/search_movies_response.dart';
import 'dart:developer';

import 'package:movieapp/providers/search_movies_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(searchMoviesNotifierProvider.notifier);
  }

  void _search(String expression) {
    if (expression.isNotEmpty) {
      ref.read(searchMoviesNotifierProvider.notifier).searchMovies(expression);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(children: [
            const AppTitle(title: "Search"),
            const SizedBox(height: 10.0),
            _searchInput(),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return ref.watch(searchMoviesNotifierProvider).when(
                      data: (data) => _buildVerticalList(data),
                      error: (err, st) => Text(err.toString(),
                          style: const TextStyle(color: Colors.white)),
                      loading: () => const Center(
                          child:
                              CircularProgressIndicator(color: Colors.yellow)),
                    );
              }),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _searchInput() => TextField(
        onSubmitted: (data) => _search(data),
        decoration: const InputDecoration(
          hintText: "Search movie",
          filled: true,
          fillColor: Colors.yellow,
          prefixIcon: Icon(Icons.search, color: Colors.black),
          counterStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black,
      );

  Widget _buildVerticalList(SearchData data) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: data.results.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final movie = data.results[index];
          return VerticalMovieCard(
              imgUrl: movie.image ?? '', title: movie.title ?? '', rating: 0);
        },
      );

  @override
  bool get wantKeepAlive => true;
}
