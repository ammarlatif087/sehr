import 'dart:io';

import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/drop_down_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';

import '../../../../common/app_button_widget.dart';
import '../../../../common/top_back_button_widget.dart';

import '../../../../src/index.dart';

class BusinessVerificationView extends StatefulWidget {
  const BusinessVerificationView({super.key});

  @override
  State<BusinessVerificationView> createState() =>
      _BusinessVerificationViewState();
}

class _BusinessVerificationViewState extends State<BusinessVerificationView> {
  File? _fileImage;
  String selectedOption = "cnic";
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBackButtonWidget(),
                buildVerticleSpace(20),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(27),
                  ),
                  child: kTextBentonSansMed(
                    'Verify Your Business',
                    fontSize: getProportionateScreenHeight(25),
                  ),
                ),
                buildVerticleSpace(20),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(27)),
                  child: kTextBentonSansMed(
                    'Upload Your Business Related Documents\nto verify Your Business',
                    fontSize: getProportionateScreenHeight(12),
                  ),
                ),
                buildVerticleSpace(38),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Column(
                      children: [
                        DropDownWidget(
                            lableText: 'Document',
                            hintText: 'Select Document Type',
                            selectedOption: selectedOption,
                            dropdownMenuItems: ["cnic", "fbr", "other"]
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: kTextBentonSansReg(value),
                                  ),
                                )
                                .toList(),
                            onChange: (value) => setState(() {
                                  selectedOption = value.toString();
                                })),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(0),
                            ),
                            child: _fileImage == null
                                ? _buildCard(
                                    ontap: () async {
                                      await viewModel.getCnic();
                                      _fileImage = viewModel.cnic;
                                      setState(() {});
                                    },
                                    icon: AppIcons.galleryIcon,
                                    label: 'Upload Document',
                                    child: null,
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(60)),
                                    child: Center(
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(260),
                                        width: getProportionateScreenWidth(250),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Image.file(
                                              height:
                                                  getProportionateScreenHeight(
                                                      260),
                                              width:
                                                  getProportionateScreenWidth(
                                                      250),
                                              File(_fileImage!.path),
                                            ).image,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenHeight(
                                                          18),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          10),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _fileImage = null;
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    AppIcons.closeIcon,
                                                    height:
                                                        getProportionateScreenHeight(
                                                            31),
                                                    width:
                                                        getProportionateScreenHeight(
                                                            31),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                      ],
                    )),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(118),
                  ),
                  child: AppButtonWidget(
                    ontap: () {
                      if (_fileImage != null) {
                        viewModel.registerMultiPartApiKYC(
                            context, selectedOption, _fileImage!);
                      } else {
                        print("File image  null");
                      }
                      // value.getuserRoleFromPrefs();

                      // Get.to(const CountdownTimerDemo());
                    },
                    text: 'Submit',
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ),
                buildVerticleSpace(50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String icon,
    required String label,
    void Function()? ontap,
    Widget? child,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: getProportionateScreenHeight(129),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(getProportionateScreenHeight(5)),
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
        child: child ??
            Column(
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
}
