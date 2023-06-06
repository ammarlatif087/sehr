import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/src/index.dart';

class QrBusinessView extends StatelessWidget {
  const QrBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBackButtonWidget(),
            const Spacer(),
            kTextBentonSansBold(
              'Qr Code',
              fontSize: getProportionateScreenHeight(30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(50),
                  vertical: getProportionateScreenHeight(30)),
              child: Image.asset(
                AppImages.qr,
                height: getProportionateScreenHeight(265),
                width: getProportionateScreenWidth(275),
                color: ColorManager.black,
              ),
            ),
            const Spacer(),
            kTextBentonSansBold(
              'Seher Code',
              fontSize: getProportionateScreenHeight(30),
            ),
            buildVerticleSpace(30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => Container(
                  height: getProportionateScreenHeight(55),
                  width: getProportionateScreenWidth(45),
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primary,
                      width: getProportionateScreenHeight(3),
                    ),
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(5),
                    ),
                  ),
                  child: kTextBentonSansMed(
                    index.toString(),
                    color: ColorManager.primary,
                    fontSize: getProportionateScreenHeight(24),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
