import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sevents/services/storing.dart';

class Ticket {
  late String code;
  late String numberOfPlaces;
  late String eventName;
  late String startingDate;
  late String endingDate;

  Ticket(this.code, this.numberOfPlaces, this.eventName, this.startingDate, this.endingDate);

}

Future<List<Ticket>> fetchUserTickets() async {

  initializeDateFormatting('fr_FR');

  List<Ticket> tickets = [];

  String? userPhone = await getUserPhone();

  try {

    Response resp = await get(Uri.parse('http://localhost:3000/tickets/$userPhone'));

    List<dynamic> _tickets = jsonDecode(resp.body);

    for(var tkt in _tickets) {

      tickets.add(
        Ticket(tkt['code'], tkt['numberofplaces'].toString(), tkt['title'], tkt['startingdate'], tkt['endingdate'])
      );

    }

  } catch(err) {
    print(err);
  }

  return tickets;

}