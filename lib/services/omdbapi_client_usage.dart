import 'dart:core';
import 'package:movie_todo/models/omdbapi/omdb_data_type.dart';
import 'package:movie_todo/models/omdbapi/omdb_plot.dart';
import 'package:movie_todo/models/omdbapi/omdb_result_type.dart';
import 'package:movie_todo/services/omdbapi_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class OmdbApiClientUsage {

  OmdbApiClient _omdbApiClient;

  OmdbApiClientUsage() {
    _omdbApiClient = new OmdbApiClient();
  }

  Future<http.Response> lookup({@required String imdbId}) async {
    return await _omdbApiClient.findById(id: imdbId, resultType: OmdbResultType.MOVIE, plot: OmdbPlot.FULL, dataType: OmdbDataType.JSON).then((response) {
      return response;
    });
  }

  Future<http.Response> search({@required String query}) async {
    return await _omdbApiClient.search(title: query, resultType: OmdbResultType.MOVIE, dataType: OmdbDataType.JSON, plot: OmdbPlot.FULL).then((response) {
      return response;
    });
  }
}
