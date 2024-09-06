import 'package:attensync/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.amber,
      ),
      home: const Splash(),
    );
  }
}
