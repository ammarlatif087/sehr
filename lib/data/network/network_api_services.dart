import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:sehr/data/app_exceptions.dart';
import 'package:sehr/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiServices {
  Future getGetApiResponse(String url, {dynamic headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future getBusinessDetail(String url, {dynamic headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      return jsonDecode(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print("error occured :$e");
    }

    return responseJson;
  }

  // ignore: override_on_non_overriding_member
  /// delete
  ///

  Future getDeletetApiResponse(String url, {dynamic headers}) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future getPostApiResponse(String url, dynamic data, {dynamic headers}) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future getPostMultiPartResponse(MultipartRequest request) async {
    dynamic responseJson;
    try {
      StreamedResponse res = await request.send();
      // responseJson = returnStreamResponse(res);
      // print("${responseJson}");
      // print("objecttt $res");
      // print(res.stream);
      // print("mashwani khan");
      // print(res.statusCode);

      responseJson = await http.Response.fromStream(res);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (responseJson.statusCode == 201) {
        prefs.remove("error");
      } else {
        prefs.remove("error");
        prefs.setString("error", responseJson.body);
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw UnauthorizedException(response.body.toString());
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      case 422:
        throw UnauthorizedException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server status code${response.statusCode}');
    }
  }

  dynamic returnStreamResponse(StreamedResponse response) async {
    var bodyString = await response.stream.transform(utf8.decoder).join();
    // var bodyJson = json.decode(bodyString);
    switch (response.statusCode) {
      case 201:
        // dynamic responseJson = jsonDecode(response.body);
        dynamic responseJson = jsonDecode(bodyString);
        return responseJson;
      case 400:
        throw UnauthorizedException(bodyString.toString());
      case 404:
        throw UnauthorizedException(bodyString.toString());
      case 422:
        throw UnauthorizedException(bodyString.toString());
      case 500:
        throw BadRequestException(bodyString.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server status code${response.statusCode}');
    }
  }

  // @override
  // dynamic getPostMultiPartResponse(
  //     String url, dynamic headers, String path, dynamic data) async {
  //   dynamic request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(url),
  //   );
  //   request.fields.addAll(data);
  //   request.headers.addAll(headers);
  //   var multipartFile = await http.MultipartFile.fromPath(
  //       'avatar', path); //returns a Future<MultipartFile>
  //   request.files.add(multipartFile);
  //   http.StreamedResponse response = await request.send();
  //   final respStr = await response.stream.bytesToString();
  //   var jsonData = jsonDecode(respStr);
  //   if (response.statusCode == 200) {
  //     // success
  //     // return jsonData;
  //   } else {
  //     // error
  //   }
  // }
}

// class NetworkApiService extends BaseApiServices {
//   @override
//   Future getGetApiResponse(String url) async {
//     dynamic jsonResponse;
//     try {
//       final response = await http.get(Uri.parse(url)).timeout(
//             const Duration(seconds: 10),
//           );
//       jsonResponse = returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return jsonResponse;
//   }

//   @override
//   Future getPostApiResponse(String url, dynamic data) async {
//     dynamic jsonResponse;
//     try {
//       Response response = await post(Uri.parse(url), body: data).timeout(
//         const Duration(seconds: 15),
//       );
//       jsonResponse = returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return jsonResponse;
//   }

//   dynamic returnResponse(http.Response response) {
//     // int statusCodeRange = 500;
//     // if (response.statusCode >= 200 && response.statusCode < 210) {
//     //   dynamic jsonResponse = jsonDecode(response.body);
//     //   return jsonResponse;
//     // } else if (response.statusCode >= 400 && response.statusCode < 500) {
//     //   return UnathorizedException(response.body.toString());
//     // } else if (response.statusCode >= 500) {
//     //   return BadRequestException(response.body.toString());
//     // } else {
//     //   FetchDataException(
//     //     'Error during communicating with server, Status code ${response.statusCode}',
//     //   );
//     // }
//     switch (response.statusCode) {
//       // case 200:
//       //   dynamic jsonResponse = jsonDecode(response.body);
//       //   return jsonResponse;
//       case 201:
//         dynamic jsonResponse = jsonDecode(response.body);
//         return jsonResponse;
//       case 400:
//         return UnathorizedException(response.body.toString());
//       case 422:
//         return UnathorizedException(response.body.toString());
//       case 500:
//         return BadRequestException(response.body.toString());
//       default:
//         throw FetchDataException(
//           'Error accured during communicating with server, with Status code ${response.statusCode}',
//         );
//     }
//   }
// }
