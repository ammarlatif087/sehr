import 'package:shared_preferences/shared_preferences.dart';

import 'app/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String userrole = prefs.getString("userRole").toString();
  if (userrole == "null") {
    prefs.setString("userRole", "user");
  }
  runApp(MyApp());
}
