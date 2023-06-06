import 'dart:convert';

import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_button_widget.dart';
import '../../common/text_field_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ForgotPassView extends StatefulWidget {
  ForgotPassView(
      {super.key,
      required this.enterphonedetails,
      required this.phone,
      required this.token});
  bool enterphonedetails;
  String phone;
  String token;

  @override
  State<ForgotPassView> createState() => _ForgotPassViewState();
}

class _ForgotPassViewState extends State<ForgotPassView> {
  TextEditingController newpasscontroller = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  bool otpsended = false;
  bool shownepassword = false;

  bool isloading = false;

  TextEditingController confirmnewpasscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const TopBackButtonWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(34),
                    ),
                    child: Form(
                        child: widget.enterphonedetails == true
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildVerticleSpace(80),
                                  kTextBentonSansBold(
                                    'Update Password',
                                    fontSize: getProportionateScreenHeight(20),
                                  ),
                                  buildVerticleSpace(40),
                                  TextFieldWidget(
                                    controller: phonecontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: 'Enter phone',
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      size: getProportionateScreenHeight(18),
                                      color: ColorManager.primaryLight,
                                    ),
                                  ),
                                  buildVerticleSpace(20),
                                  buildVerticleSpace(50),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(90),
                                    ),
                                    child: AppButtonWidget(
                                      child: viewModel.isLoading != true
                                          ? const Text(
                                              "Next",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const CircularProgressIndicator(),
                                      ontap: () async {
                                        viewModel.setLoading(true);
                                        if (phonecontroller.text.length != 11) {
                                          Utils.flushBarErrorMessage(context,
                                              'Phone Should Contains only 11 digits');
                                        } else {
                                          await sendOtp(phonecontroller.text);
                                        }
                                        viewModel.setLoading(false);
                                      },
                                    ),
                                  ),
                                  buildVerticleSpace(50),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildVerticleSpace(80),
                                  kTextBentonSansBold(
                                    'Forgot Password',
                                    fontSize: getProportionateScreenHeight(20),
                                  ),
                                  TextFieldWidget(
                                    controller: newpasscontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: 'New Password',
                                    prefixIcon: Icon(
                                      Icons.lock_rounded,
                                      size: getProportionateScreenHeight(18),
                                      color: ColorManager.primaryLight,
                                    ),
                                    sufixIcon: IconButton(
                                      splashRadius: 1,
                                      onPressed: () => {},
                                      icon: Icon(
                                        viewModel.loginPassObscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: getProportionateScreenHeight(20),
                                        color: ColorManager.textGrey
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'New Password is required';
                                      } else if (value.length < 8) {
                                        return 'Password should be 8 charators minimum';
                                      }
                                      return null;
                                    },
                                  ),
                                  buildVerticleSpace(20),
                                  TextFieldWidget(
                                    controller: confirmnewpasscontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: 'Re-Enter New Password',
                                    prefixIcon: Icon(
                                      Icons.lock_rounded,
                                      size: getProportionateScreenHeight(18),
                                      color: ColorManager.primaryLight,
                                    ),
                                    sufixIcon: IconButton(
                                      splashRadius: 1,
                                      onPressed: () => {},
                                      icon: Icon(
                                        viewModel.loginPassObscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: getProportionateScreenHeight(20),
                                        color: ColorManager.textGrey
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm New Password is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  buildVerticleSpace(50),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(90),
                                    ),
                                    child: AppButtonWidget(
                                      child: isloading != true
                                          ? const Text(
                                              "Next",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const CircularProgressIndicator(),
                                      ontap: () async {
                                        if (newpasscontroller.text.isEmpty &&
                                            confirmnewpasscontroller
                                                .text.isEmpty &&
                                            phonecontroller.text.isEmpty) {
                                          Utils.flushBarErrorMessage(
                                              context, 'fields are empty');
                                        } else {
                                          if (newpasscontroller.text.length <
                                              8) {
                                            Utils.flushBarErrorMessage(context,
                                                'Password should be 8 charators minimum');
                                          } else {
                                            if (newpasscontroller.text !=
                                                confirmnewpasscontroller.text) {
                                              Utils.flushBarErrorMessage(
                                                  context,
                                                  'Confirm Password should be same');
                                            } else {
                                              setState(() {
                                                isloading = true;
                                              });

                                              await updateUserPassword(
                                                  confirmnewpasscontroller.text,
                                                  widget.phone,
                                                  widget.token);

                                              setState(() {
                                                isloading = false;
                                              });
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  buildVerticleSpace(50),
                                ],
                              )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateUserPassword(String newPassword, String email, String tokens) async {
    var token = tokens;
    // prefs.get('accessToken');

    final uri = Uri.parse('http://3.133.0.29/api/user/update-password');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map body = {"password": newPassword, "email": email};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http
        .post(uri, headers: headers, body: jsonBody, encoding: encoding)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      Utils.flushBarErrorMessage(context, "Password updated successfully");
      Get.offAndToNamed(Routes.loginRoute);
    } else {
      Utils.flushBarErrorMessage(context, response.body);

      return null;
    }
  }

  String apierror = "";
  sendOtp(phonenumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("otpsend", "true");
    prefs.setString("mobileNo", phonecontroller.text);
    Get.toNamed(Routes.verificationCodeRoute);
    // final uri = Uri.parse('http://3.133.0.29/api/user/send-otp/$phonenumber');
    // final headers = {
    //   'accept': '*/*',
    // };
    // var response = await http
    //     .get(uri, headers: headers)
    //     .timeout(const Duration(seconds: 10));

    // if (response.statusCode == 200) {

    // } else {
    //   Utils.flushBarErrorMessage(context, "Wrong Phone crediential");
    // }
  }
}
