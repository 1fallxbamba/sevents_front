import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sevents/services/events.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<Eventt> events = [];

  void fetchEvents() async {
    events = await allEvents();
    if (events.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home', arguments: events);
    } else {
      Navigator.pushReplacementNamed(context, '/no-data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SpinKitPouringHourGlass(
            color: Colors.black87,
            size: 70.0,
          ),
        )
    );
  }
}
