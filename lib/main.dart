import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/pages/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Location location = Location();
  await location.getCurrentLocation();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
