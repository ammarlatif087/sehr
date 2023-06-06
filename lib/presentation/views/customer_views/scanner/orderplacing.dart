import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:sehr/presentation/views/customer_views/scanner/orderspending.dart';

import '../../../../app/index.dart';
import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

// ignore: must_be_immutable
class OrderPlacingView extends StatefulWidget {
  OrderPlacingView({
    required this.datatest,
    // required this.businessModel,
    super.key,
  });

  Map<String, dynamic>? datatest;

  @override
  State<OrderPlacingView> createState() => _OrderPlacingViewState();
}

class _OrderPlacingViewState extends State<OrderPlacingView> {
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();
  final OrderApi _orderApi = OrderApi();
  // BusinessModel businessModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        // color: ColorManager.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                widget.datatest!["logo"].toString(),
                height: SizeConfig.screenHeight * 0.5,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight * 0.55,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getProportionateScreenHeight(30)),
                    topRight: Radius.circular(getProportionateScreenHeight(30)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildVerticleSpace(40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomChipWidget(text: 'Popular'),
                          CircleAvatar(
                            radius: getProportionateScreenHeight(17),
                            backgroundColor:
                                ColorManager.error.withOpacity(0.1),
                            child: Icon(
                              Icons.favorite_rounded,
                              color: ColorManager.errorLight,
                              size: getProportionateScreenHeight(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildVerticleSpace(20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(33),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTextBentonSansMed(
                            // '${businessModel.businessName}',
                            widget.datatest!["businessName"].toString(),
                            fontSize: getProportionateScreenHeight(27),
                          ),
                          kTextBentonSansMed(
                              // '${businessModel.businessName}',
                              "${widget.datatest!["ownerName"].toString()} - ${widget.datatest!["email"].toString()}",
                              fontSize: getProportionateScreenHeight(12),
                              color: Colors.grey),

                          buildVerticleSpace(10),
                          SizedBox(
                            height: getProportionateScreenHeight(88),
                            child: kTextBentonSansMed(
                              widget.datatest!["about"].toString() == "null"
                                  ? "No Details"
                                  : widget.datatest!["about"].toString(),
                              height: 1.5,
                              maxLines: 4,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),
                          buildVerticleSpace(20),
                          Container(
                            padding: EdgeInsets.all(
                              getProportionateScreenHeight(12),
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  margin: EdgeInsets.only(
                                    top: getProportionateScreenHeight(8),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenHeight(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      getProportionateScreenHeight(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        kTextBentonSansMed(
                                          '  Enter Total Amount',
                                          fontSize:
                                              getProportionateScreenHeight(16),
                                        ),
                                        buildVerticleSpace(10),
                                        TextFormField(
                                          controller: amountcontroller,
                                          style:
                                              TextStyleManager.regularTextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
                                            letterSpacing:
                                                getProportionateScreenHeight(
                                                    0.5),
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: ColorManager.lightGrey,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      20),
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            // hintText: 'amount',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                buildVerticleSpace(10),
                                AppButtonWidget(
                                  ontap: () async {
                                    if (amountcontroller.text.isNotEmpty) {
                                      var response =
                                          await _orderApi.requestSendOrderApi(
                                              widget.datatest!["sehrCode"]
                                                  .toString(),
                                              int.parse(amountcontroller.text),
                                              "a");
                                      if (response != null) {
                                        // ignore: use_build_context_synchronously

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderProcessingView()),
                                        );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Utils.flushBarErrorMessage(
                                            context, 'Error! Try Again');
                                      }
                                    }
                                  },
                                  bgColor: ColorManager.white,
                                  // text: 'Verify My Order',
                                  // textColor: ColorManager.primary,
                                  child: kTextBentonSansBold(
                                    'Verify My Order',
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     AppButtonWidget(
                          //       ontap: () {},
                          //       height: getProportionateScreenHeight(26),
                          //       width: getProportionateScreenWidth(72),
                          //       borderRadius: getProportionateScreenHeight(18),
                          //       text: 'Contact',
                          //       textSize: getProportionateScreenHeight(12),
                          //       letterSpacing: getProportionateScreenWidth(0.5),
                          //     ),
                          //     const Spacer(),
                          //     AppButtonWidget(
                          //       ontap: () {
                          //         // Get.off(MapDirection(
                          //         //   destLatitude: double.parse(
                          //         //       businessModel.lat.toString()),
                          //         //   destLongitude: double.parse(
                          //         //       businessModel.lon.toString()),
                          //         // ));
                          //       },
                          //       height: getProportionateScreenHeight(26),
                          //       width: getProportionateScreenWidth(115),
                          //       borderRadius: getProportionateScreenHeight(18),
                          //       text: 'Get Direction ↗',
                          //       textSize: getProportionateScreenHeight(12),
                          //       letterSpacing: getProportionateScreenWidth(0.5),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
