import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';

import 'package:sehr/presentation/view_models/business_view_models/total_sales_view_model.dart';
import 'package:sehr/presentation/views/business_views/progress/mypayments.dart';

import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:sehr/presentation/views/business_views/total_sales/fetchcomission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../src/index.dart';

class TotalCommission extends StatefulWidget {
  const TotalCommission({super.key});

  @override
  State<TotalCommission> createState() => _TotalCommissionState();
}

class _TotalCommissionState extends State<TotalCommission> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatestcommission;
  final List<dynamic> _listpayment = [];
  List<dynamic> filterlistpayment = [];
  bool nodata = false;

  Future apicalls() async {
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

  //

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
    await apicalls();
    if (filterlist.isNotEmpty) {}

    if (mounted) {
      setState(() {});
    }
  }

  String mytotalorders = "0";

  @override
  void initState() {
    fetchorders(datetimerange);
    fetchallorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => TotalSaleViewModel(),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
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
                              _buildDetailCard('Total Completed Orders',
                                  filterlist.length.toString()),
                              buildVerticleSpace(22),
                              _buildDetailCard('Sale',
                                  'PKR: ${filterlist.fold(0, (previousValue, element) => previousValue + int.parse(element["amount"].toString())).toString()}/-'),
                              buildVerticleSpace(22),
                              _buildDetailCard('Commisson',
                                  'PKR: ${filterlist.fold(0, (previousValue, element) => previousValue + int.parse(element["commission"].toString())).toString()}/-'),
                              buildVerticleSpace(22),
                              _buildDetailCard('Commision Paid',
                                  '${filterlistpayment.fold(0, (previousValue, element) => previousValue + int.parse(double.parse(element["amount"].toString()).toStringAsFixed(0).toString())).toString()}/-'),
                              buildVerticleSpace(36),
                              buildVerticleSpace(28),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
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
