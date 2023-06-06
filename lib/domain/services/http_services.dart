// import 'dart:convert';
// import 'dart:io';

// import '../models/login_model.dart';
// import '../models/register_model.dart';
// import '../models/api_error_model.dart';
// import '../models/api_response_model.dart';
// import "package:http/http.dart" as http;

// const String _baseUrl = "http://3.133.0.29/api";

// //! {*****> User Login Service <*****}
// Future<ApiResponseModel> authenticateUser(
//   String username,
//   String password,
// ) async {
//   ApiResponseModel apiResponse = ApiResponseModel();
//   Map<String, dynamic> jsonBody = {
//     'username': username,
//     'password': password,
//   };
//   print('body ==> $jsonBody');

//   try {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/auth/login'),
//       body: jsonBody,
//     );
//     print('status-code ==> ${response.statusCode}');

//     switch (response.statusCode) {
//       case 201:
//         apiResponse.Data = LoginModel.fromJson(json.decode(response.body));
//         break;
//       // case 422:
//       //   apiResponse.ApiError =
//       //       ApiErrorModel.fromJson(json.decode(response.body));
//       //   break;
//       default:
//         apiResponse.ApiError =
//             ApiErrorModel.fromJson(json.decode(response.body));
//         break;
//     }
//   } on SocketException {
//     apiResponse.ApiError = ApiErrorModel(message: "Server error. Please retry");
//   }
//   return apiResponse;
// }

// //! {*****> User Register Service <*****}
// Future<ApiResponseModel> registerUser(
//   String firstName,
//   String lastName,
//   String username,
//   String email,
//   String mobile,
//   String password,
//   String rePassword,
//   String gender,
//   String dob,
//   String role,
//   // File profileImage,
// ) async {
//   ApiResponseModel apiResponse = ApiResponseModel();
//   Map<String, dynamic> jsonBody = {
//     'firstName': firstName,
//     'lastName': lastName,
//     'username': username,
//     'email': email,
//     'mobile': mobile,
//     'password': password,
//     're_password': rePassword,
//     'gender': gender,
//     // 'dob': dob,
//     'dob': '2019-09-26T07:58:30.996+0200',
//     'role': role,
//     // 'profileImage': await http.MultipartFile.fromPath(field, filePath),
//   };
//   print(jsonBody);

//   try {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/user/register'),
//       body: jsonBody,
//     );
//     print(response.statusCode);
//     switch (response.statusCode) {
//       case 201:
//         apiResponse.Data = RegisterModel.fromJson(json.decode(response.body));
//         break;
//       // case 422:
//       //   apiResponse.ApiError =
//       //       ApiErrorModel.fromJson(json.decode(response.body));
//       //   break;
//       default:
//         apiResponse.ApiError =
//             ApiErrorModel.fromJson(json.decode(response.body));
//         break;
//     }
//   } on SocketException {
//     apiResponse.ApiError = ApiErrorModel(message: "Server error. Please retry");
//   }
//   return apiResponse;
// }

// // Future<ApiResponseModel> getUserDetails(String userId) async {
// //   ApiResponseModel apiResponse = ApiResponseModel();
// //   try {
// //     final response = await http.get(Uri.parse('$_baseUrl/user/$userId'));

// //     switch (response.statusCode) {
// //       case 200:
// //         apiResponse.Data = LoginModel.fromJson(json.decode(response.body));
// //         break;
// //       case 401:
// //         print((apiResponse.ApiError as ApiErrorModel).message);
// //         apiResponse.ApiError =
// //             ApiErrorModel.fromJson(json.decode(response.body));
// //         break;
// //       default:
// //         print((apiResponse.ApiError as ApiErrorModel).message);
// //         apiResponse.ApiError =
// //             ApiErrorModel.fromJson(json.decode(response.body));
// //         break;
// //     }
// //   } on SocketException {
// //     apiResponse.ApiError = ApiErrorModel(message: "Server error. Please retry");
// //   }
// //   return apiResponse;
// // }
