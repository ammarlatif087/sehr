import 'package:flutter/foundation.dart';
import 'package:sehr/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', user.accessToken.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    return UserModel(accessToken: accessToken);
  }

  Future<bool> remove() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('accessToken');
    prefs.clear();
    bool checkValue = prefs.containsKey('accessToken');
    // print(checkValue);
    return checkValue;
  }
}
