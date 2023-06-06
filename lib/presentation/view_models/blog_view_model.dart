// import 'package:sehr/app/index.dart';
// import 'package:sehr/data/response/api_response.dart';
// import 'package:sehr/domain/models/blog_model.dart';
// import 'package:sehr/presentation/routes/routes.dart';
// import 'package:sehr/presentation/views/drawer/blog_view.dart';

// import '../../domain/repository/blog_repository.dart';
// // import '../../domain/repository/education_repository.dart';

// class DrawerMenuViewModel extends ChangeNotifier {
//   final _blogRepo = BlogsRepository();
//   // final _educationRepo = EducationRepository();

//   ApiResponse<BlogModel> blogsList = ApiResponse.loading();

//   void setBlogData(ApiResponse<BlogModel> response) {
//     blogsList = response;
//     print(blogsList.status);
//     if (blogsList.status == Status.completed) {
//       print(blogsList.data!.posts![0].content);
//     }

//     notifyListeners();
//   }

//   Future<void> blogApi() async {
//     setBlogData(ApiResponse.loading());
//     // print(blogsList.status);

//     _blogRepo.getBlogData().then((value) {
//       setBlogData(ApiResponse.completed(value));
//       // print(blogsList.status);
//       Get.to(() => const BlogView());
//     }).onError((error, stackTrace) {
//       setBlogData(ApiResponse.error(error.toString()));
//       // print(blogsList.status);
//     });
//   }

//   // Future<void> educationApi() async {
//   //   _educationRepo.getEducationApi().then((value) {
//   //     // print(value.toString());
//   //   }).onError((error, stackTrace) {
//   //     print("Error==>$error");
//   //   });
//   // }

//   // ApiResponse<BlogModel> blogsList = ApiResponse.loading();

//   // setBlogsList(ApiResponse<BlogModel> response) {
//   //   blogsList = response;
//   //   // print(blogsList.data?.posts);
//   //   notifyListeners();
//   // }

//   // Future<void> blogApi() async {
//   //   setBlogsList(ApiResponse.loading());

//   //   _blogRepo.getBlogData().then((value) {
//   //     setBlogsList(ApiResponse.completed(value));

//   //     print("api response is ==> ${value.toJson()}");
//   //   }).onError((error, stackTrace) {
//   //     setBlogsList(ApiResponse.error(error.toString()));

//   //     print(error);
//   //   });
//   // }
// }

import 'package:sehr/app/index.dart';
import 'package:sehr/data/response/api_response.dart';
import 'package:sehr/domain/models/blog_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/network_api_services.dart';
import '../../domain/repository/app_urls.dart';
import '../../domain/repository/blog_repository.dart';

User appUser = User();

class DrawerMenuViewModel extends ChangeNotifier {
  final _blogRepo = BlogsRepository();
  NetworkApiService _networkApiService = NetworkApiService();

  ApiResponse<BlogModel> blogsList = ApiResponse.loading();

  setBlogData(ApiResponse<BlogModel> response) {
    blogsList = response;
    notifyListeners();
  }

  DrawerMenuViewModel() {
    callingBlog();
    getAppUser();
    init();
  }
  callingBlog() async {
    await blogApi();
  }

  init() async {}

  Future<void> blogApi() async {
    setBlogData(ApiResponse.loading());

    await _blogRepo.getBlogData().then((value) {
      setBlogData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setBlogData(ApiResponse.error(error.toString()));
    });
  }

  /// Get Current AppUser

  Future getAppUser() async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await _networkApiService
          .getGetApiResponse(AppUrls.currentUser, headers: headers);

      appUser = User.fromJson(response);

      print("User Name: ${appUser.firstName}");
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
    notifyListeners();
  }

  // ApiResponse<BlogModel> blogsList = ApiResponse.loading();

  // setBlogsList(ApiResponse<BlogModel> response) {
  //   blogsList = response;
  //   // print(blogsList.data?.posts);
  //   notifyListeners();
  // }

  // Future<void> blogApi() async {
  //   setBlogsList(ApiResponse.loading());

  //   _blogRepo.getBlogData().then((value) {
  //     setBlogsList(ApiResponse.completed(value));

  //     print("api response is ==> ${value.toJson()}");
  //   }).onError((error, stackTrace) {
  //     setBlogsList(ApiResponse.error(error.toString()));

  //     print(error);
  //   });
  // }
}
