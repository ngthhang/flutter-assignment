import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movieapp/components/title.dart';
import 'package:movieapp/components/vertical_movie_card.dart';
import 'package:movieapp/models/popular_movies_response.dart';
import 'package:movieapp/providers/bookmark_provider.dart';
import 'package:movieapp/providers/movies_provider.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen>
    with AutomaticKeepAliveClientMixin {

  void _onClickBookmark(Movie movie) {
    if (movie.isBookmarked) {
      ref.read(bookmarkNotifierProvider.notifier).addBookmark(movie);
    } else {
      ref.read(bookmarkNotifierProvider.notifier).deleteBookmark(movie.id);
    }
    ref.read(moviesNotifierProvider.notifier).reloadData(movie);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bookmarkList = ref.watch(bookmarkNotifierProvider);
    log(bookmarkList.toString());
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: [
            const AppTitle(title: "Bookmark"),
            const SizedBox(height: 10.0),
            bookmarkList.isNotEmpty
                ? Expanded(child: _buildVerticalList(bookmarkList))
                : const Center(
                    child: Text('There is no bookmark',
                        style: TextStyle(color: Colors.white, fontSize: 20.0))),
          ],
        ),
      ),
    ));
  }

  Widget _buildVerticalList(List<Movie> data) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final movie = data[index];
          return VerticalMovieCard(
              imgUrl: movie.image, title: movie.title,
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
      );

  @override
  bool get wantKeepAlive => true;
}
