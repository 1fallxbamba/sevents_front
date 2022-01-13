import 'package:http/http.dart';
import 'dart:convert';
import 'package:sevents/services/storing.dart';

Future<Response?> postBookingData(Map<String, dynamic> bookingInfo) async {

  try {

    Response resp = await post(
        Uri.parse('http://localhost:3000/book'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(bookingInfo));

    return resp;

  } catch (err) {
    print('BIG ERROR : $err');
    return null;
  }

}