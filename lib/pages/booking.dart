import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'package:sevents/services/booking.dart';
import 'package:sevents/services/storing.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  String selectedNumberOfPLaces = "1";
  late String eventCode;

  late bool isLoading = false;

  void bookAPlace() async {

    Map<String, dynamic> formData = {
      "ticketCode": "ST_" + Uuid().v1(),
      "event": eventCode,
      "owner": {
        "name": _nameController.text,
        "phone": int.parse(_phoneController.text),
        "quantity": int.parse(selectedNumberOfPLaces)
      }
    };

    setState(() {
      isLoading = true;
    });

    Response? resp = await postBookingData(formData);

    setState(() {
      isLoading = false;
    });

    String resultCode = jsonDecode(resp!.body)['resultCode'];

    showPopup(context, resultCode);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventCode = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Renseignez vos informations',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: _buildForm(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            bookAPlace();
          }
        },
        backgroundColor: Colors.red[500],
        child: buttonState(),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Veuillez renseigner votre nom !';
                }
              },
              decoration: InputDecoration(
                labelText: 'Nom Complet',
                icon: const Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 9,
              controller: _phoneController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Veuillez renseigner votre numéro de téléphone !';
                } else if (value.length < 9) {
                  return 'Veuillez renseigner un numéro correct !';
                }
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                icon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de places à réserver',
                  icon: const Icon(Icons.event_seat),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                value: selectedNumberOfPLaces,
                onChanged: (String? val) {
                  setState(() {
                    selectedNumberOfPLaces = val!;
                  });
                },
                hint: const Text('Nombre de places à réserver'),
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('1'),
                    value: '1',
                  ),
                  DropdownMenuItem(
                    child: Text('2'),
                    value: '2',
                  ),
                  DropdownMenuItem(
                    child: Text('3'),
                    value: '3',
                  ),
                  DropdownMenuItem(
                    child: Text('4'),
                    value: '4',
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget buttonState() {
    if(isLoading == true) {
      return const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 1.5,
      );
    } else {
      return const Icon(Icons.done_outline);
    }

  }

  Future<void> showPopup(BuildContext context, String resultCode) async {

    String modalTitle = (resultCode == 'ERR') ? 'Erreur lors de la réservation !' : 'Réservation validée !';
    String modalBody = (resultCode == 'ERR') ? 'Une erreur est survenue lors de la réservation, veuillez réessayer.' : 'Vous recevrez vos tickets sur le numéro de téléphone fourni.';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(modalTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(modalBody),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    await storeUserPhone(_phoneController.text);
                    Navigator.popAndPushNamed(context, '/');
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }

}
