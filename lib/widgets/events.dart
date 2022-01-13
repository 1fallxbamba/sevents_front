import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sevents/services/events.dart';
import 'package:sevents/models/event_detail.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<Eventt> events = [];

  Future<void> refreshEvents() async {
    List<Eventt> _events = await allEvents();

    setState(() {
      events = _events;
    });
  }


  @override
  Widget build(BuildContext context) {
    events = (events.isEmpty) ? (ModalRoute.of(context)!.settings.arguments as List<Eventt>) : events;

    return RefreshIndicator(
      color: Colors.red,
      strokeWidth: 1.5,
      onRefresh: () async {
        return refreshEvents();
      },
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 32, left: 32, top: 48, bottom: 20),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.only(right: 32, left: 32, top: 8, bottom: 20),
                    child: Center(
                      child: Text(
                        "SEVENTS",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: 5.0),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Text(
                      "À venir",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 190,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: buildUpcomingEvents(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    child: Text(
                      "Tous les événements",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: buildAllEvents(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildUpcomingEvents() {
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 32,
    ));
    for (var ev in events) {
      if(
      DateTime.parse(ev.startingDate).year == DateTime.now().year &&
          DateTime.parse(ev.startingDate).month == DateTime.now().month &&
          (DateTime.parse(ev.startingDate).day - DateTime.now().day <= 7)
      ) {
        list.add(buildUpcomingEvent(ev));
      }
    }
    list.add(const SizedBox(
      width: 16,
    ));

    return list;
  }

  Widget buildUpcomingEvent(Eventt ev) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetail(ev: ev)),
        );
      },
      child: Container(
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ev.coverPhoto),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      DateFormat.MMMMd('fr_FR').format(DateTime.parse(ev.startingDate)).toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ev.title.length > 15 ? '${ev.title.substring(0, 15)}...' : ev.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    (ev.price == 0 ? 'Gratuit' : ev.price.toString() + " F"),
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildAllEvents() {
    List<Widget> list = [];
    for (var ev in events) {
      list.add(buildEvent(ev));
    }
    return list;
  }

  Widget buildEvent(Eventt ev) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetail(ev: ev)),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ev.coverPhoto),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ev.title.length > 9 ? '${ev.title.substring(0, 9)}...' : ev.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd('fr_FR').add_Hm().format(DateTime.parse(ev.startingDate)).toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )),
            Text(
              (ev.price == 0 ? 'Gratuit' : ev.price.toString() + " F"),
              style: TextStyle(
                fontSize: 16,
                color: Colors.green[800]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
