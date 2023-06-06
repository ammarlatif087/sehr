import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  requestSendOrderApi(sehrcode, int amount, commentOfOrder) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    final uri = Uri.parse('http://3.133.0.29/api/shop/orders/$sehrcode');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map body = {"amount": amount, "comments": commentOfOrder};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http
        .post(uri, headers: headers, body: jsonBody, encoding: encoding)
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 201) {
      return response;
    } else {
      return null;
    }
  }

  fetchMyorders() async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    final uri = Uri.parse('http://3.133.0.29/api/business/my-business');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response =
        await http.get(uri, headers: headers).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 404) {
      return response;
    } else {
      return null;
    }
  }

  fetchorderrequest(String sehrcode) async {
    final prefs = await SharedPreferences.getInstance();

    var tokenofmy = prefs.get('accessToken');

    final uri =
        Uri.parse('http://3.133.0.29/api/shop/orders/$sehrcode?limit=1000');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenofmy'
    };

    var response = await http.get(uri, headers: headers);

    return response;
  }

  //! fetch my orders (customer)
  fetchmyorderscustomers() async {
    final prefs = await SharedPreferences.getInstance();

    var tokenofmy = prefs.get('accessToken');

    final uri =
        Uri.parse('http://3.133.0.29/api/shop/my-orders?status=accepted');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenofmy'
    };

    var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return response;
    } else {
      return;
    }
  }

  getadmintoken() async {
    Map<String, dynamic>? datatest;
    final uri = Uri.parse('http://3.133.0.29/api/auth/login');
    final headers = {
      'Content-Type': 'application/json',
    };
    Map body = {"username": "admin", "password": "admin"};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);

    datatest = convert.jsonDecode(response.body);

    return datatest;
  }

  sendStatusOfOrders(String orderID, status) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    final uri = Uri.parse('http://3.133.0.29/api/shop/orders/$orderID/status');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map body = {"status": status, "comments": ""};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http.patch(uri,
        headers: headers, body: jsonBody, encoding: encoding);
    if (response.statusCode == 200) {
      return response;
    } else {
      return;
    }
  }
}
