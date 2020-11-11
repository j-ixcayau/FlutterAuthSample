import 'package:auth/common/dialogs/commonsDialogs.dart';
import 'package:auth/localization/internationalization.dart';
import 'package:auth/model/user/user.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/routes/routeNames.dart';
import 'package:auth/services/Auth/Auth.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/OnCloseApp.dart';
import 'package:auth/widgets/Text/CommonText.dart';
import 'package:firebase_auth/firebase_auth.dart' as fUser;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProgressDialog _pr;
  Internationalization _int;

  // Providers
  UserProvider _userProvider;
  fUser.User _firebaseUser;

  // Vars
  User user = User();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => initPage());
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    _userProvider = Provider.of<UserProvider>(context);
    _firebaseUser = Provider.of<fUser.User>(context);

    return OnCloseApp(
      child: Scaffold(
        appBar: CommonAppbar(
          trailing: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => navigateToPage(configRoute)),
        ),
        body: BaseScroll(
          children: [
            Text(
              _int.getString(homePageKey),
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            (user != null && user.getProfilePicture.isNotEmpty)
                ? Image.network(user.getProfilePicture)
                : Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                  ),
            SizedBox(height: 20),
            CommonText(user.getDescription),
            SizedBox(height: 10),
            CommonText("${_int.getString(nameKey)}: ${user.getName}"),
            CommonText("${_int.getString(emailKey)}: ${user.getEmail}"),
            CommonText("${_int.getString(addressKey)}: ${user.getAddress}"),
            (user.getHomeLocation != null)
                ? CommonText(
                    "${_int.getString(locationKey)}: ${user.getHomeLocation.latitude} / ${user.getHomeLocation.longitude}")
                : CommonText(_int.getString(noLocationSavedKey)),
            (user.getHomeLocation != null)
                ? CommonButton(
                    text: "Show location on map",
                    callback: () => navigateToPage(mapHomeLocationRoute),
                  )
                : SizedBox(),
            SizedBox(height: 40),
            CommonButton(
              text: _int.getString(updateDataKey),
              callback: () => navigateToUpdate(),
            ),
            CommonButton(
              text: _int.getString(logoutKey),
              callback: () => showLogoutDialog(),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void initPage() {
    _pr = ProgressDialog(context);

    if (_userProvider.getUser != null) {
      user = _userProvider.getUser;
      setState(() {});
    } else {
      loadUserInfo();
    }
  }

  void loadUserInfo() async {
    _pr.show();
    user = await _userProvider.requestUser(_firebaseUser.uid);

    _userProvider.setUser = user;

    _pr.hide();
    setState(() {});
  }

  ///

  void navigateToUpdate() async {
    await navigateToPage(updateInfoRoute);

    user = _userProvider.getUser;
    setState(() {});
  }

  ///

  void showLogoutDialog() {
    commonOkDialog(context, _int.getString(logoutKey),
        cancel: false, function: () => signOut());
  }

  void signOut() async {
    _pr.show();
    await Auth().signOut().then((value) {
      _pr.hide();

      navigateToPage(loginOptionsRoute, back: false);
    });
  }
}
