import 'dart:core';

class OmdbSearchResult {
  final String title;
  final String year;
  final String imdbId;
  final String type;
  final String poster;

  OmdbSearchResult(
      {this.title,
      this.year,
      this.poster,
      this.imdbId,
      this.type,});

  factory OmdbSearchResult.fromJson(Map<String, dynamic> json) {
    return OmdbSearchResult(
      title: json["Title"] as String,
      year: json["Year"] as String,
      poster: json["Poster"] as String,
      imdbId: json["imdbID"] as String,
      type: json["Type"] as String,
    );
  }
}
