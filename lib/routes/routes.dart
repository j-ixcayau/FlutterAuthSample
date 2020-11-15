import 'package:auth/routes/RouteNames.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    // Adding all routes
    for (var it in listRoutes) {
      sailor.addRoute(
        SailorRoute(
          name: it.getRoute,
          builder: (context, args, params) {
            return it.getPage;
          },
        ),
      );
    }
  }
}
