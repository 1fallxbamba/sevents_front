import 'package:shared_preferences/shared_preferences.dart';
import 'package:sevents/services/events.dart';

void saveFavoriteEvents(List<Eventt> favs) async {

  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('favorites', favs.toString());

  } catch (err) {
    SharedPreferences.setMockInitialValues({});
  }

}

void getFavoriteEvents() async {

  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();

  } catch (err) {
    print(err);
    SharedPreferences.setMockInitialValues({});
  }

 }