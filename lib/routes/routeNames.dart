import 'package:auth/model/route/route.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/screens/config/ConfigPage.dart';
import 'package:auth/screens/dashboard/Dashboard.dart';
import 'package:auth/screens/dashboard/UpdateInfoPage.dart';
import 'package:auth/screens/dashboard/UserMapLocation.dart';
import 'package:auth/screens/login/LoginOptions.dart';
import 'package:auth/screens/register/Register.dart';
import 'package:sailor/sailor.dart';
import 'package:flutter/material.dart' as material;

const String initialRoute = "/";
const String loginOptionsRoute = "/loginOptions";
const String registerRoute = "/register";
const String dashboardRoute = "/dashboard";
const String configRoute = "/config";
const String updateInfoRoute = "/updateInfo";
const String mapHomeLocationRoute = "/mapHomeLocation";

List<Route> listRoutes = [
  Route(loginOptionsRoute, LoginOptions()),
  Route(registerRoute, Register()),
  Route(dashboardRoute, Dashboard()),
  Route(configRoute, ConfigPage()),
  Route(updateInfoRoute, UpdateInfoPage()),
  Route(mapHomeLocationRoute, UserMapLocation()),
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
