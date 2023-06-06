import 'dart:convert' as convert;

import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_card_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

class BusinessRecentOrdersView extends StatefulWidget {
  const BusinessRecentOrdersView({super.key});

  @override
  State<BusinessRecentOrdersView> createState() =>
      _BusinessRecentOrdersViewState();
}

class OrderInfoModel {
  String title;
  String value;
  OrderInfoModel(this.title, this.value);
}

class SearchRow extends StatelessWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchField(),
        const Spacer(),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return Container(
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
      child: IconButton(
        splashColor: ColorManager.transparent,
        splashRadius: getProportionateScreenHeight(30),
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
    );
  }

  _buildSearchField() {}
}

class _BusinessRecentOrdersViewState extends State<BusinessRecentOrdersView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  bool nodata = false;

  String filtername = "All";
  List<dynamic> filterlist = [];

  List<dynamic> searchfilterlist = [];
  TextEditingController searchcontroller = TextEditingController();

  List<OrderInfoModel> orderInfoList = [
    OrderInfoModel('Order Date :', '02/02/2023'),
    OrderInfoModel('Order Time :', '23:36 pm'),
    OrderInfoModel('Total Amount :', '3500/-'),
  ];

  Future apicall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await _orderApi
        .fetchorderrequest(prefs.getString("sehrcode").toString());
    print(prefs.getString("sehrcode").toString());
    datatest = convert.jsonDecode(responseofdata.body) as dynamic;
    _list.add(datatest == null ? [] : datatest!.values.toList());
    print(_list);
    _list[0][0].forEach((element) {
      if (element["status"].toString() != "pending") {
        filterlist.add(element);
      }
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    searchfilterlist.sort((a, b) => DateTime.parse(b["date"].toString())
        .compareTo(DateTime.parse(a["date"].toString())));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildVerticleSpace(18),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(23),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kTextBentonSansBold(
                'Find Your\nPervious Orders',
                fontSize: getProportionateScreenHeight(31),
              ),
              buildVerticleSpace(18),
              Row(
                children: [
                  TextFormField(
                    controller: searchcontroller..text = filtername,
                    readOnly: true,
                    onChanged: (a) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.secondaryLight.withOpacity(0.1),
                      constraints: BoxConstraints(
                        maxHeight: getProportionateScreenHeight(50),
                        maxWidth: getProportionateScreenWidth(280),
                      ),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(15),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(18),
                          vertical: getProportionateScreenHeight(13),
                        ),
                        child: Image.asset(AppIcons.searchIcon),
                      ),
                      hintText: 'What do you want to order?',
                      hintStyle: TextStyleManager.regularTextStyle(
                        color: ColorManager.icon.withOpacity(0.4),
                        fontSize: getProportionateScreenHeight(12),
                      ),
                    ),
                  ),
                  const Spacer(),
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
                      return ["All", "accepted", "rejected", "spam"]
                          .map(
                            (e) => PopupMenuItem(
                                child: Text(e),
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      filtername = e.toString();
                                      if (e == "All") {
                                        searchfilterlist = filterlist;
                                      } else {
                                        searchfilterlist = filterlist
                                            .where((element) =>
                                                element["status"]
                                                    .toString()
                                                    .toLowerCase()
                                                    .trim() ==
                                                e
                                                    .toString()
                                                    .toLowerCase()
                                                    .trim())
                                            .toList();
                                      }
                                    });
                                  }
                                }),
                          )
                          .toList();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        buildVerticleSpace(15),
        nodata == true
            ? Container(
                child: const Center(
                  child: Text("No Recent Orders"),
                ),
              )
            : filterlist.isEmpty
                ? Container(
                    child: const Center(
                      child: LinearProgressIndicator(),
                    ),
                  )
                : searchfilterlist.isEmpty
                    ? Container(
                        child: const Center(
                          child: Text("No Type Order"),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(25),
                            // vertical: getProportionateScreenHeight(15),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: searchfilterlist.length,
                            separatorBuilder: (context, index) =>
                                buildVerticleSpace(20),
                            padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(50),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                CustomListTileWidget(
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: Image.network(
                                  searchfilterlist[index]["customer"]["avatar"]
                                      .toString(),
                                  fit: BoxFit.fill,
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
                                    "${searchfilterlist[index]["customer"]["firstName"]} ${searchfilterlist[index]["customer"]["lastName"]}",
                                    fontSize: getProportionateScreenHeight(15),
                                  ),
                                  kTextBentonSansReg(
                                    DateFormat("yyyy-MM-dd")
                                        .format(DateTime.parse(
                                            searchfilterlist[index]["date"]
                                                .toString()))
                                        .toString(),

                                    // searchfilterlist[index]["date"],
                                    color:
                                        ColorManager.textGrey.withOpacity(0.8),
                                    letterSpacing:
                                        getProportionateScreenWidth(0.5),
                                  ),
                                  kTextBentonSansMed(
                                    'RS ${searchfilterlist[index]["amount"]}',
                                    color: searchfilterlist[index]["status"] ==
                                            'accepted'
                                        ? ColorManager.primary
                                        : ColorManager.textGrey
                                            .withOpacity(0.3),
                                    fontSize: getProportionateScreenHeight(19),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  AppButtonWidget(
                                    bgColor: searchfilterlist[index]
                                                ["status"] ==
                                            'accepted'
                                        ? null
                                        : ColorManager.textGrey
                                            .withOpacity(0.2),
                                    ontap: () {},
                                    height: getProportionateScreenHeight(29),
                                    width: getProportionateScreenWidth(85),
                                    text: searchfilterlist[index]["status"],
                                    textSize: getProportionateScreenHeight(12),
                                    letterSpacing:
                                        getProportionateScreenWidth(0.5),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: searchfilterlist[index]["status"] ==
                                            'accepted'
                                        ? () => _buildOrderDetails(
                                            context,
                                            searchfilterlist[index]["status"]
                                                .toString(),
                                            searchfilterlist[index])
                                        : null,
                                    child: kTextBentonSansReg(
                                      'Detail',
                                      color: searchfilterlist[index]
                                                  ["status"] ==
                                              'accepted'
                                          ? ColorManager.blue
                                          : ColorManager.textGrey
                                              .withOpacity(0.3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // itemBuilder: (context, index) => GestureDetector(
                          //       onTap: () {
                          //         _buildOrderDetails(
                          //             context,
                          //             searchfilterlist[index]["status"]
                          //                 .toString(),
                          //             searchfilterlist[index]);
                          //       },
                          //       child: Card(
                          //         elevation: 0,
                          //         child: ListTile(
                          //           trailing: Text(
                          //             "RS ${searchfilterlist[index]["amount"]}",
                          //             style: const TextStyle(),
                          //           ),
                          //           subtitle: AppButtonWidget(
                          //             bgColor: searchfilterlist[index]
                          //                         ["status"] ==
                          //                     "accepted"
                          //                 ? null
                          //                 : Colors.red,
                          //             ontap: () {},
                          //             height:
                          //                 getProportionateScreenHeight(29),
                          //             width:
                          //                 getProportionateScreenWidth(85),
                          //             text: searchfilterlist[index]
                          //                 ["status"],
                          //             textSize:
                          //                 getProportionateScreenHeight(12),
                          //             letterSpacing:
                          //                 getProportionateScreenWidth(0.5),
                          //           ),
                          //           leading: Image.asset(AppImages.menu),
                          //           title: Text(
                          //             searchfilterlist[index]["date"],
                          //             style: const TextStyle(fontSize: 10),
                          //           ),
                          //         ),
                          //       ),
                          //     )),
                        ),
                      ),
      ],
    );
  }

  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      searchfilterlist = filterlist;
    }
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

  Future<dynamic> _buildOrderDetails(
      BuildContext context, String status, Map<String, dynamic>? orderdata) {
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
                  text: 'Pervious Customer'),
              buildVerticleSpace(20),
              kTextBentonSansMed(
                "${orderdata["customer"]["firstName"]} ${orderdata["customer"]["lastName"]}",
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
                orderdata["comments"].toString(),
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
                    orderInfoList.length,
                    (index) => Row(
                      children: [
                        kTextBentonSansMed(orderInfoList[index].title),
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
