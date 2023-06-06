import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/domain/repository/auth_repository.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:http/http.dart' as http;

import 'package:sehr/presentation/src/assets_manager.dart';
import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/src/size_config.dart';
import 'package:sehr/presentation/src/styles_manager.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/profile/add_bio/business_verification/business_verification_processing_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  PaymentPage({super.key, required this.datetime, required this.amount});
  String datetime;
  String amount;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void dispose() {
    amountcontroller.clear();
    trxidController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<AuthViewModel>(context);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(35),
                      left: getProportionateScreenWidth(25),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(15),
                      ),
                      child: Container(
                        height: getProportionateScreenHeight(45),
                        width: getProportionateScreenHeight(45),
                        decoration: BoxDecoration(
                          color: ColorManager.secondaryLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(15),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ColorManager.icon,
                          size: getProportionateScreenHeight(22),
                        ),
                      ),
                    ),
                  ),
                  buildVerticleSpace(24),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Pay Commission To SEHR',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(34),
                  Consumer<ProfileViewModel>(
                    builder: (context, viewModel, child) => Form(
                      key: viewModel.businessFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            buildVerticleSpace(20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.black.withOpacity(0.1),
                                    blurRadius:
                                        getProportionateScreenHeight(15),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: amountcontroller
                                  ..text = widget.amount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(12),
                                    color: ColorManager.error,
                                  ),
                                  // errorText: null,
                                  filled: true,
                                  fillColor: ColorManager.white,
                                  labelText: 'Amount',
                                  hintStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    color:
                                        ColorManager.textGrey.withOpacity(0.3),
                                  ),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenHeight(15),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                  ),
                                  // errorBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: ColorManager.error,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(
                                  //     getProportionateScreenHeight(15),
                                  //   ),
                                  // ),
                                  // constraints: BoxConstraints(
                                  //   maxHeight: getProportionateScreenHeight(60),
                                  // ),
                                ),
                              ),
                            ),
                            buildVerticleSpace(20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.black.withOpacity(0.1),
                                    blurRadius:
                                        getProportionateScreenHeight(15),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: trxidController,
                                decoration: InputDecoration(
                                  errorStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(12),
                                    color: ColorManager.error,
                                  ),
                                  // errorText: null,
                                  filled: true,
                                  fillColor: ColorManager.white,
                                  labelText: 'TRX.ID',
                                  hintStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    color:
                                        ColorManager.textGrey.withOpacity(0.3),
                                  ),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenHeight(15),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                  ),
                                  // errorBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: ColorManager.error,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(
                                  //     getProportionateScreenHeight(15),
                                  //   ),
                                  // ),
                                  // constraints: BoxConstraints(
                                  //   maxHeight: getProportionateScreenHeight(60),
                                  // ),
                                ),
                              ),
                            ),
                            buildVerticleSpace(20),
                            Padding(
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(00),
                              ),
                              child: kTextBentonSansMed(
                                'Share The ScreenShot                           ',
                                fontSize: getProportionateScreenHeight(25),
                              ),
                            ),
                            viewModel.image == null
                                ? Column(
                                    children: [
                                      buildVerticleSpace(10),
                                      _buildCard(
                                        icon: AppIcons.galleryIcon,
                                        label: 'From Gallery',
                                        ontap: () {
                                          viewModel.setImageFrom(
                                              ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  )
                                : _buildImagePreview(viewModel),
                            buildVerticleSpace(10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(95),
                              ),
                              child: AppButtonWidget(
                                  ontap: () async {
                                    viewModel.setLoading(true);
                                    if (viewModel.image == null) {
                                      Utils.flushBarErrorMessage(context,
                                          "Please Make sure to attach Screenshot of Payment");
                                    } else if (trxidController.text.isEmpty) {
                                      Utils.flushBarErrorMessage(context,
                                          "Please Provide TRX ID of payment");
                                    } else {
                                      await registerpayment(
                                          context,
                                          viewModel.image!,
                                          trxidController.text,
                                          amountcontroller.text,
                                          widget.datetime);
                                      viewModel.setLoading(false);
                                    }

                                    // viewModel.addBussinessDataAndGoNext(context);
                                    // Get.toNamed(Routes.photoSelectionRoute);
                                    // print(value.selectedProfileType);
                                  },
                                  child: !viewModel.isLoading
                                      ? const Center(
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var trxidController = TextEditingController();
  var amountcontroller = TextEditingController();

  Widget _buildCard({
    required String icon,
    required String label,
    void Function()? ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: getProportionateScreenHeight(129),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(15),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.05),
              blurRadius: getProportionateScreenHeight(15),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenHeight(50),
            ),
            buildVerticleSpace(9),
            kTextBentonSansMed(label),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(ProfileViewModel viewModel) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: getProportionateScreenHeight(30), top: 30),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(200),
          width: getProportionateScreenWidth(250),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.file(
                height: getProportionateScreenHeight(260),
                width: getProportionateScreenWidth(250),
                File(viewModel.image!.path),
              ).image,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(18),
                    vertical: getProportionateScreenHeight(10),
                  ),
                  child: InkWell(
                    onTap: () => viewModel.cancelProfileImage(),
                    child: Image.asset(
                      AppIcons.closeIcon,
                      height: getProportionateScreenHeight(31),
                      width: getProportionateScreenHeight(31),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future registerpayment(
    context, File image, String descrption, amount, fromdate) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get('accessToken');
  var sehercode = prefs.get("sehrcode").toString();

  http.MultipartRequest request = http.MultipartRequest(
      'POST', Uri.parse("http://3.133.0.29/api/shop/$sehercode/payment"));
  request.headers.addAll({
    'accept': '*/*',
    'Authorization': 'Bearer $token',
    'Content-Type': 'multipart/form-data',
  });

  request.fields['description'] = descrption;
  request.fields['amount'] = amount;
  request.fields['paidAt'] = DateTime.now().toString();
  request.fields['fromDate'] = "$fromdate 00:00:00.000000+00:00";
  request.fields['toDate'] = DateTime.now().toString();
  var profileImage = await http.MultipartFile.fromPath('screenshot', image.path,
      filename: image.path.split("/").last);
  request.files.add(profileImage);

  var response = await _authRepo.registerMultiPartApi(request);

  if (response.statusCode == 201) {
    Utils.flushBarErrorMessage(
        context, 'Payment Added, wait and check out the status of Payment');
    Get.offAll(() => const BusinessVerificationProcessingView());

    // Get.toNamed(Routes.businessVerificationRoute);
  } else {
    Utils.flushBarErrorMessage(context, response.body.toString());
    if (kDebugMode) {
      print("MultiPart API Error=============> ${response.body}");
    }
  }
}

final _authRepo = AuthRepository();
