import 'package:auth/screens/dashboard/Dashbard.dart';
import 'package:auth/screens/login/LoginOptions.dart';
import 'package:auth/screens/register/Register.dart';
import 'package:auth/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Routes {
  static routes() {
    return {
      initialRoute: (context) {
        return (Provider.of<User>(context) == null)
            ? LoginOptions()
            : Dashboard();
      },
      // "/errorPage": (context) => ErrorPage(),
      // "/loadPage": (context) => LoadPage(),
      loginOptionsRoute: (context) => LoginOptions(),
      registerRoute: (context) => Register(),
      dashboardRoute: (context) => Dashboard(),
    };
  }
}
