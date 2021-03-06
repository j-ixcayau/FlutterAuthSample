import 'package:auth/common/dialogs/CommonDialogs.dart';
import 'package:auth/common/progressDialog/ProgressDialog.dart';
import 'package:auth/localization/Internationalization.dart';
import 'package:auth/model/user/User.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/routes/RouteNames.dart';
import 'package:auth/utils/Utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonIcon.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class UpdateInfoPage extends StatefulWidget {
  @override
  _UpdateInfoPageState createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  Internationalization _int;
  ProgressDialog _pr;

  UserProvider _userProvider;

  User user;

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  TextEditingController _descriptionController;
  TextEditingController _geoController;

  GeoPoint geoPoint;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    _addressController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
    _geoController = TextEditingController(text: "");

    Future.delayed(Duration.zero, _initPage);
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CommonAppbar(),
      body: BaseScroll(
        children: [
          Text(
            _int.getString(updateDataKey),
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonInput(
                  controller: _nameController,
                  hint: _int.getString(nameKey),
                  prefixIcon: CommonIcon(Icons.person),
                ),
                CommonInput(
                  controller: _phoneController,
                  hint: _int.getString(phoneKey),
                  prefixIcon: CommonIcon(Icons.phone),
                ),
                CommonInput(
                  controller: _addressController,
                  hint: _int.getString(addressKey),
                  prefixIcon: CommonIcon(Icons.directions),
                ),
                CommonInput(
                  controller: _descriptionController,
                  hint: _int.getString(descriptionKey),
                  prefixIcon: CommonIcon(Icons.description),
                ),
                CommonInput(
                  controller: _geoController,
                  hint: _int.getString(locationKey),
                  prefixIcon: CommonIcon(Icons.location_on),
                  onTap: _checkLocationPermissions,
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          CommonButton(
            text: _int.getString(updateKey),
            callback: _updateInfo,
          ),
        ],
      ),
    );
  }

  void _initPage() {
    _pr = ProgressDialog(context);

    user = _userProvider.getUser;

    _nameController.text = user.getName;
    _phoneController.text = user.getPhone;
    _addressController.text = user.getAddress;
    _descriptionController.text = user.getDescription;

    if (user.getHomeLocation != null)
      _geoController.text =
          "${user.getHomeLocation.latitude} / ${user.getHomeLocation.longitude}";
  }

  void _checkLocationPermissions() async {
    _pr.show();

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _checkAppLicationEnable();
    } else {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse)
        _checkAppLicationEnable();
      else {
        _pr.hide();
        commonOkDialog(context, _int.getString(needLocationAccessKey));
      }
    }
  }

  void _checkAppLicationEnable() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled) {
      _requestLocation();
    } else {
      await Geolocator.openLocationSettings();

      isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled)
        _requestLocation();
      else {
        _pr.hide();
        commonOkDialog(context, _int.getString(needDevieLocationKey));
      }
    }
  }

  void _requestLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _geoController.text = "${position.latitude} / ${position.longitude}";

    geoPoint = GeoPoint(position.latitude, position.longitude);
    _pr.hide();
  }

  void _updateInfo() async {
    if (_formKey.currentState.validate()) {
      user.setName = _nameController.text;
      user.setPhone = _phoneController.text;
      user.setAddress = _addressController.text;
      user.setDescription = _descriptionController.text;

      if (geoPoint != null) user.setHomeLocation = geoPoint;

      _pr.show();
      await _userProvider.updateUser(user).then((value) {
        _userProvider.setUser = user;

        _pr.hide();
        commonOkDialog(context, _int.getString(successUpdateKey),
            function: () => popPage());
      }).catchError((error) {
        _pr.hide();
        commonOkDialog(context, _int.getString(processFailedKey));
      });
    }
  }
}
