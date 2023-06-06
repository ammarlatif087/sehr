import 'package:get/get.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/business_model.dart';
import 'package:sehr/domain/models/userFavouriteBusinessModel.dart';
import 'package:sehr/domain/repository/app_urls.dart';
import 'package:sehr/domain/repository/business_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AppController extends GetxController {
  var business = <BusinessModel>[].obs;
  var filterbussiness = <BusinessModel>[].obs;
  var favBusinesses = <BusinessModel>[].obs;
  final _liste = <dynamic>[].obs;
  var listOfUserFavouriteBusiness = <UserFavouriteBusiness>[].obs;

  final NetworkApiService _networkApiService = NetworkApiService();

  var postloading = true.obs;
  var postloading3 = true.obs;
  var postloading2 = true.obs;
  BusinessRepository model = BusinessRepository();

  @override
  void onInit() {
    // userFavouriteBusiness();
    getshops("10000");
    fetchorders();
    fetchrewards();

    super.onInit();
  }

  String internererror = "";

  // userFavouriteBusiness() async {
  //   internererror = "";
  //   final prefs = await SharedPreferences.getInstance();

  //   var token = prefs.get('accessToken');

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   try {
  //     final response = await _networkApiService
  //         .getGetApiResponse(
  //       AppUrls.addToFavourite,
  //       headers: headers,
  //     )
  //         .catchError((e) {
  //       internererror = e.toString();
  //       return e;
  //     });
  //     if (internererror.isEmpty) {
  //       return response;
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  getshops(String range) async {
    try {
      postloading.value = true;
      var result = await model.getBusiness(range).catchError((e) {
        internererror = e.toString();
        return e;
      });
      if (result != null) {
        business.assignAll(result);
      } else {}
      internererror = "";
      // ignore: body_might_complete_normally_catch_error
    } finally {
      postloading.value = false;
    }

    update();
  }

  //
  getfavshops() async {
    try {
      for (var business in business) {
        for (var favBusiness in listOfUserFavouriteBusiness) {
          if (favBusiness.businessId == business.id) {
            business.isFavourite = true;
          }
        }
      }
      for (var element in business) {
        if (element.isFavourite == true) {
          favBusinesses.assign(element);
        }
      }
    } finally {
      postloading2.value = false;
    }

    update();
  }

  ///   add Business to Favourite

  Future addToFavourite(bussinessid) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {"businessId": bussinessid};

    try {
      final response = await _networkApiService
          .getPostApiResponse(AppUrls.addToFavourite, body, headers: headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///   Delete Business From Favourite

  Future deleteFromFavourite(bussinessid) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await _networkApiService.getDeletetApiResponse(
        "${AppUrls.addToFavourite}/$bussinessid",
        headers: headers,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  fetchFav() async {
    final prefs = await SharedPreferences.getInstance();

    var tokenofmy = prefs.get('accessToken').toString();

    final uri = Uri.parse('http://3.133.0.29/api/user/favorites');
    final headers = {'accept': '*/*', 'Authorization': 'Bearer $tokenofmy'};

    var response = await http.get(uri, headers: headers);

    return response;
  }

  Future apicall() async {
    var responseofdata = await fetchFav();
    _liste.assignAll(convert.jsonDecode(responseofdata.body));

    filterlistFavo.assignAll(_liste);
  }

  var filterlistFavo = <dynamic>[].obs;
  var favlist = <BusinessModel>[].obs;

  fetchorders() async {
    try {
      postloading.value = true;
      await apicall();
    } finally {
      postloading.value = false;
    }

    update();
  }

  //usersrewards
  var rewardslist = <dynamic>[].obs;
  Map<String, dynamic>? rewardsdata;
  fetchrewardsApi() async {
    final prefs = await SharedPreferences.getInstance();

    var tokenofmy = prefs.get('accessToken').toString();

    final uri = Uri.parse('http://3.133.0.29/api/user/my-rewards');
    final headers = {'accept': '*/*', 'Authorization': 'Bearer $tokenofmy'};

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400) {
      return null;
    } else {
      return response.body;
    }
  }

  Future rewardscall() async {
    try {
      postloading3.value = false;
      var responseofdata = await fetchrewardsApi();
      if (responseofdata == null) {
        rewardslist.clear();
      } else {
        rewardsdata = convert.jsonDecode(responseofdata.body) as dynamic;
        rewardslist
            .assign(rewardsdata == null ? [] : rewardsdata!.values.toList());
      }
    } catch (e) {
      postloading3.value = true;
    } finally {
      postloading3.value = true;
    }
    update();
  }

  fetchrewards() async {
    try {
      postloading.value = true;
      await rewardscall();
    } finally {
      postloading.value = false;
    }

    update();
  }
}
