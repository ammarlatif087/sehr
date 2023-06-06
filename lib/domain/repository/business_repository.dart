// ignore_for_file: unused_local_variable

import 'package:sehr/domain/services/location_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

import '../../presentation/view_models/customer_view_models/home_view_model.dart';
import '../models/business_model.dart';
import 'app_urls.dart';

class BusinessRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<BusinessModel> postBusinessData(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.businessEndPoint, data);
      return response = BusinessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  String internet_error = "";

  // Get List Of Business Api Hitting Place

  Future<List<BusinessModel>?> getBusiness(String range) async {
    position = await LocationServices.myLoction();
    final prefs = await SharedPreferences.getInstance();
    List<BusinessModel>? business = [];
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await _apiServices.getBusinessDetail(
          "${AppUrls.getBusinessEndPoint}lat=${position?.latitude.toString()}&lng=${position?.longitude.toString()}&distance=$range",
          headers: headers);

      response.forEach((busines) {
        business.add(BusinessModel.fromJson(busines));
      });

      return business;
    } catch (e) {
      if (e.toString() == "Error During CommunicationNo Internet Connection") {
        internet_error = e.toString();
      }
      rethrow;
    }
  }
}
