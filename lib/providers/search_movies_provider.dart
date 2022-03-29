import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/models/search_movies_response.dart';
import 'package:movieapp/repositories/movies_repository.dart';

final searchMoviesNotifierProvider =
    StateNotifierProvider<SearchMoviesNotifier, AsyncValue<SearchData>>(
        (ref) => SearchMoviesNotifier(ref.watch(moviesRepositoryProvider)));

class SearchMoviesNotifier extends StateNotifier<AsyncValue<SearchData>> {
  final MoviesRepository _moviesRepository;

  SearchMoviesNotifier(this._moviesRepository, [AsyncValue<SearchData>? popular])
      : super(AsyncValue.data(SearchData(results: [])));

  searchMovies(String expression) async {
    state = const AsyncValue.loading();
    try {
      final res = await _moviesRepository.searchMovies(expression);
      state = AsyncValue.data(res);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
