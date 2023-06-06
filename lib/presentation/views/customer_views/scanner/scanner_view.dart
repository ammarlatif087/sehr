import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/customer_views/scanner/orderplacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../src/index.dart';

class ScannerView extends StatefulWidget {
  static String routeName = "/qrscan";

  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  var getxcontroller = Get.put(AppController());
  late Timer _timer;
  Map<String, dynamic>? datatest;

  List<dynamic> filterlist = [];
  bool isloading = false;
  String apierror = "";

  bool qrstopped = false;
  // late Size size;
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");

  TextEditingController codecontroller = TextEditingController();

  QRViewController? _controller;
  bool isFlashOff = true;

  Barcode? result;
  bool isBuild = false;
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();

  Timer? rewardsvalidatyTimer;

  bool? notallow;

  @override
  Widget build(BuildContext context) {
    if (!isBuild && _controller != null) {
      _controller?.pauseCamera();
      _controller?.resumeCamera();
      setState(() {
        isBuild = true;
      });
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: kTextBentonSansBold(
            'Scan QR Code',
            color: ColorManager.white,
            fontSize: getProportionateScreenHeight(26),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return getxcontroller.postloading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    notallow == false
                        ? SizedBox(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth,
                            child: _buildQrView(context),
                          )
                        : Container(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth,
                            color: Colors.black,
                          ),
                    notallow == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  kTextBentonSansReg(
                                    'Youre not allowed to perform \n this activity, please select \n reward category first',
                                    color: ColorManager.white,
                                    fontSize: getProportionateScreenHeight(18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column(
                            children: [
                              buildVerticleSpace(120),
                              kTextBentonSansReg(
                                'Linking Customer to shop\nvia QR  Code or Enter\nSEHR Shop Code',
                                color: ColorManager.white,
                                fontSize: getProportionateScreenHeight(18),
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              !qrstopped
                                  ? notallow == false
                                      ? kTextBentonSansReg(
                                          'OR',
                                          color: ColorManager.white,
                                          fontSize:
                                              getProportionateScreenHeight(20),
                                        )
                                      : Container()
                                  : Container(),
                              buildVerticleSpace(12),
                              notallow == false
                                  ? kTextBentonSansReg(
                                      'SEHR Shop code',
                                      color: ColorManager.white,
                                      fontSize:
                                          getProportionateScreenHeight(18),
                                    )
                                  : Container(),
                              buildVerticleSpace(26),
                              notallow == false
                                  ? PinCodeFields(
                                      length: 6,
                                      // controller: newTextEditingController,
                                      // focusNode: focusNode,
                                      borderWidth: 1,
                                      fieldHeight:
                                          getProportionateScreenHeight(60),
                                      // fieldWidth: getProportionateScreenWidth(40),
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      autoHideKeyboard: false,
                                      controller: codecontroller,
                                      keyboardType: TextInputType.number,
                                      borderColor: ColorManager.lightGrey,
                                      activeBorderColor: ColorManager.primary,
                                      fieldBorderStyle: FieldBorderStyle.square,
                                      textStyle:
                                          TextStyleManager.mediumTextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(30),
                                        color: ColorManager.white,
                                      ),
                                      onComplete: (result) async {},
                                    )
                                  : Container(),
                              buildVerticleSpace(27),
                              notallow == false
                                  ? AppButtonWidget(
                                      ontap: () async {
                                        if (codecontroller.text.length == 6) {
                                          setState(() {
                                            isloading = true;
                                          });

                                          var response =
                                              await checkvalidateBussinessShop(
                                                  codecontroller.text);

                                          if (response == null) {
                                            // ignore: use_build_context_synchronously
                                            Utils.flushBarErrorMessage(
                                                context, apierror);
                                          } else {
                                            datatest = convert
                                                .jsonDecode(response.body);
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderPlacingView(
                                                        datatest: datatest,
                                                      )),
                                            );
                                          }
                                          if (mounted) {
                                            setState(() {
                                              isloading = false;
                                            });
                                          }
                                        }
                                      },
                                      height: getProportionateScreenHeight(46),
                                      width: getProportionateScreenWidth(200),
                                      borderRadius:
                                          getProportionateScreenHeight(23),
                                      textSize:
                                          getProportionateScreenHeight(18),
                                      child: isloading == false
                                          ? const Text(
                                              "Connect",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const CircularProgressIndicator(),
                                    )
                                  : Container(),
                              buildVerticleSpace(50),
                            ],
                          ),
                  ],
                );
        }));
  }

  checkvalidateBussinessShop(String sehercode) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    final uri =
        Uri.parse('http://3.133.0.29/api/business/by-sehr-code/$sehercode');
    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    var response = await http
        .get(uri, headers: headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return response;
    } else {
      apierror = response.body;

      return null;
    }
  }

  @override
  void dispose() {
    rewardsvalidatyTimer!.cancel();
    _qrKey;
    _timer;
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    timer();
    timerlistener();

    // TODO: implement initState
    super.initState();
  }

  void onPermissionSet(
      BuildContext context, QRViewController ctrl, bool permisson) {
    if (!permisson) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Permision')));
    }
  }

  timer() async {
    rewardsvalidatyTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (getxcontroller.rewardsdata == null &&
          getxcontroller.rewardslist.isEmpty) {
        // _timer!.cancel();
        rewardsvalidatyTimer!.cancel();
        setState(() {
          notallow = true;
        });
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Activate any reward first"),
              );
            });
        _controller?.pauseCamera();
      } else {
        setState(() {
          notallow = false;
        });
      }
    });
  }

  timerlistener() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
        if (qrstopped == false) {
          _controller?.pauseCamera();
          if (mounted) {
            setState(() {
              qrstopped = true;
            });
          }
        }
      } else {
        if (qrstopped == true) {
          if (mounted) {
            _controller?.resumeCamera();
            setState(() {
              qrstopped = false;
            });
          }
        }
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = getProportionateScreenHeight(qrstopped ? 00 : 200);
    return QRView(
        key: _qrKey,
        onQRViewCreated: _onQRviewCreated,
        onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
        overlay: QrScannerOverlayShape(
          cutOutSize: scanArea,
          borderWidth: getProportionateScreenHeight(qrstopped ? 1 : 15),
          borderColor: ColorManager.primary,
          borderLength: getProportionateScreenHeight(qrstopped ? 1 : 15),
          borderRadius: 4,
        ));
  }

  void _onQRviewCreated(QRViewController qrController) async {
    setState(() {
      _controller = qrController;
    });
    _controller?.scannedDataStream.listen((event) async {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });
      if (result?.code != null) {
        var response =
            await checkvalidateBussinessShop(result!.code.toString());

        if (response == null) {
          // ignore: use_build_context_synchronously
          Utils.flushBarErrorMessage(context, apierror);
        } else {
          datatest = convert.jsonDecode(response.body);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderPlacingView(
                      datatest: datatest,
                    )),
          ).then((value) {});
        }
        setState(() {
          _controller?.resumeCamera();
        });
      }
    });
  }
}
