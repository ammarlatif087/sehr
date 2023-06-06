import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/business_view_models/total_sales_view_model.dart';
import 'package:sehr/presentation/views/business_views/payment/payment_view.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:sehr/presentation/views/business_views/total_sales/fetchcomission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../src/index.dart';

class TotalSalesView extends StatefulWidget {
  const TotalSalesView({super.key});

  @override
  State<TotalSalesView> createState() => _TotalSalesViewState();
}

class _TotalSalesViewState extends State<TotalSalesView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  String comissionAmount = "0";
  fetchorders(String datetimerange) async {
    await apicall(datetimerange);
    comissionAmount = _list[0][2].toString();
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;

  Future apicall(String datetimerange) async {
    var responseofdata = await reportscommissions(datetimerange);
    datatest = convert.jsonDecode(responseofdata.body) as dynamic;
    _list.add(datatest == null ? [] : datatest!.values.toList());
    return datatest;
  }

  String datetimerange = DateFormat("yyyy-MM-dd").format(DateTime.now());

  //orderid
  Map<String, dynamic>? datatestorders;
  final List<dynamic> _listorders = [];
  List<dynamic> filterlist = [];
  Future orderscall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await _orderApi
        .fetchorderrequest(prefs.getString("sehrcode").toString());
    datatestorders = convert.jsonDecode(responseofdata.body) as dynamic;
    _listorders
        .add(datatestorders == null ? [] : datatestorders!.values.toList());
    _listorders[0][0].forEach((element) {
      if (element["status"].toString() == "accepted") {
        filterlist.add(element);
      }
    });

    return datatest;
  }

  List<int> commissionsids = [];
  List<dynamic> filterlistofordersbydate = [];

  fetchallorders() async {
    await orderscall();
    if (filterlist.isNotEmpty) {}

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchorders(datetimerange);
    fetchallorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TotalSaleViewModel(),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Consumer<TotalSaleViewModel>(
              builder: (context, viewModel, child) => Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shadowColor: ColorManager.lightGrey,
                child: TabBar(
                  labelColor: ColorManager.black,
                  labelStyle: TextStyleManager.mediumTextStyle(
                    fontSize: getProportionateScreenHeight(16),
                  ),
                  indicatorColor: ColorManager.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Daily'),
                    Tab(text: 'Weekly'),
                    Tab(text: 'Monthly'),
                  ],
                  onTap: (value) {
                    viewModel.changeDuration(value);
                    print(value);
                    if (mounted) {
                      setState(() {
                        if (value == 0) {
                          _list.clear();
                          datetimerange =
                              DateFormat("yyyy-MM-dd").format(DateTime.now());
                          fetchorders(datetimerange);
                        } else if (value == 1) {
                          _list.clear();
                          datetimerange = DateFormat("yyyy-MM-dd").format(
                              DateTime.now().subtract(const Duration(days: 7)));
                          fetchorders(datetimerange);
                        } else if (value == 2) {
                          _list.clear();
                          datetimerange = DateFormat("yyyy-MM-dd").format(
                              DateTime.now()
                                  .subtract(const Duration(days: 30)));
                          fetchorders(datetimerange);
                        }
                      });
                    }
                  },
                ),
              ),
            ),
            _list.isEmpty
                ? Container(
                    child: const Center(
                      child: LinearProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            _buildDetailCard('Total Completed\nOrders',
                                _list[0][0].toString()),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Sehr\nSale',
                                'PKR: ${_list[0][1].toString()}/-'),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Commision\nTo be Paid',
                                'PKR: ${_list[0][2].toString()}/-'),
                            buildVerticleSpace(36),
                            buildVerticleSpace(28),
                            AppButtonWidget(
                              ontap: () {
                                if (comissionAmount != "0") {
                                  Get.to(() => PaymentView(
                                        datetime: datetimerange,
                                        amount: comissionAmount,
                                      ));
                                } else {
                                  Utils.flushBarErrorMessage(context,
                                      "No Amount Record Found for the time period");
                                }
                              },
                              text: 'Pay',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Container(
      height: getProportionateScreenHeight(103),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(22),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: getProportionateScreenHeight(5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: kTextBentonSansBold(
              title,
              fontSize: getProportionateScreenHeight(18),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(15)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: kTextBentonSansBold(
                value,
                color: ColorManager.primary,
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
