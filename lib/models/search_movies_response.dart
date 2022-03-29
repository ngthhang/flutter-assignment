import 'dart:convert';

SearchData searchDataFromJson(String str) =>
    SearchData.fromJson(json.decode(str));

String searchDataToJson(SearchData data) => json.encode(data.toJson());

class SearchData {
  SearchData({
    this.searchType,
    this.expression,
    required this.results,
    this.errorMessage,
  });

  String? searchType;
  String? expression;
  List<SearchResult> results;
  String? errorMessage;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        searchType: json["searchType"],
        expression: json["expression"],
        results: List<SearchResult>.from(
            json["results"].map((x) => SearchResult.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "searchType": searchType,
        "expression": expression,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class SearchResult {
  SearchResult({
    this.id,
    this.resultType,
    this.image,
    this.title,
    this.description,
  });

  String? id;
  String? resultType;
  String? image;
  String? title;
  String? description;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["id"],
        resultType: json["resultType"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resultType": resultType,
        "image": image,
        "title": title,
        "description": description,
      };
}