import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';

import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/src/index.dart';

class BusinessVerificationProcessingView extends StatelessWidget {
  const BusinessVerificationProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset(
              AppImages.process,
              height: getProportionateScreenHeight(120),
            ),
            buildVerticleSpace(50),
            kTextBentonSansMed(
              'Alert Notice',
              color: ColorManager.primary,
              fontSize: getProportionateScreenHeight(30),
            ),
            buildVerticleSpace(12),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: kTextBentonSansMed(
                "Please Wait \n Your request is in under process ",
                fontSize: getProportionateScreenHeight(20),
                textAlign: TextAlign.center,
              ),
            ),
            buildVerticleSpace(12),
            const Spacer(flex: 3),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(125),
              ),
              child: AppButtonWidget(
                ontap: () {
                  Get.toNamed(Routes.drawerRoute);
                },
                text: 'Back',
              ),
            ),
            buildVerticleSpace(80),
          ],
        ),
      ),
    );
  }
}
