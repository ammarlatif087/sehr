import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

reportscommissions(String datetime) async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.get('accessToken');
  final uri = Uri.parse(
      'http://3.133.0.29/api/shop/my-sales-report?startDate=$datetime%2000%3A00%3A00.000000&status=accepted');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var response = await http.get(uri, headers: headers);

  return response;
}
