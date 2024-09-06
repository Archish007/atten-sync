import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'firebase_options.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_ACCESS_TOKEN']!);
  runApp(const MyApp());
}
