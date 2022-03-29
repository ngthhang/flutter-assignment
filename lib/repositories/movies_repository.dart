import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/models/popular_movies_response.dart';
import 'package:dio/dio.dart';
import 'package:movieapp/models/search_movies_response.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) => MoviesRepositoryImpl());

abstract class MoviesRepository {
  Future<PopularMoviesResponse> getPopularMovies();
  Future<PopularMoviesResponse> getInTheaters();
  Future<SearchData> searchMovies(String expression);
}

class MoviesRepositoryImpl extends MoviesRepository {
  static const baseURL = "https://imdb-api.com/en/API/";
  static const apiKey = "k_xtlctxd9";

  @override
  Future<PopularMoviesResponse> getPopularMovies() async {
    const api = baseURL + "MostPopularMovies/" + apiKey;
    final res = await Dio().get(api);
    if(res.statusCode == 200){
      return popularMoviesResponseFromJson(res.toString());
    } else{
      throw Exception("Something is wrong");
    }
  }

  @override
  Future<PopularMoviesResponse> getInTheaters() async {
    const api = baseURL + "InTheaters/" + apiKey;
    final res = await Dio().get(api);
    if(res.statusCode == 200){
      return popularMoviesResponseFromJson(res.toString());
    } else{
      throw Exception("Something is wrong");
    }
  }

  @override
  Future<SearchData> searchMovies(String expression) async {
    const api = baseURL + "Search/" + apiKey + '/';
    final res = await Dio().get(api + expression);
    if (res.statusCode == 200) {
      return searchDataFromJson(res.toString());
    } else {
      throw Exception("Something is wrong");
    }
  }

}