import 'package:sehr/data/network/base_api_services.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/education_model.dart';
import 'package:sehr/domain/repository/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<EducationModel> getEducationApi() async {
    // List<EducationModel>? educationList = [];

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrls.educationEndPoint, headers: headers);
      // response.forEach((education) {
      //   educationList.add(EducationModel.fromJson(education));
      // });
      // print('Education API response' + response);
      return response;
    } catch (e) {
      // print('Education API error===>$e');
      rethrow;
    }
  }
}
