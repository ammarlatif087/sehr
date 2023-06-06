import 'package:http/http.dart' as http;

class Rewardapi {
  fetchMyorders() async {
    final uri = Uri.parse('http://3.133.0.29/api/Reward');
    final headers = {"accept": "*/*"};

    var response = await http.get(uri, headers: headers);
    print(response.body);

    return response;
  }

  fetchMembersShip() async {
    final uri = Uri.parse('http://3.133.0.29/api/grade');
    final headers = {"accept": "*/*"};

    var response = await http.get(uri, headers: headers);
    print(response.body);

    return response;
  }
}
