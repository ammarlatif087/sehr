import 'package:flutter/foundation.dart';
import 'package:sehr/domain/models/user_model.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/view_models/user_view_model.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';

import '../../app/index.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication() async {
    getUserData().then((value) async {
      if (value.accessToken == null || value.accessToken == '') {
        // print(value.accessToken);
        await Future.delayed(const Duration(seconds: 3));
        Get.toNamed(Routes.onboardingRoute);
      } else {
        // print(value.accessToken);
        await Future.delayed(const Duration(seconds: 3));
        Get.offAll(() => DrawerView(pageindex: 0));
        // Get.to(() => const VerificationCodeView());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
