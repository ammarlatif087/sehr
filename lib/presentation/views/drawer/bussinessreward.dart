import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/views/drawer/rewardAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';
import 'dart:convert' as convert;

class RewardViewBussiness extends StatefulWidget {
  const RewardViewBussiness({super.key});

  @override
  State<RewardViewBussiness> createState() => _RewardViewBussinessState();
}

class _RewardViewBussinessState extends State<RewardViewBussiness> {
  final Rewardapi _apicall = Rewardapi();
  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    }

    setState(() {});
  }

  bool nodata = false;

  Future apicall() async {
    print("object checkinh");
    datatest = null;
    filterlist.clear();
    _list.clear();
    setState(() {});

    var responseofdata = await _apicall.fetchMyorders();

    datatest = convert.jsonDecode(responseofdata.body);

    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  String rewardname = "";
  String rewardtitlr = "";

  checkinformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gradekey = prefs.getString("RewardsTarget").toString();
    String rewardstile = prefs.getString("RewardsTitle").toString();
    if (gradekey.toString() == "null") {
      fetchorders();
    } else {
      setState(() {
        rewardname = gradekey;
        rewardtitlr = rewardstile;
        isactivated = true;
        filterlist.add("1");
      });
    }
  }

  bool isactivated = false;

  @override
  void initState() {
    checkinformation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: filterlist.isEmpty
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(10),
                        horizontal: getProportionateScreenWidth(30)),
                    child: kTextBentonSansBold("SEHR Reward",
                        fontSize: getProportionateScreenHeight(31)),
                  ),
                  isactivated == false
                      ? Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(25)),
                            shrinkWrap: true,
                            itemCount: filterlist.length,
                            separatorBuilder: (context, index) =>
                                buildVerticleSpace(15),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Sure"),
                                        content: Text(
                                            "sure to activate ${filterlist[index]["title"]}"),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setString(
                                                    "RewardsTargetBussiness",
                                                    filterlist[index]
                                                            ["salesTarget"]
                                                        .toString());
                                                prefs.setString(
                                                    "RewardsTitle",
                                                    filterlist[index]["title"]
                                                        .toString());
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      );
                                    });
                              },
                              child: CustomCardWidget(
                                titleText: filterlist[index]["title"],
                                valueText: 'Activate',
                                description: filterlist[index]["description"],
                              ),
                            ),
                          ),
                        )
                      : CustomCardWidget(
                          titleText: rewardtitlr,
                          valueText: 'Activated',
                          description: 'target sale ${rewardname}',
                        ),
                ],
              ),
      ),
    );
  }
}
