import 'package:flutter/material.dart';
import 'package:unitconverter/pages/homepage.dart';
import 'package:unitconverter/pages/imagetotext.dart';
import 'package:unitconverter/pages/imagetotextusecamera.dart';
import 'package:unitconverter/pages/testcamera.dart';
import 'package:unitconverter/pages/testimage.dart';
import 'package:unitconverter/pages/credit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        //routes 移動するページのルート
        '/homepage':(context) => HomePage(),
        '/imagetotext':(context) => const ImageToText(),
        '/imagetotextusecamera':(context) => const ImageToTextTest(),
        '/imagetotexttest':(context) => const ImageToTextTestImage(),
        '/credit': (context) => const Credit(),
      },
    );
  }
}