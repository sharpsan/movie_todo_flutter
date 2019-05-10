import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_todo/config/palette.dart';
import 'package:movie_todo/pages/search_page.dart';
import 'package:movie_todo/pages/todo_item_page.dart';
import 'package:movie_todo/pages/todo_list_page.dart';
import 'package:movie_todo/pages/usher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(settings, new Usher());
      case '/todoListPage':
        return _buildRoute(settings, new TodoListPage(settings.arguments));
      case '/todoItemPage':
        return _buildRoute(settings, new TodoItemPage(settings.arguments));
      case '/searchPage':
        return _buildRoute(settings, new SearchPage(settings.arguments));
      default:
        return null; //TODO: add 404 page route
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Palette.PRIMARY_COLOR,
    )); // set status bar color to match app bar
    return MaterialApp(
      initialRoute: '/searchPage',
      onGenerateRoute: _getRoute,
      theme: ThemeData(primaryColor: Palette.PRIMARY_COLOR),
    );
  }
}
