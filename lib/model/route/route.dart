import 'package:flutter/material.dart';

class Route {
  Route(String route, StatefulWidget page) {
    this._route = route;
    this._page = page;
  }

  String _route;
  StatefulWidget _page;

  String get getRoute => _route;
  StatefulWidget get getPage => _page;

  set setRoute(String route) => _route = route;
  set setPage(StatefulWidget page) => _page = page;
}
