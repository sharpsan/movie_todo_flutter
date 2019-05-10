import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_todo/config/palette.dart';
import 'package:movie_todo/models/omdbapi/omdb_search_result.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TodoItemPage extends StatefulWidget {
  final Map incomingArguments;

  TodoItemPage(this.incomingArguments);

  @override
  _TodoItemPageState createState() => _TodoItemPageState();
}

class _TodoItemPageState extends State<TodoItemPage> {
  OmdbSearchResult _omdbSearchResult;

  @override
  void initState() {
    _omdbSearchResult = widget.incomingArguments["omdbSearchResult"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Palette.PRIMARY_COLOR,
        title: new Text(_omdbSearchResult.title),
      ),
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // poster image background
            new Positioned(
              child: new CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
                imageUrl: _omdbSearchResult.poster,
              ),
            ),
            // blur
            new Positioned.fill(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
            new Positioned.fill(
              child: new Scrollbar(
                child: new SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      // poster image
                      new Hero(
                        tag: _omdbSearchResult.imdbId,
                        child: new CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => new Center(
                            child: new SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          imageUrl: _omdbSearchResult.poster,
                        ),
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(_omdbSearchResult.title),
                          new Text(_omdbSearchResult.year),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
