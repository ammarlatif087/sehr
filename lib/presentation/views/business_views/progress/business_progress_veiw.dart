import 'dart:convert' as convert;

import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/common/custom_card_widget.dart';
import 'package:sehr/presentation/views/business_views/progress/mypayments.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../src/index.dart';

class CustomCardWidget extends StatelessWidget {
  final String titleText;

  final String valueText;
  final String? description;
  final Widget? child;
  const CustomCardWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    this.description,
    this.child,
  }) : super(key: key);

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
              top: getProportionateScreenHeight(11),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(15),
            ),
            child: Row(
              children: [
                kTextBentonSansMed(
                  titleText,
                  fontSize: getProportionateScreenHeight(17),
                ),
                const Spacer(),
                Container(
                  height: getProportionateScreenHeight(31),
                  width: getProportionateScreenWidth(145),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryLight,
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(24),
                    ),
                  ),
                  child: kTextBentonSansReg(
                    valueText,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
          // buildVerticleSpace(32),
          child ??
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenHeight(20),
                ),
                child: kTextBentonSansReg(
                  description ?? '',
                  fontSize: getProportionateScreenHeight(12),
                  lineHeight: getProportionateScreenHeight(2),
                  textOverFlow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
        ],
      ),
    );
  }
}

class BusinessProgresView extends StatefulWidget {
  const BusinessProgresView({super.key});

  @override
  State<BusinessProgresView> createState() => _BusinessProgresViewState();
}

class SpendData {
  final String day;

  final double amount;
  SpendData(this.day, this.amount);
}

class _BusinessProgresViewState extends State<BusinessProgresView> {
  // ignore: unused_field
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatestcommission;
  final List<dynamic> _listpayment = [];
  List<dynamic> filterlistpayment = [];
  bool nodata = false;

  Future apicall() async {
    datatestcommission = null;
    filterlistpayment.clear();
    _listpayment.clear();
    if (mounted) {
      setState(() {});
    }
    setState(() {});
    // ignore: unused_local_variable
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await sendStatusOfPayments();
    datatestcommission = convert.jsonDecode(responseofdata.body);
    _listpayment.add(
        datatestcommission == null ? [] : datatestcommission!.values.toList());
    _listpayment[0][1].forEach((element) {
      filterlistpayment.add(element);
    });

    return datatestcommission;
  }

  @override
  Widget build(BuildContext context) {
    return nodata == true
        ? Container(
            child: const Center(
              child: Text("No Any payment to submitted"),
            ),
          )
        : filterlistpayment.isEmpty
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(27),
                          ),
                          child: kTextBentonSansMed(
                            'Payment History',
                            fontSize: getProportionateScreenHeight(25),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(25),
                        ),
                        child: SizedBox(
                          height: 1000,
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: filterlistpayment.length,
                              itemBuilder: (context, index) {
                                return CustomListTileWidget(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      filterlistpayment[index]["screenshot"]
                                          .toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context,
                                              e,
                                              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                                              StackTrace) =>
                                          Image.asset(AppImages.menu),
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      kTextBentonSansMed(
                                        DateFormat("yyyy-MM-dd")
                                            .format(DateTime.parse(
                                                filterlistpayment[index]
                                                        ["paidAt"]
                                                    .toString()))
                                            .toString(),
                                        fontSize:
                                            getProportionateScreenHeight(15),
                                      ),
                                      kTextBentonSansReg(
                                        filterlistpayment[index]["description"],
                                        textOverFlow: TextOverflow.ellipsis,
                                        maxLines: 1,

                                        // searchfilterlist[index]["date"],
                                        color: ColorManager.textGrey
                                            .withOpacity(0.8),
                                        letterSpacing:
                                            getProportionateScreenWidth(0.5),
                                      ),
                                      kTextBentonSansMed(
                                        '',
                                        color: filterlistpayment[index]
                                                    ["status"] ==
                                                'paid'
                                            ? ColorManager.primary
                                            : ColorManager.textGrey
                                                .withOpacity(0.3),
                                        fontSize:
                                            getProportionateScreenHeight(19),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    children: [
                                      AppButtonWidget(
                                        bgColor: filterlistpayment[index]
                                                    ["status"] ==
                                                'paid'
                                            ? null
                                            : ColorManager.textGrey
                                                .withOpacity(0.2),
                                        ontap: () {},
                                        height:
                                            getProportionateScreenHeight(29),
                                        width: getProportionateScreenWidth(85),
                                        text: filterlistpayment[index]
                                            ["status"],
                                        textSize:
                                            getProportionateScreenHeight(12),
                                        letterSpacing:
                                            getProportionateScreenWidth(0.5),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: kTextBentonSansReg(
                                          'RS ${filterlistpayment[index]["amount"]}',
                                          color: filterlistpayment[index]
                                                      ["status"] ==
                                                  'accepted'
                                              ? ColorManager.blue
                                              : ColorManager.textGrey
                                                  .withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )),
                  ],
                ),
              );
  }

  fetchorders() async {
    await apicall();
    if (filterlistpayment.isEmpty) {
      nodata = true;
    }
    print(filterlistpayment);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }
}
