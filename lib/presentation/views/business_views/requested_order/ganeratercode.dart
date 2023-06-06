import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:sehr/app/constants.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/src/size_config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class QRImageGanerate extends StatefulWidget {
  const QRImageGanerate(this.controller, {super.key});
  final String controller;

  @override
  State<QRImageGanerate> createState() => _QRImageGanerateState();
}

class _QRImageGanerateState extends State<QRImageGanerate> {
  TextEditingController sehrcodecontroller = TextEditingController();
  String sehercodes = "";
  sehercode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sehercodes = prefs.getString("sehrcode").toString();
    setState(() {});
  }

  @override
  void initState() {
    sehercode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: sehercodes.isEmpty
            ? const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(children: [
                Container(
                  child: Image.asset("assets/images/Pattern.png"),
                ),
                Column(
                  children: [
                    const Spacer(),
                    const TopBackButtonWidget(),
                    const Spacer(),
                    kTextBentonSansBold(
                      'Qr Code',
                      fontSize: getProportionateScreenHeight(30),
                    ),
                    QrImage(
                      data: sehercodes,
                      size: 200,
                      // You can include embeddedImageStyle Property if you
                      //wanna embed an image from your Asset folder
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: const Size(
                          100,
                          100,
                        ),
                      ),
                    ),
                    const Spacer(),
                    kTextBentonSansBold(
                      'Or',
                      fontSize: getProportionateScreenHeight(30),
                    ),
                    kTextBentonSansBold(
                      'Seher Code',
                      fontSize: getProportionateScreenHeight(30),
                    ),
                    buildVerticleSpace(30),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        sehercodes.length,
                        (index) => Container(
                          height: getProportionateScreenHeight(45),
                          width: getProportionateScreenWidth(35),
                          margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(2),
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
                            sehercodes[index],
                            color: ColorManager.primary,
                            fontSize: getProportionateScreenHeight(24),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ]));
  }
}
