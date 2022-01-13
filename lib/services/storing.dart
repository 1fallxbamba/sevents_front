import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserPhone(String phone) async {

  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userPhone', phone);

  } catch (err) {
    SharedPreferences.setMockInitialValues({});
  }

}

Future<String?> getUserPhone() async {
  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('userPhone');

  } catch (err) {
    return null;
  }
}