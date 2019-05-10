import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:movie_todo/config/config.dart';

class OmdbApiClient {
  static const DATA_REQUEST_URL = "omdbapi.com";
  static const POSTER_REQUEST_URL = "img.omdbapi.com";
  final String apiKey;

  OmdbApiClient({this.apiKey = Config.DEFAULT_OMDBAPI_KEY});

  Future<http.Response> search(
      {@required String title,
      @required String resultType,
      String year,
      @required String dataType,
      @required String plot,
      int page}) async {
    Uri url = Uri.http(DATA_REQUEST_URL, "/", {
      "apikey" : apiKey,
      "s": title,
      "type": resultType,
      "y": year,
      "r": dataType,
    });

    return await http.get(url).then((response) {
      checkHttpResponse(response);
      return response;
    });
  }

  Future<http.Response> _findByTitleOrId(
      {String id,
      String title,
      @required String resultType,
      String year,
      @required String plot,
      @required String dataType}) async {
    Uri url = Uri.http(DATA_REQUEST_URL, "/", {
      "apikey" : apiKey,
      "i" : id,
      "t" : title,
      "type" : resultType,
      "y" : year,
      "plot" : plot,
      "r" : dataType,
    });

    return await http.get(url).then((response) {
      checkHttpResponse(response);
      return response;
    });
  }

  Future<http.Response> findByTitle(
      {@required String title,
      @required String resultType,
      String year,
      @required String plot,
      @required String dataType}) async {
    return await _findByTitleOrId(
        title: title,
        resultType: resultType,
        year: year,
        plot: plot,
        dataType: dataType);
  }

  Future<http.Response> findById(
      {@required String id,
      @required String resultType,
      String year,
      @required String plot,
      @required String dataType}) async {
    return await _findByTitleOrId(
        id: id,
        resultType: resultType,
        year: year,
        plot: plot,
        dataType: dataType);
  }

  void checkHttpResponse(http.Response response) {
    if (response.statusCode == 200) {
      print("Success:");
      print("Http status code: " + response.statusCode.toString());
      print("HEADERS:");
      print(response.headers);
      print("BODY:");
      print(response.body);
    } else {
      print("Failure:");
      print("Http status code: " + response.statusCode.toString());
    }
  }
}
