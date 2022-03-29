import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/models/popular_movies_response.dart';

final bookmarkNotifierProvider =
    StateNotifierProvider<BookmarkNotifier, List<Movie>>(
        (ref) => BookmarkNotifier());

class BookmarkNotifier extends StateNotifier<List<Movie>> {
  BookmarkNotifier() : super([]);

  addBookmark(Movie movie) {
    state = [...state, movie];
  }

  deleteBookmark(String id) {
    state = state.where((movie) => movie.id != id).toList();
  }

  void when() {}
}
