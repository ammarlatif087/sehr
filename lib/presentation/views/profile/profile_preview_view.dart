import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/user_model.dart';
import 'package:sehr/domain/repository/auth_repository.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/user_view_model.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_button_widget.dart';
import '../../common/custom_chip_widget.dart';
import '../../src/index.dart';
import '../../view_models/blog_view_model.dart';
import 'package:http/http.dart' as http;

class ProfilePreviewView extends StatefulWidget {
  const ProfilePreviewView({super.key});

  @override
  State<ProfilePreviewView> createState() => _ProfilePreviewViewState();
}

class _ProfilePreviewViewState extends State<ProfilePreviewView> {
  bool readonly = true;
  String updated = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          // color: ColorManager.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: SizeConfig.screenHeight * 0.38,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(appUser.avatar.toString()),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TopBackButtonWidget(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: SizeConfig.screenHeight * 0.62,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(getProportionateScreenHeight(30)),
                      topRight:
                          Radius.circular(getProportionateScreenHeight(30)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildVerticleSpace(44),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgotPassView(
                                      enterphonedetails: true,
                                      phone: "",
                                      token: "",
                                    ));
                              },
                              child: CustomChipWidget(
                                width: getProportionateScreenWidth(110),
                                bgColor: ColorManager.ambar.withOpacity(0.10),
                                text: 'Update Password',
                                textColor: ColorManager.ambar,
                              ),
                            ),
                            readonly == true
                                ? AppButtonWidget(
                                    ontap: () {
                                      if (mounted) {
                                        setState(() {
                                          readonly = false;
                                        });
                                      }
                                    },
                                    height: getProportionateScreenHeight(26.5),
                                    width: getProportionateScreenWidth(72),
                                    text: 'Update',
                                    textSize: getProportionateScreenHeight(12),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      if (mounted) {
                                        setState(() {
                                          readonly = true;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.cancel))
                          ],
                        ),
                      ),
                      buildVerticleSpace(20),
                      readonly == true
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(33),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      kTextBentonSansMed(
                                        '${appUser.firstName} ${appUser.lastName}',
                                        fontSize:
                                            getProportionateScreenHeight(27),
                                      ),
                                    ],
                                  ),
                                  buildVerticleSpace(4),
                                  kTextBentonSansReg(
                                    '${appUser.mobile}',
                                    color:
                                        ColorManager.textGrey.withOpacity(0.2),
                                  ),
                                  buildVerticleSpace(18),
                                  TextFieldWidget(
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: '${appUser.cnic}'),
                                    hintText: '${appUser.cnic}',
                                  ),
                                  buildVerticleSpace(18),
                                  TextFieldWidget(
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: DateFormat("yyyy-MM-dd").format(
                                            DateTime.parse(
                                                appUser.dob.toString()))),
                                    hintText: DateFormat("yyyy-MM-dd").format(
                                        DateTime.parse(appUser.dob.toString())),
                                  ),
                                  buildVerticleSpace(18),
                                  TextFieldWidget(
                                    readOnly: true,
                                    hintText: '${appUser.education}',
                                    controller: TextEditingController(
                                        text: '${appUser.education}'),
                                  ),
                                  buildVerticleSpace(18),
                                  TextFieldWidget(
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: '${appUser.mobile}'),
                                    hintText: '${appUser.mobile}',
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(33),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    controller: namecontroller,
                                    hintText: 'first name',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldWidget(
                                    controller: lastnamecontroller,
                                    hintText: 'last name',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // TextFieldWidget(
                                  //   controller: emailcontroller,
                                  //   hintText: 'email',
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      setState(() {
                                        uploading = true;
                                      });
                                      if (namecontroller.text !=
                                              appUser.firstName.toString() &&
                                          namecontroller.text.isNotEmpty) {
                                        updated = "true";
                                        await updateuserinfo("firstName",
                                            namecontroller.text.trim());
                                      }
                                      if (lastnamecontroller.text !=
                                              appUser.lastName.toString() &&
                                          lastnamecontroller.text.isNotEmpty) {
                                        updated = "true";
                                        await updateuserinfo("lastName",
                                            lastnamecontroller.text.trim());
                                      }
                                      if (emailcontroller.text !=
                                              appUser.email.toString() &&
                                          emailcontroller.text.isNotEmpty) {
                                        updated = "true";
                                        await updateuserinfo("email",
                                            emailcontroller.text.trim());
                                      }
                                      if (educationcontroller.text !=
                                              appUser.education.toString() &&
                                          educationcontroller.text.isNotEmpty) {
                                        updated = "true";
                                        await updateuserinfo("education",
                                            educationcontroller.text.trim());
                                      }
                                      if (cniccontroller.text !=
                                              appUser.cnic.toString() &&
                                          cniccontroller.text.isNotEmpty) {
                                        if (cniccontroller.text.length == 13) {
                                          updated = "true";
                                          await updateuserinfoIntNumbers(
                                              "cnic",
                                              int.parse(
                                                  cniccontroller.text.trim()));
                                        } else {
                                          updated = "error";
                                          Utils.flushBarErrorMessage(context,
                                              'Cnic Digits should be 13');
                                        }
                                      }
                                      if (mobilecontroller.text !=
                                              appUser.mobile.toString() &&
                                          mobilecontroller.text.isNotEmpty) {
                                        if (mobilecontroller.text.length ==
                                            11) {
                                          updated = "true";
                                          await updateuserinfoIntNumbers(
                                              "mobile",
                                              int.parse(mobilecontroller.text
                                                  .trim()));
                                        } else {
                                          updated = "error";
                                          Utils.flushBarErrorMessage(context,
                                              'Mobile Digits should be 11');
                                        }
                                      }

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      Map<String, dynamic> body = {
                                        'username': appUser.mobile,
                                        'password': prefs
                                            .getString("password")
                                            .toString(),
                                      };

                                      print(updated);

                                      if (updated == "true") {
                                        print(updated);
                                        // ignore: unused_local_variable
                                        var response = await _authRepo
                                            .loginApi(body)
                                            .then((value) async {
                                          final userPreference =
                                              Provider.of<UserViewModel>(
                                                  context,
                                                  listen: false);
                                          userPreference.saveUser(
                                            UserModel(
                                                accessToken:
                                                    value['accessToken']
                                                        .toString()),
                                          );
                                          Utils.flushBarErrorMessage(
                                              context, 'Updated Successfully');
                                          Get.offAll(() => DrawerView(
                                                pageindex: 0,
                                              ));
                                        }).onError((error, stackTrace) {
                                          if (error
                                              .toString()
                                              .toLowerCase()
                                              .trim()
                                              .contains("Unauthorised request"
                                                  .toLowerCase())) {
                                          } else {}

                                          Utils.flushBarErrorMessage(
                                              context, error.toString());
                                        });
                                      } else if (updated == "error") {
                                        // Utils.flushBarErrorMessage(
                                        //     context, '');
                                      } else {
                                        Utils.flushBarErrorMessage(
                                            context, 'No Changes Were Made');
                                      }

                                      setState(() {
                                        uploading = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: uploading == false
                                                ? const Text(
                                                    "Update",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : const CircularProgressIndicator()),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool uploading = false;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController educationcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  final _authRepo = AuthRepository();
}

updateuserinfo(String title, String value) async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.get('accessToken');
  final uri = Uri.parse('http://3.133.0.29/api/user/update-profile');
  final headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  Map body = {title: value};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  var response = await http
      .put(uri, headers: headers, body: jsonBody, encoding: encoding)
      .timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    print(response.body);
    return response;
  } else {
    print(response.body);
    return null;
  }
}

updateuserinfoIntNumbers(String title, int value) async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.get('accessToken');
  final uri = Uri.parse('http://3.133.0.29/api/user/update-profile');
  final headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  Map body = {title: value.toString()};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  var response = await http
      .put(uri, headers: headers, body: jsonBody, encoding: encoding)
      .timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    print(response.body);
    return response;
  } else {
    print(response.body);
    return null;
  }
}
