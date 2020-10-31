import 'package:auth/model/route.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/screens/dashboard/ConfigPage.dart';
import 'package:auth/screens/dashboard/Dashbard.dart';
import 'package:auth/screens/login/LoginOptions.dart';
import 'package:auth/screens/register/Register.dart';
import 'package:sailor/sailor.dart';

const String initialRoute = "/";
const String loginOptionsRoute = "/loginOptions";
const String registerRoute = "/register";
const String dashboardRoute = "/dashboard";
const String configRoute = "/config";

List<Route> listRoutes = [
  Route(loginOptionsRoute, LoginOptions()),
  Route(registerRoute, Register()),
  Route(dashboardRoute, Dashboard()),
  Route(configRoute, ConfigPage()),
];

navigateToPage(String route, {back = true}) {
  if (back) {
    Routes.sailor(route);
  } else {
    Routes.sailor
        .navigate(route, navigationType: NavigationType.pushAndRemoveUntil);
  }
}

popPage() {
  Routes.sailor.pop();
}
