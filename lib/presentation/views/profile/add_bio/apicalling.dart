import 'package:http/http.dart' as http;

class BioApiCalls {
  adressdetailsApi(String url) async {
    final uri = Uri.parse(url);
    final headers = {'accept': '*/*'};

    var response = await http.get(uri, headers: headers);

    return response;
  }
}
