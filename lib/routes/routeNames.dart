import 'package:auth/model/route/Route.dart';
import 'package:auth/routes/Routes.dart';
import 'package:auth/screens/config/ConfigPage.dart';
import 'package:auth/screens/dashboard/DashboardPage.dart';
import 'package:auth/screens/dashboard/UpdateInfoPage.dart';
import 'package:auth/screens/dashboard/UserMapLocationPage.dart';
import 'package:auth/screens/utils/loading/LoadingPage.dart';
import 'package:auth/screens/login/LoginOptionsPage.dart';
import 'package:auth/screens/register/RegisterPage.dart';
import 'package:sailor/sailor.dart';
import 'package:flutter/material.dart' as material;

const String initialLoadingRoute = "/loadingRoute";
const String loginOptionsRoute = "/loginOptionsRoute";
const String registerRoute = "/registerRoute";
const String dashboardRoute = "/dashboardRoute";
const String configRoute = "/configRoute";
const String updateInfoRoute = "/updateInfoRoute";
const String mapHomeLocationRoute = "/mapHomeLocationRoute";

List<Route> listRoutes = [
  Route(initialLoadingRoute, LoadingPage()),
  Route(loginOptionsRoute, LoginOptionsPage()),
  Route(registerRoute, RegisterPage()),
  Route(dashboardRoute, DashboardPage()),
  Route(configRoute, ConfigPage()),
  Route(updateInfoRoute, UpdateInfoPage()),
  Route(mapHomeLocationRoute, UserMapLocationPage()),
];

Future navigateToPage(String route, {back = true}) {
  if (back) {
    return Routes.sailor.navigate(route);
  } else {
    return Routes.sailor.navigate(
      route,
      navigationType: NavigationType.pushAndRemoveUntil,
      removeUntilPredicate: (material.Route<dynamic> route) => false,
    );
  }
}

popPage() {
  Routes.sailor.pop();
}
