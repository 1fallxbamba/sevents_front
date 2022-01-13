import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';

class Eventt {
  late String code;
  late String title;
  late String location;
  late String description;
  late String startingDate;
  late String endingDate;
  late int places;
  late bool selling;
  late int price;
  late String coverPhoto;

  Eventt(this.code, this.title, this.location, this.description, this.startingDate, this.endingDate, this.places,
      this.selling, this.price, this.coverPhoto);
}

Future<List<Eventt>> allEvents() async {
  initializeDateFormatting('fr_FR');

  List<Eventt> events = [];

  try {
    Response resp = await get(Uri.parse('http://localhost:3000/events'));

    List<dynamic> _events = jsonDecode(resp.body);

    for (var ev in _events) {
      events.add(Eventt(
        ev['code'],
        ev['title'],
        ev['location'],
        ev['description'],
        ev['startingdate'],
        ev['endingdate'],
        ev['places'],
        ev['selling'],
        int.parse(ev['price']),
        ev['cover_photo']
      ));
    }
  } catch (err) {
    print(err);
  }

  return events;
}
