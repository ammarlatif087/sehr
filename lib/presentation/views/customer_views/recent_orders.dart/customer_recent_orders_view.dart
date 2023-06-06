import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';

import 'package:sehr/presentation/common/custom_chip_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';

import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'dart:convert' as convert;

import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';

class CustomerRecentOrdersView extends StatefulWidget {
  const CustomerRecentOrdersView({super.key});

  @override
  State<CustomerRecentOrdersView> createState() =>
      _CustomerRecentOrdersViewState();
}

class _CustomerRecentOrdersViewState extends State<CustomerRecentOrdersView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  List<dynamic> filterlisttype = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      filterlisttype = filterlist;
    }
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;

  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }

    var responseofdata = await _orderApi.fetchmyorderscustomers();
    if (responseofdata != null) {
      datatest = convert.jsonDecode(responseofdata.body);
      _list.add(datatest == null ? [] : datatest!.values.toList());

      _list[0][0].forEach((element) {
        filterlist.add(element);
      });
      return datatest;
    } else {
      Utils.flushBarErrorMessage(context, 'time out internet error');
    }
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  List sekectedfilter = [];

  @override
  Widget build(BuildContext context) {
    filterlisttype.sort((a, b) => DateTime.parse(b["date"].toString())
        .compareTo(DateTime.parse(a["date"].toString())));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(17),
          ),
          child: Column(
            children: [
              buildVerticleSpace(20),
              kTextBentonSansReg(
                "Recent Orders",
                fontSize: getProportionateScreenHeight(27),
              ),
              buildVerticleSpace(20),
              // buildVerticleSpace(37),
              // Row(
              //   children: [
              //     kTextBentonSansReg(
              //       "${appUser.firstName.toString()}${appUser.lastName.toString()}",
              //       fontSize: getProportionateScreenHeight(27),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     kTextBentonSansReg(
              //       appUser.mobile.toString(),
              //       color: ColorManager.textGrey.withOpacity(0.3),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: sekectedfilter
                    .map(
                      (filter) => Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(10),
                        ),
                        child: Chip(
                          backgroundColor:
                              ColorManager.secondaryLight.withOpacity(0.15),
                          deleteIconColor: ColorManager.icon,
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20),
                          ),
                          labelPadding: EdgeInsets.zero,
                          label: kTextBentonSansMed(
                            filter,
                            fontSize: getProportionateScreenHeight(12),
                            color: ColorManager.icon,
                          ),
                          deleteIcon: Icon(
                            Icons.close,
                            size: getProportionateScreenHeight(16),
                          ),
                          onDeleted: () {
                            sekectedfilter.clear();
                            filterlisttype = filterlist;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              PopupMenuButton(
                offset: Offset(
                  getProportionateScreenWidth(0),
                  getProportionateScreenHeight(50),
                ),
                padding: EdgeInsets.zero,
                icon: Container(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenHeight(50),
                  padding: EdgeInsets.all(
                    getProportionateScreenHeight(13),
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.secondaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(15),
                    ),
                  ),
                  child: Image.asset(
                    AppIcons.filterIcon,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                itemBuilder: (context) {
                  return ["accepted", "rejected", "spam"]
                      .map(
                        (e) => PopupMenuItem(
                            child: Text(e),
                            onTap: () {
                              sekectedfilter.clear();
                              sekectedfilter.add(e);
                              filterlisttype = filterlist
                                  .where((element) =>
                                      element["status"]
                                          .toString()
                                          .toLowerCase()
                                          .trim() ==
                                      sekectedfilter.first
                                          .toString()
                                          .toLowerCase()
                                          .trim())
                                  .toList();
                              if (mounted) {
                                setState(() {});
                              }
                            }),
                      )
                      .toList();
                },
              ),
            ],
          ),
        ),
        nodata == true
            ? Container(
                child: const Center(
                  child: Text(
                    "No Recent Completed Orders",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : filterlist.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : filterlisttype.isEmpty
                    ? Container(
                        child: const Center(
                          child: Text(
                            "No Order Type",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(24),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: filterlisttype.length,
                            separatorBuilder: (context, index) =>
                                buildVerticleSpace(20),
                            padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(50),
                            ),
                            physics: const NeverScrollableScrollPhysics(),

                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                _buildOrderDetailsRecentCustomer(
                                    context,
                                    filterlisttype[index]["status"],
                                    filterlisttype[index]);
                              },
                              child: CustomListTileWidget(
                                leading: SizedBox(
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenWidth(60),
                                  child: Image.network(
                                    filterlisttype[index]["business"]["logo"]
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    kTextBentonSansMed(
                                      // filterlisttype[index]['name'],
                                      filterlisttype[index]["business"]
                                          ["businessName"],
                                      fontSize:
                                          getProportionateScreenHeight(15),
                                      overFlow: TextOverflow.ellipsis,
                                    ),
                                    // buildVerticleSpace(4),
                                    kTextBentonSansReg(
                                      DateFormat("yyyy-MM-dd")
                                          .format(DateTime.parse(
                                              filterlisttype[index]["date"]
                                                  .toString()))
                                          .toString(),
                                      // filterlisttype[index]["date"],
                                      color: ColorManager.textGrey
                                          .withOpacity(0.8),
                                      letterSpacing:
                                          getProportionateScreenWidth(0.5),
                                    ),
                                    // buildVerticleSpace(8),
                                    kTextBentonSansMed(
                                      'RS ${filterlisttype[index]["amount"]}',
                                      color: ColorManager.primary,
                                      fontSize:
                                          getProportionateScreenHeight(16),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    // AppButtonWidget(
                                    //   ontap: () {},
                                    //   height: getProportionateScreenHeight(29),
                                    //   width: getProportionateScreenWidth(85),
                                    //   text: 'Buy Again',
                                    //   textSize: getProportionateScreenHeight(12),
                                    //   letterSpacing: getProportionateScreenWidth(0.5),
                                    // ),
                                    // buildVerticleSpace(11),
                                    CustomChipWidget(
                                        width: getProportionateScreenWidth(70),
                                        bgColor: filterlisttype[index]
                                                    ["status"] ==
                                                "accepted"
                                            ? ColorManager.primary
                                                .withOpacity(0.2)
                                            : filterlisttype[index]["status"] ==
                                                    "rejected"
                                                ? Colors.redAccent
                                                    .withOpacity(0.2)
                                                : Colors.amberAccent
                                                    .withOpacity(0.2),
                                        text: filterlisttype[index]["status"],
                                        textColor: filterlisttype[index]
                                                    ["status"] ==
                                                "accepted"
                                            ? ColorManager.primary
                                            : filterlisttype[index]["status"] ==
                                                    "rejected"
                                                ? Colors.redAccent
                                                : Colors.amberAccent),
                                    const Spacer(),
                                    // InkWell(
                                    //   onTap: () => _buildOrderDetails(
                                    //       context, filterlisttype[index]),
                                    //   child: kTextBentonSansReg(
                                    //     'Detail',
                                    //     color: ColorManager.blue,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),

                            // itemBuilder: (context, index) => Card(
                            //       elevation: 0,
                            //       child: ListTile(
                            //         trailing: Text(
                            //           "RS ${filterlisttype[index]["amount"]}",
                            //           style: const TextStyle(),
                            //         ),
                            //         subtitle: AppButtonWidget(
                            //           bgColor: filterlisttype[index]["status"] ==
                            //                   "accepted"
                            //               ? ColorManager.primary.withOpacity(0.2)
                            //               : filterlisttype[index]["status"] ==
                            //                       "rejected"
                            //                   ? Colors.redAccent.withOpacity(0.2)
                            //                   : Colors.amberAccent
                            //                       .withOpacity(0.2),
                            //           ontap: () {
                            //             _buildOrderDetails(
                            //                 context, filterlisttype[index]);
                            //           },
                            //           height: getProportionateScreenHeight(29),
                            //           width: getProportionateScreenWidth(85),
                            //           textColor: filterlisttype[index]
                            //                       ["status"] ==
                            //                   "accepted"
                            //               ? ColorManager.primary
                            //               : filterlisttype[index]["status"] ==
                            //                       "rejected"
                            //                   ? Colors.redAccent
                            //                   : Colors.amberAccent,
                            //           text: filterlisttype[index]["status"],
                            //           textSize: getProportionateScreenHeight(12),
                            //           letterSpacing:
                            //               getProportionateScreenWidth(0.5),
                            //         ),
                            //         leading: Image.asset(AppImages.menu),
                            //         title: Text(
                            //           filterlisttype[index]["date"],
                            //           style: const TextStyle(fontSize: 10),
                            //         ),
                            //       ),
                            //     )),
                          ),
                        ),
                      ),
      ],
    );
  }

  Future<dynamic> _buildOrderDetails(
      BuildContext context, Map<String, dynamic> datalist) {
    return showDialog(
      context: context,
      barrierColor: ColorManager.transparent,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
          vertical: getProportionateScreenHeight(16),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(kToolbarHeight + 8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        backgroundColor: ColorManager.white,
        elevation: 5,
        content: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  kTextBentonSansBold(
                    'Detail of Order',
                    fontSize: getProportionateScreenHeight(31),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: getProportionateScreenHeight(24),
                    ),
                  ),
                ],
              ),
              buildVerticleSpace(30),
              CustomChipWidget(
                width: getProportionateScreenWidth(108),
                text: 'Pervious shop',
              ),
              buildVerticleSpace(20),
              kTextBentonSansReg(
                datalist["comments"].toString(),
                fontSize: getProportionateScreenHeight(12),
                lineHeight: getProportionateScreenHeight(2.5),
                maxLines: 4,
                textOverFlow: TextOverflow.ellipsis,
              ),
              buildVerticleSpace(12),
              CustomChipWidget(
                  width: getProportionateScreenWidth(95),
                  bgColor: datalist["status"] == "accepted"
                      ? ColorManager.primary.withOpacity(0.2)
                      : datalist["status"] == "rejected"
                          ? Colors.redAccent.withOpacity(0.2)
                          : Colors.amberAccent.withOpacity(0.2),
                  text: datalist["status"],
                  textColor: datalist["status"] == "accepted"
                      ? ColorManager.primary
                      : datalist["status"] == "rejected"
                          ? Colors.redAccent
                          : Colors.amberAccent),
              buildVerticleSpace(25),
              SizedBox(
                height: getProportionateScreenHeight(120),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          kTextBentonSansMed("Order Date"),
                          buildHorizontalSpace(5),
                          kTextBentonSansReg(datalist["date"]),
                        ],
                      ),
                      Row(
                        children: [
                          kTextBentonSansMed("Order tine"),
                          buildHorizontalSpace(5),
                          kTextBentonSansReg(datalist["date"]),
                        ],
                      ),
                      Row(
                        children: [
                          kTextBentonSansMed("commission"),
                          buildHorizontalSpace(5),
                          kTextBentonSansReg(datalist["commission"] ?? "0"),
                        ],
                      ),
                      Row(
                        children: [
                          kTextBentonSansMed("Total Amount"),
                          buildHorizontalSpace(5),
                          kTextBentonSansReg(datalist["amount"]),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
          // color: ColorManager.transparent,
        ),
      ),
    );
  }

  Future<dynamic> _buildOrderDetailsRecentCustomer(
      BuildContext context, String status, Map<String, dynamic>? orderdata) {
    print(orderdata);
    List<OrderInfoModel> orderInfoListdata = [
      OrderInfoModel(
          'Order Date :',
          DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(orderdata!["date"].toString()))
              .toString()),
      OrderInfoModel(
          'Order Time :',
          DateFormat("hh:mm")
              .format(DateTime.parse(orderdata["date"].toString()))
              .toString()),
      OrderInfoModel(
          'Shop Contact :', orderdata["business"]["mobile"].toString()),
      OrderInfoModel('Total Amount :', '${orderdata["amount"].toString()}/-'),
    ];
    return showDialog(
      context: context,
      barrierColor: ColorManager.transparent,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
          vertical: getProportionateScreenHeight(16),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(kToolbarHeight + 8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        backgroundColor: ColorManager.white,
        elevation: 5,
        content: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  kTextBentonSansBold(
                    'Detail of Order',
                    fontSize: getProportionateScreenHeight(31),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: getProportionateScreenHeight(24),
                    ),
                  ),
                ],
              ),
              buildVerticleSpace(30),
              CustomChipWidget(
                  width: getProportionateScreenWidth(132),
                  text: 'Pervious Shop'),
              buildVerticleSpace(20),
              kTextBentonSansMed(
                "${orderdata["business"]["businessName"]}",
                fontSize: getProportionateScreenHeight(27),
              ),
              buildVerticleSpace(65),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.location_on_outlined,
              //       color: ColorManager.primaryLight,
              //       size: getProportionateScreenHeight(20),
              //     ),
              //     buildHorizontalSpace(12),
              //     kTextBentonSansReg(
              //       '19 Km',
              //       color: ColorManager.textGrey.withOpacity(0.2),
              //     ),
              //   ],
              // ),

              // buildVerticleSpace(20),
              kTextBentonSansReg(
                "${orderdata["business"]["about"]}",
                fontSize: getProportionateScreenHeight(12),
                lineHeight: getProportionateScreenHeight(2.5),
                maxLines: 4,
                textOverFlow: TextOverflow.ellipsis,
              ),
              buildVerticleSpace(12),
              CustomChipWidget(
                width: getProportionateScreenWidth(95),
                bgColor: ColorManager.ambar.withOpacity(0.2),
                text: orderdata["status"],
                textColor: ColorManager.ambar,
              ),
              buildVerticleSpace(25),
              SizedBox(
                height: getProportionateScreenHeight(120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    orderInfoListdata.length,
                    (index) => Row(
                      children: [
                        kTextBentonSansMed(orderInfoListdata[index].title),
                        buildHorizontalSpace(5),
                        kTextBentonSansReg(orderInfoListdata[index].value),
                      ],
                    ),
                  ),
                ),
              ),
              buildVerticleSpace(14),
              AppButtonWidget(
                bgColor:
                    status.toLowerCase().trim() == "spam".toLowerCase().trim()
                        ? Colors.red
                        : status.toLowerCase().trim() ==
                                "rejected".toLowerCase().trim()
                            ? Colors.red
                            : null,
                ontap: () {},
                text: status,
              ),
            ],
          ),
          // color: ColorManager.transparent,
        ),
      ),
    );
  }
}

class OrderInfoModel {
  String title;
  String value;
  OrderInfoModel(this.title, this.value);
}
