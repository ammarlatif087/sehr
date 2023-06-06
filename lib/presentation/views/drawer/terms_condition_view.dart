import 'package:sehr/app/index.dart';

import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class TermsConditionView extends StatelessWidget {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBackButtonWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(30)),
              child: kTextBentonSansBold("Terms & Conditions",
                  fontSize: getProportionateScreenHeight(31)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: termslist
                          .map((e) => ListTile(
                                title: Text(
                                  e,
                                  style: TextStyle(
                                      height: getProportionateScreenHeight(2)),
                                  textAlign: TextAlign.right,
                                ),
                              ))
                          .toList()),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class TermCardWidget extends StatelessWidget {
  const TermCardWidget({
    super.key,
    required this.title,
    required this.discription,
  });
  final String title;
  final String discription;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(15),
      shadowColor: ColorManager.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(24),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(15),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(15),
            ),
            child: Row(
              children: [
                kTextBentonSansMed(
                  title,
                  fontSize: getProportionateScreenHeight(17),
                ),
              ],
            ),
          ),
          // buildVerticleSpace(32),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(20),
            ),
            child: kTextBentonSansReg(
              discription,
              fontSize: getProportionateScreenHeight(12),
              lineHeight: getProportionateScreenHeight(2),
              // overFlow: TextOverflow.ellipsis,
              // maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}

List<String> termslist = [
  "۔ سحر پروجیکٹ خالصتاً نیک نیتی اور حسن ظن پر بنیاد رکھتے ہوئےہر شعبہ کے ویلفیر کے لیے ترتیب دیا گیاہے۔",
  "۔ کسی بھی شعبہ سے تعلق رکھنے والے افراد سے کسی قسم کی بھی رجسٹریشن فیس / ڈونیش نہیں لی جائے گی۔",
  "- ۔ تمام فوائد سوبر ٹیکنالوجیز انٹرنیشنل اسلام آباد کی صوابدید پر دیے جائیں گے۔",
  "۔ کسی قسم یا کوئی دعوی/claim ۔ قانونی طور پر کوئی حیثیت نہیں  رکھے گی",
  "۔ کمپنی کسی بھی وقت کوئی بھی آفر واپس لے سکتی ہے"
];
