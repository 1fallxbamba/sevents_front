import 'package:flutter/material.dart';
import 'package:sevents/services/tickets.dart';
import 'package:intl/intl.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {

  List<Ticket> tickets = [];

  bool _isLoading = true;

  void getUserTickets() async {

      var _tickets = await fetchUserTickets();

      setState(() {
        _isLoading = false;
        tickets = _tickets;
      });


  }

  @override
  Widget build(BuildContext context) {

    getUserTickets();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 32, left: 32, top: 70, bottom: 32),
            child: Text(
              "Tous vos tickets (" + tickets.length.toString() + ")",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 32, left: 32, bottom: 8),
            child: Column(
              children: buildApplications(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildApplications(){
    List<Widget> list = [];
    for (var tkt in tickets) {
      list.add(buildApplication(tkt));
    }
    return list;
  }

  Widget buildApplication(Ticket ticket){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            ticket.code,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 18),

                          Text(
                            ticket.eventName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 18),

                          Text(
                            "Valable jusqu'au : " +
                                DateFormat.yMMMMd('fr_FR').format(DateTime.parse(ticket.endingDate)).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      ticket.numberOfPlaces + " places",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green[500],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}