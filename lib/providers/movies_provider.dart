import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/models/popular_movies_response.dart';
import 'package:movieapp/repositories/movies_repository.dart';

final moviesNotifierProvider = StateNotifierProvider<MoviesNotifier, AsyncValue<PopularMoviesResponse>>(
  (ref) => MoviesNotifier(ref.watch(moviesRepositoryProvider)));

class MoviesNotifier extends StateNotifier<AsyncValue<PopularMoviesResponse>> {
  final MoviesRepository _moviesRepository;

  MoviesNotifier(this._moviesRepository, [AsyncValue<PopularMoviesResponse>? popular])
      : super(AsyncValue.data(
            PopularMoviesResponse(items: [], error: "")));
            
  PopularMoviesResponse _data = PopularMoviesResponse(items: [], error: '');

  getPopularMovies() async {
    state = const AsyncValue.loading();
    try {
      final res = await _moviesRepository.getPopularMovies();
      _data = res;
      state = AsyncValue.data(res);
    } catch(e){
      state = AsyncError(e);
    }
  }
  reloadData(Movie movie) {
    _data.items.firstWhere((element) => element.id == movie.id).isBookmarked = movie.isBookmarked;
    state = AsyncValue.data(_data);
  }
}
