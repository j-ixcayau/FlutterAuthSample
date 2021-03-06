import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:auth/localization/Internationalization.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/utils/LocaleCodes.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UserMapLocationPage extends StatefulWidget {
  @override
  _UserMapLocationPageState createState() => _UserMapLocationPageState();
}

class _UserMapLocationPageState extends State<UserMapLocationPage> {
  Internationalization _int;

  UserProvider _userProvider;

  CameraPosition _initialPosition = CameraPosition(target: LatLng(0, 0));
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CommonAppbar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            markers: _markers,
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints(maxWidth: 225),
              child: CommonButton(
                text: _int.getString(homeKey),
                callback: _initialLocation,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    _initialLocation();
  }

  void _initialLocation() async {
    final GeoPoint geoPoint = _userProvider.getUser.getHomeLocation;

    final GoogleMapController controller = await _controller.future;
    final LatLng lang = LatLng(geoPoint.latitude, geoPoint.longitude);

    final Uint8List markerIcon =
        await _getBytesFromAsset('assets/icon/icon_location.png', 100);
    _markers.add(
      Marker(
          markerId: MarkerId('Current'),
          position: lang,
          icon: BitmapDescriptor.fromBytes(markerIcon)),
    );

    controller.animateCamera(CameraUpdate.newLatLngZoom(lang, 14));
    setState(() {});
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
