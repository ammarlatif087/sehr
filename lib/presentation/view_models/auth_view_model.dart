import 'package:flutter/foundation.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/varification_code_view.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/network_api_services.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/services/location_services.dart';
import '../routes/routes.dart';
import 'customer_view_models/home_view_model.dart';
import 'user_view_model.dart';
import 'package:geocoding/geocoding.dart' as geo;

class AuthViewModel extends ChangeNotifier {
  // ignore: unused_field
  final NetworkApiService _networkApiService = NetworkApiService();
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  final loginUserNameFocusNode = FocusNode();
  final loginPasswordFocusNode = FocusNode();
  final loginUserNameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final signupUserNameFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();
  final signUpPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final signupUserNameController = TextEditingController();
  final mobileNoTextController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loginPassObscureText = true;
  bool signupPassObscureText = true;
  bool confirmPassObscureText = true;
  bool keepAuthData = false;

  AuthViewModel();

  void showLoginPass() {
    loginPassObscureText = !loginPassObscureText;
    notifyListeners();
  }

  init() async {
    position = await LocationServices.myLoction();
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );

      address =
          ("${placemarks.last.locality.toString()} ${placemarks.last.administrativeArea.toString().trim()} ${placemarks.last.name.toString()}");
      print("Address: $address");
    } catch (e) {
      print("give me error ${e.toString()}");
    }

    notifyListeners();
  }

  void showSignupPass() {
    signupPassObscureText = !signupPassObscureText;
    notifyListeners();
  }

  void showSignupConfirmPass() {
    confirmPassObscureText = !confirmPassObscureText;
    notifyListeners();
  }

  // void keepAuth() {
  //   keepAuthData = keepAuthData.toggle();
  //   notifyListeners();
  // }

//==> User Login Method
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // final ApiResponseModel _apiResponse = ApiResponseModel();
  // Future<void> login(BuildContext context) async {
  //   if (userNameController.text.isEmpty && passwordController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
  //   } else if (userNameController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Email is empty');
  //   } else if (passwordController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Password is empty');
  //   } else if (passwordController.text.length < 8) {
  //     Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
  //   } else {
  //     if (loginFormKey.currentState!.validate()) {
  //       loginFormKey.currentState!.save();
  //       _apiResponse = await authenticateUser(
  //         userNameController.text.toString(),
  //         passwordController.text.toString(),
  //       ).then((value) {
  //         print(value);
  //         return value;
  //       });
  //       if (_apiResponse.ApiError == null) {
  //         // ignore: use_build_context_synchronously
  //         Utils.toastMessage(context, 'Login Successfully');
  //       } else {
  //         // ignore: use_build_context_synchronously
  //         Utils.flushBarErrorMessage(
  //             context, (_apiResponse.ApiError as ApiErrorModel).message!);
  //         print((_apiResponse.ApiError as ApiErrorModel).message);
  //       }
  //     }
  //   }
  // }

  final _authRepo = AuthRepository();

//! ==> User Login Service
  Future<void> loginApi(BuildContext context) async {
    if (loginUserNameController.text.isEmpty &&
        loginPasswordController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
    } else if (loginUserNameController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Email is empty');
    } else if (loginPasswordController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Password is empty');
    } else if (loginPasswordController.text.length < 8) {
      Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setString("username", loginUserNameController.text.trim());
      prefs.setString("password", loginPasswordController.text.trim());
      Map<String, dynamic> body = {
        'username': loginUserNameController.text.trim(),
        'password': loginPasswordController.text.trim(),
      };
      setLoading(true);

      var response = await _authRepo.loginApi(body).then((value) async {
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUser(
          UserModel(accessToken: value['accessToken'].toString()),
        );
        Utils.flushBarErrorMessage(context, 'Login Successfully');
        await init();

        setLoading(false);

        await Get.offAll(DrawerView(
          pageindex: 0,
        ));
      }).onError((error, stackTrace) async {
        if (error
            .toString()
            .toLowerCase()
            .trim()
            .contains("Not verified".toLowerCase())) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("mobileNo");
          prefs.setString("mobileNo", loginUserNameController.text);
          Get.to(const VerificationCodeView());
        } else {
          print("error not found");
        }
        setLoading(false);

        Utils.flushBarErrorMessage(context, error.toString());
      });
      print("object mashwnai");
      print(response);
    }
  }

  // Future<void> loginApi(BuildContext context) async {
  //   setLoading(true);
  // if (userNameController.text.isEmpty && passwordController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
  // } else if (userNameController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Email is empty');
  // } else if (passwordController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Password is empty');
  // } else if (passwordController.text.length < 8) {
  //   Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
  // } else {
  // Map<String, dynamic> loginData = {
  //   'username': userNameController.text.trim(),
  //   'password': passwordController.text.trim(),
  // };
  //   _authRepo.loginApi(loginData).then((value) {
  //     setLoading(false);
  //     Utils.flushBarErrorMessage(context, 'Login Succesfully');
  //     if (kDebugMode) {
  //       print(value);
  //     }
  //   }).onError(
  //     (error, stackTrace) {
  //       setLoading(false);
  //       Utils.flushBarErrorMessage(
  //         context,
  //         error.toString(),
  //       );
  //       print(error.toString());
  //     },
  //   );
  //   // }
  // }

//! ==> Set User Sign-Up data to prefs
  Future<void> setSignUpDataToPrefs(BuildContext context) async {
    // if (userNameController.text.isEmpty &&
    //     emailController.text.isEmpty &&
    //     passwordController.text.isEmpty) {
    //   Utils.flushBarErrorMessage(
    //       context, 'Plaese fill all the required fields');
    // } else if (passwordController.text.length < 8) {
    //   Utils.flushBarErrorMessage(
    //       context, 'Password should be 8 characters minimum');
    if (!signUpFormKey.currentState!.validate()) {
      return;
    } else {
      _saveSignupDataAndGoNext();
    }
  }

  void _saveSignupDataAndGoNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', signupUserNameController.text.trim());
    prefs.setString('mobileNo', mobileNoTextController.text.trim());
    prefs.setString('password', signupPasswordController.text.trim());
    prefs.setString('re_password', confirmPasswordController.text.trim());
    // prefs.setBool('keepAuthData', keepAuthData);
    Get.toNamed(Routes.addCustomerBioRoute);
  }

  /// Get Current AppUser
}
