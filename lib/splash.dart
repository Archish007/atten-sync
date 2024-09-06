import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attensync/main.dart';
import 'package:attensync/pages/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../helpers/mapbox_handler.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    //Ensure all permissions are collected for locations

    bool? serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServicesDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position locationData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng currentLocation =
        LatLng(locationData.latitude, locationData.longitude);

    // Get the current user address
    String currentAddress =
        (await getParsedReverseGeocoding(currentLocation))['place'];

    //Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', locationData.latitude);
    sharedPreferences.setDouble('longitude', locationData.longitude);
    sharedPreferences.setString('current-address', currentAddress);
  }

  void navigateToNextPage() {
    Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const UserHomePage()),
        (route) => false);
  }

  void _showLocationServicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
            'Please enable location services to continue using this app'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                initializeLocationAndSave();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorizeColors = [
      Colors.black,
      Colors.grey,
      Colors.grey[700]!,
      Colors.white,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 42.0,
      fontFamily: 'LuckiestGuy',
    );
    return Material(
      color: Colors.amber,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.person,
          color: Colors.black,
          size: 120,
        ),
        SizedBox(
          width: 250.0,
          child: Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText('AttenSync',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                    textAlign: TextAlign.center),
              ],
              isRepeatingAnimation: false,
              onFinished: navigateToNextPage,
            ),
          ),
        )
      ]),
    );
  }
}
