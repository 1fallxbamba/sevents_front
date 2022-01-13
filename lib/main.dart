// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sevents/pages/error.dart';
import 'package:sevents/pages/master.dart';
import 'package:sevents/pages/no_data.dart';
import 'package:sevents/services/loading.dart';
import 'package:sevents/pages/booking.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Master(),
        '/reservation': (context) => Reservation(),
        '/error': (context) => ErrorPage(),
        '/no-data': (context) => NoDataFound()
      },
      title: 'Sevents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
