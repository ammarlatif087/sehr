import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';

import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_button_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';
import '../../view_models/customer_view_models/home_view_model.dart';

class UplaodProfilePhotoView extends StatefulWidget {
  const UplaodProfilePhotoView({super.key});

  @override
  State<UplaodProfilePhotoView> createState() => _UplaodProfilePhotoViewState();
}

class _UplaodProfilePhotoViewState extends State<UplaodProfilePhotoView> {
  @override
  Widget build(BuildContext context) {
    // final profileType =
    //     Provider.of<ProfileViewModel>(context, listen: false).selectedUserRole;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            Consumer<ProfileViewModel>(builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  buildVerticleSpace(24),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Upload Your Profile\nPhoto',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(52),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'This data will be displayed in your\n\naccount profile for security',
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(34),
                    ),
                    child: viewModel.image == null
                        ? _buildImageUploadTypes(viewModel)
                        : _buildImagePreview(viewModel),
                  ),
                  // buildVerticleSpace(40),
                  const Spacer(),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(118),
                    ),
                    child: AppButtonWidget(
                      ontap: () async {
                        if (viewModel.image == null) {
                          Utils.flushBarErrorMessage(
                              context, "Upload Picture First");
                        } else {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final isBusiness = prefs.getString('isBusiness');

                          //   Get.toNamed(Routes.setLocationRoute, arguments: {
                          //   'image': viewModel.image,
                          // });
                          // viewModel.image == null
                          //     ?
                          // viewModel.registerApi(context);
                          //     :
                          if (isBusiness == "yes") {
                            viewModel.setLoading(true);
                            if (await Permission
                                .locationWhenInUse.serviceStatus.isEnabled) {
                              late StreamSubscription<Position>
                                  ridePositionStream;
                              ridePositionStream = Geolocator.getPositionStream(
                                      locationSettings:
                                          const LocationSettings())
                                  .listen((Position positionmap) async {
                                position = positionmap;
                                await viewModel.registerBusiness(
                                    context,
                                    positionmap.latitude.toString(),
                                    positionmap.longitude.toString());
                                ridePositionStream.cancel();
                                viewModel.setLoading(false);
                              });
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        children: const [
                                          Text(
                                              "Location Is Disabled, Please Enable the location in order to determine the location of shop")
                                        ],
                                      ),
                                    );
                                  });
                            }
                          } else {
                            viewModel.registerMultiPartApi(context);
                          }
                        }
                      },
                      text: viewModel.image == null ? 'Skip' : 'Next',
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator()
                          : null,
                    ),
                  ),
                  buildVerticleSpace(50),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadTypes(ProfileViewModel viewModel) {
    return Column(
      children: [
        _buildCard(
          icon: AppIcons.galleryIcon,
          label: 'From Gallery',
          ontap: () {
            viewModel.setImageFrom(ImageSource.gallery);
          },
        ),
        buildVerticleSpace(20),
        _buildCard(
          icon: AppIcons.cameraIcon,
          label: 'Take Photo',
          ontap: () {
            viewModel.setImageFrom(ImageSource.camera);
          },
        ),
      ],
    );
  }

  Widget _buildImagePreview(ProfileViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(60)),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(260),
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
}
