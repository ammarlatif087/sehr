import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';

import '../../src/index.dart';

class ProfileCompleteView extends StatelessWidget {
  const ProfileCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileType =
    //     Provider.of<ProfileViewModel>(context, listen: false).selectedUserRole;
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.4,
                    child: Image.asset(AppImages.pattern),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0),
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.5),
                          Theme.of(context).scaffoldBackgroundColor,
                          // ColorManager.transparent,
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      AppImages.complete,
                      height: getProportionateScreenHeight(160),
                    ),
                    buildVerticleSpace(35),
                    kTextBentonSansMed(
                      'Congrats!',
                      fontSize: getProportionateScreenHeight(30),
                      color: ColorManager.primary,
                    ),
                    buildVerticleSpace(12),
                    Consumer<ProfileViewModel>(
                      builder: (context, viewModel, child) {
                        // value.getProfileTypeFromPrefs();
                        return kTextBentonSansMed(
                          // viewModel.profileType == 'business'
                          // profileType == UserRole.customer
                          //     ?
                          'Your Profile Is Ready To Use',
                          // : 'Your Business Profile Is\nReady To Use',
                          fontSize: getProportionateScreenHeight(23),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(118),
                      ),
                      child: AppButtonWidget(
                        ontap: () {
                          // Get.toNamed(Routes.customerBottomNavRoute);
                          Get.offAll(() => DrawerView(
                                pageindex: 0,
                              ));
                          // print();
                        },
                        text: 'Next',
                      ),
                    ),
                    buildVerticleSpace(50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
