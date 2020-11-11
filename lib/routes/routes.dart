import 'package:auth/routes/routeNames.dart';
import 'package:auth/screens/dashboard/Dashboard.dart';
import 'package:auth/screens/login/LoginOptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    // For initial page
    sailor.addRoute(
      SailorRoute(
        name: initialRoute,
        builder: (context, args, params) {
          return (Provider.of<User>(context) == null)
              ? LoginOptions()
              : Dashboard();
        },
      ),
    );

    // Adding all routes
    for (var it in listRoutes) {
      sailor.addRoute(
        SailorRoute(
          name: it.route,
          builder: (context, args, params) {
            return it.page;
          },
        ),
      );
    }
  }
}
