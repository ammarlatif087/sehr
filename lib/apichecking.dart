import 'package:http/http.dart' as http;

class Userdetailscheckig {
  checkmobilenumber(String mobilenumber) async {
    final uri =
        Uri.parse('http://3.133.0.29/api/user/search-by-mobile/$mobilenumber');

    var response = await http.get(uri).timeout(const Duration(seconds: 10));

    return response;
  }

  checkcnic(String cnic) async {
    final uri = Uri.parse('http://3.133.0.29/api/user/search-by-cnic/$cnic');

    var response = await http.get(uri).timeout(const Duration(seconds: 10));

    return response;
  }
}
