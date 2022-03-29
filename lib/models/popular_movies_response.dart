import 'dart:convert';

PopularMoviesResponse popularMoviesResponseFromJson(String str) => PopularMoviesResponse.fromJson(json.decode(str));

class PopularMoviesResponse {
  PopularMoviesResponse({
    required this.items,
    required this.error,
  });

  List<Movie> items;
  String error;

  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) => PopularMoviesResponse(
    items: List<Movie>.from(json["items"].map((item) => Movie.fromJson(item))),
    error: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((item) => item.toJson())),
    "error": error,
  };

}

class Movie{
  Movie({
    required this.id,
    required this.rank,
    required this.rankUpDown,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
    this.isBookmarked = false,
  });

  String id;
  String rank;
  String rankUpDown;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;
  bool isBookmarked = false;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    rank: json["rank"],
    rankUpDown: json["rankUpDown"],
    title: json["title"],
    fullTitle: json["fullTitle"],
    year: json["year"],
    image: json["image"],
    crew: json["crew"],
    imDbRating: json["imDbRating"],
    imDbRatingCount: json["imDbRatingCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rank": rank,
    "rankUpDown": rankUpDown,
    "title": title,
    "fullTitle": fullTitle,
    "year": year,
    "image": image,
    "crew": crew,
    "imDbRating": imDbRating,
    "imDbRatingCount": imDbRatingCount,
  };

}