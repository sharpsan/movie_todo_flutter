import 'package:flutter/material.dart';
import 'package:movie_todo/config/palette.dart';
import 'package:movie_todo/models/omdbapi/omdb_search_result.dart';
import 'package:movie_todo/services/omdbapi_client_usage.dart';
import 'package:movie_todo/widgets/grid_item.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  final Map incomingArguments;

  SearchPage(this.incomingArguments);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchBoxController = TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = "";
  Widget _appBarTitle = new Text('Search');
  OmdbApiClientUsage _omdbApiClientUsage;
  List<OmdbSearchResult> _searchResults;

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Palette.PRIMARY_COLOR,
      centerTitle: true,
      title: new Stack(
        children: <Widget>[
          _appBarTitle,
        ],
      ),
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          autofocus: true,
          controller: _searchBoxController,
          textInputAction: TextInputAction.search,
          onSubmitted: (newValue) => _search(newValue),
          decoration: new InputDecoration(
              border: InputBorder.none,
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search');
      }
    });
  }

  void _search(String query) {
    _omdbApiClientUsage.search(query: query).then((results) {
      setState(() {
        _searchResults.clear();
      });
      Map<String, dynamic> resultsJson = json.decode(results.body);
      List<dynamic> searchResultsJson = List.from(resultsJson["Search"]);
      searchResultsJson.forEach((result) {
        //print(result);
        OmdbSearchResult movie = new OmdbSearchResult.fromJson(result);
        setState(() {
          _searchResults.add(movie);
        });
      });
    });
  }

  void _handleGridItemPress(OmdbSearchResult omdbResult, BuildContext context) {
    Map arguments = new Map();
    arguments["omdbSearchResult"] = omdbResult;
    Navigator.pushNamed(context, "/todoItemPage", arguments: arguments);
  }

  Widget _buildGridView(BuildContext context) {
    return new GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (300 / 445),
      ),
      itemCount: _searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        OmdbSearchResult omdbResult = _searchResults[index];
        return new Hero(
          tag: omdbResult.imdbId,
          child: new Stack(
            children: <Widget>[
              new Positioned.fill(
                child: new GridItem(imageUrl: omdbResult.poster),
              ),
              new Material(
                color: Colors.transparent,
                child: new InkWell(
                  onTap: () => _handleGridItemPress(omdbResult, context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _omdbApiClientUsage = new OmdbApiClientUsage();
    _searchResults = new List<OmdbSearchResult>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Palette.BLUE_GREY,
      body: (_searchResults.length == 0)
          ? new Center(
              child: new Text(
                "Search to find movies",
                style: new TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),
            )
          : _buildGridView(context),
      appBar: _buildBar(context),
    );
  }
}
