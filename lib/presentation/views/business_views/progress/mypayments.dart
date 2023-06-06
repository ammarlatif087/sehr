import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

sendStatusOfPayments() async {
  final prefs = await SharedPreferences.getInstance();
  final sehercode = prefs.getString("sehrcode").toString();

  var token = prefs.get('accessToken');
  final uri = Uri.parse('http://3.133.0.29/api/shop/$sehercode/payment');
  final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
  var response = await http.get(uri, headers: headers);
  if (response.statusCode == 200) {
    return response;
  } else {
    return null;
  }
}
