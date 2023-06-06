import 'package:sehr/app/index.dart';

import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/views/business_views/services.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_business_details_view.dart';
import 'package:sehr/presentation/views/profile/add_bio/business_verification/business_verification_processing_view.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CheckBussinessValidate extends StatefulWidget {
  const CheckBussinessValidate({super.key});

  @override
  State<CheckBussinessValidate> createState() => _CheckBussinessValidateState();
}

class _CheckBussinessValidateState extends State<CheckBussinessValidate> {
  Map<String, dynamic>? data;
  bool notapprove = true;

  bussinessvalidatechecker() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data = await getpaymentsdata();
    prefs.remove("sehrCode");
    prefs.remove("isverified");
    prefs.remove("gradeId");

    if (data != null) {
      if (data!["id"].toString() != "null") {
        if (data!["sehrCode"].toString() != "null") {
          String sehrcode = prefs.getString("sehrcode").toString();
          if (sehrcode == "null") {
            prefs.setString("sehrcode", data!["sehrCode"].toString());
          }
          prefs.setString("gradeId", data!["gradeId"].toString());
          prefs.remove("userRole");
          prefs.setString("userRole", "business");
          prefs.remove("isverified");
          prefs.setString("isverified", "true");

          prefs.remove("openbussiness");
          prefs.setString("openbussiness", "true");
          Get.offAll(() => DrawerView(
                pageindex: 0,
              ));
        } else {
          Get.offAll(() => const BusinessVerificationProcessingView());
          // if (prefs.getString("KYC").toString() != "null") {

          // } else {
          //   Get.offAll(() => const BusinessVerificationView());
          // }
        }
      } else {
        Get.offAll(() => const AddBusinessDetailsView());
      }
    } else {
      if (mounted) {
        setState(() {
          notapprove = false;
        });
      }
    }
  }

  @override
  void initState() {
    bussinessvalidatechecker();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: notapprove == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset("assets/images/process.png"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Error ! Please Try again Later",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.offAll(() => DrawerView(
                              pageindex: 0,
                            ));
                      },
                      child: Container(
                        color: ColorManager.primary,
                        height: 40,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
