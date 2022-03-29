import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/components/horizontal_movie_card.dart';
import 'package:movieapp/components/title.dart';
import 'package:movieapp/models/popular_movies_response.dart';
import 'package:movieapp/providers/bookmark_provider.dart';
import 'package:movieapp/providers/movies_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(moviesNotifierProvider.notifier).getPopularMovies();
  }

  void _onClickBookmark(Movie movie){
    if(movie.isBookmarked){
      ref.read(bookmarkNotifierProvider.notifier).addBookmark(movie);
    } else {
      ref.read(bookmarkNotifierProvider.notifier).deleteBookmark(movie.id);
    }
    ref.read(moviesNotifierProvider.notifier).reloadData(movie);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(moviesNotifierProvider).when(
                data: (data) => LayoutBuilder(builder: (context, constraint) {
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: AppTitle(title: 'Popular')),
                      _buildHorizontalList(data, constraint),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: AppTitle(title: 'In theatre')),
                      _buildHorizontalList(data, constraint),
                    ],
                  );
                }),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (Object error, StackTrace? stackTrace) => Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.white)),
              );
        },
      ),
    );
  }

  Widget _buildHorizontalList(PopularMoviesResponse data, BoxConstraints constraint) => 
  Expanded(
    flex: 1,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      itemCount: data.items.length,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        final movie = data.items[index];
        return HorizontalMovieCard(
          height: constraint.maxHeight / 4,
          width: constraint.maxWidth * 2 / 3,
          imgUrl: movie.image,
          title: movie.title,
          rating: movie.imDbRating.isNotEmpty 
            ? double.parse(movie.imDbRating)
            : 0,
          isBookmarked: movie.isBookmarked,
          onBookmarkCLicked: () {
            movie.isBookmarked = !movie.isBookmarked;
            _onClickBookmark(movie);
          },
        );
      },
    )
  );

  @override
  bool get wantKeepAlive => true;
}
