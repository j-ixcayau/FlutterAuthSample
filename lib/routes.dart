import 'package:auth/screens/dashboard/Dashbard.dart';
import 'package:auth/screens/login/LoginOptions.dart';
import 'package:auth/screens/others/ErrorParge.dart';
import 'package:auth/screens/others/LoadPage.dart';
import 'package:auth/screens/register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Routes {
  static routes() {
    return {
      "/": (context) {
        return (Provider.of<User>(context) == null)
            ? LoginOptions()
            : Dashboard();
      },
      "/errorPage": (context) => ErrorPage(),
      "/loadPage": (context) => LoadPage(),
      "/loginOptions": (context) => LoginOptions(),
      "/register": (context) => Register(),
      "/dashboard": (context) => Dashboard(),
    };
  }
}
