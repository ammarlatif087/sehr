import 'dart:convert' as convert;

import 'package:sehr/app/index.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../src/index.dart';

class CustomCardWidget extends StatelessWidget {
  final String titleText;

  final String valueText;
  final String? description;
  final String? rewardTitle;
  final Widget? child;
  const CustomCardWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    this.description,
    this.child,
    this.rewardTitle,
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
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                kTextBentonSansBold(
                  titleText,
                  fontSize: getProportionateScreenHeight(15),
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
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            // buildVerticleSpace(32),

            kTextBentonSansBold(
              rewardTitle ?? '',
              fontSize: getProportionateScreenHeight(14),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            child ??
                kTextBentonSansReg(
                  description ?? '',
                  fontSize: getProportionateScreenHeight(12),
                  lineHeight: getProportionateScreenHeight(2),
                  textOverFlow: TextOverflow.ellipsis,
                  maxLines: 10,
                ),
          ],
        ),
      ),
    );
  }
}

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class SpendData {
  final String day;

  final double amount;
  SpendData(this.day, this.amount);
}

class _ProgressViewState extends State<ProgressView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  bool nodata = false;

  late List<String> timelist =
      List.generate(filterlist.length, (index) => "202$index").toList();

  String targetamount = "";
  late List<SpendData> data = filterlist
      .mapIndexed((e, index) =>
          SpendData(timelist[index], double.parse(e["amount"].toString())))
      .toList();

  late double remainingAmount = int.parse(targetamount) -
      filterlist.fold(0, (t, e) => t + int.parse(e["amount"]));

  late List<SpendData> data2 = [
    SpendData('Remaing', remainingAmount < 0 ? 0 : remainingAmount),
    SpendData(
        'Spend', filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))),
  ];

  var getxcontroller = Get.put(AppController());

  bool isloading = true;
  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }
    setState(() {});
    var responseofdata = await _orderApi.fetchmyorderscustomers();
    datatest = convert.jsonDecode(responseofdata.body);
    _list.clear();
    _list.add(datatest == null ? [] : datatest!.values.toList());

    _list[0][0].forEach((element) {
      if (element["status"].toString().toLowerCase().trim() ==
          "accepted".toLowerCase().trim()) {
        filterlist.add(element);
      }
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getxcontroller.postloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : nodata == true
              ? Container(
                  child: const Center(
                    child: Text("No Any reward is activated"),
                  ),
                )
              : isloading == true
                  ? Container(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : filterlist.isEmpty
                      ? Container(
                          child: const Center(
                            child: Text("No Any order is Completed"),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(25),
                              vertical: getProportionateScreenHeight(25),
                            ),
                            child: Column(
                              children: [
                                CustomCardWidget(
                                    titleText: 'Target Amount',
                                    rewardTitle: 'Free Home',
                                    valueText: 'Rs: $targetamount/-',
                                    description: getxcontroller
                                        .rewardslist.first[0]["description"]),
                                buildVerticleSpace(22),
                                CustomCardWidget(
                                  titleText: 'Spend Amount',
                                  valueText: filterlist
                                      .fold(0,
                                          (t, e) => t + int.parse(e["amount"]))
                                      .toString(),
                                  child: SizedBox(
                                    height: getProportionateScreenHeight(150),
                                    child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      // primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(
                                        minimum: 0,
                                        maximum: 1000,
                                        interval: 10000,
                                      ),
                                      series: [
                                        ColumnSeries(
                                          color: ColorManager.primaryLight,
                                          dataSource: data,
                                          xValueMapper: (SpendData sales, _) =>
                                              sales.day,
                                          yValueMapper: (SpendData sales, _) =>
                                              sales.amount,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                buildVerticleSpace(22),
                                CustomCardWidget(
                                  titleText: remainingAmount < 0
                                      ? "Target Achieved"
                                      : 'Remaining',
                                  valueText:
                                      'Rs: ${(int.parse(targetamount) - filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))) < 0 ? "0" : int.parse(targetamount) - filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))}',
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(130),
                                        child: SfCircularChart(
                                          palette: [
                                            ColorManager.primaryLight,
                                            ColorManager.error,
                                          ],
                                          series: [
                                            DoughnutSeries<SpendData, String>(
                                              radius: '50',
                                              innerRadius: '40',
                                              dataSource: data2,
                                              xValueMapper:
                                                  (SpendData data, _) =>
                                                      data.day,
                                              yValueMapper:
                                                  (SpendData data, _) =>
                                                      data.amount,
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: percent()
                                                  .truncate()
                                                  .toString(),
                                              style: GoogleFonts.libreFranklin(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        12),
                                                color: ColorManager.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '/100%',
                                              style: GoogleFonts.libreFranklin(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        14),
                                                color: ColorManager.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      buildVerticleSpace(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
    });
  }

  fetchorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String gradekey = prefs.getString("RewardsTarget").toString();
    await apicall();
    if (getxcontroller.rewardslist.isEmpty) {
      nodata = true;
    } else {
      if (mounted) {
        setState(() {
          targetamount =
              getxcontroller.rewardslist.first[0]["salesTarget"].toString();
        });
      }
      print(getxcontroller.rewardslist.first[0]["salesTarget"]);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  double percent() {
    var per = (filterlist.fold(0, (t, e) => t + int.parse(e["amount"])) /
            int.parse(targetamount)) *
        100;
    if (per > 100) {
      return 100;
    } else {
      return per;
    }
  }
}

extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((element) => f(element, index++));
  }
}
