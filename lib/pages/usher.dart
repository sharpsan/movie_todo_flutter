import 'package:flutter/material.dart';
import 'package:movie_todo/services/omdbapi_client_usage.dart';

class Usher extends StatefulWidget {
  _UsherState createState() => _UsherState();
}

class _UsherState extends State<Usher> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          //TODO: add branding background
          new Opacity(
            opacity: 0.5,
            child: new Container(
              constraints: new BoxConstraints.expand(),
              color: Colors.black,
            ),
          ),
          new Center(
            child: new Container(
              constraints: new BoxConstraints(),
              child: new CircularProgressIndicator(
                value: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
