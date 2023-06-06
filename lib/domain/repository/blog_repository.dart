import 'package:sehr/domain/models/blog_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import 'app_urls.dart';

class BlogsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<BlogModel> getBlogData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrls.blogEndPoint,
        headers: headers,
      );
      print(response);
      return response = BlogModel.fromJson(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // final BaseApiServices _apiServices = NetworkApiService();

  // Future<BlogModel> getBlogData() async {
  // final prefs = await SharedPreferences.getInstance();
  // var token = prefs.get('accessToken');
  // Map<String, String> headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer $token'
  // };
  //   try {
  //     dynamic response =
  //         await _apiServices.getGetApiResponse(AppUrls.blogEndPoint, headers);
  //     print(response);
  //     return response = BlogModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
