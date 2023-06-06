import 'dart:convert' as convert;
import 'dart:convert';

import 'package:sehr/app/index.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/drawer/rewardAPI.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';

class RewardView extends StatefulWidget {
  const RewardView({super.key});

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  var getxcontroller = Get.put(AppController());
  final Rewardapi _apicall = Rewardapi();
  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  // ignore: prefer_typing_uninitialized_variables
  var activatedReward;
  bool nodata = false;

  bool isactivated = false;

  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }
    var responseofdata = await _apicall.fetchMyorders();

    datatest = convert.jsonDecode(responseofdata.body);

    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return getxcontroller.postloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : filterlist.isEmpty
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
                        child: kTextBentonSansBold("SEHR Packages",
                            fontSize: getProportionateScreenHeight(31)),
                      ),
                      activatedReward.length != 0
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(10),
                                          horizontal:
                                              getProportionateScreenWidth(30)),
                                      child: kTextBentonSansBold(
                                          "Activated Package",
                                          fontSize:
                                              getProportionateScreenHeight(20)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(25)),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(filterlist.length);
                                    },
                                    child: CustomCardWidget(
                                      titleText: activatedReward[0]["title"],
                                      valueText: 'Activated',
                                      description: activatedReward[0]
                                          ["description"],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      activatedReward.length != 0
                          ? Container()
                          : Expanded(
                              child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(25)),
                                  shrinkWrap: true,
                                  itemCount: filterlist.length,
                                  separatorBuilder: (context, index) =>
                                      buildVerticleSpace(15),
                                  itemBuilder: (context, index) {
                                    // if (activatedReward[0]["id"] ==
                                    //     filterlist[index]["id"]) {
                                    //   return null;
                                    // } else {

                                    // }
                                    return GestureDetector(
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
                                                        var response =
                                                            await verifyreward(
                                                                filterlist[index]
                                                                        ["id"]
                                                                    .toString());
                                                        if (response != null) {
                                                          await getxcontroller
                                                              .fetchrewards();
                                                          Get.offAll(() =>
                                                              DrawerView(
                                                                pageindex: 0,
                                                              ));
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
                                        description: filterlist[index]
                                            ["description"],
                                      ),
                                    );
                                  }),
                            )
                    ],
                  );
      })),
    );
  }

  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      if (getxcontroller.rewardslist.isEmpty) {
        activatedReward = [];
      } else {
        activatedReward = filterlist
            .where((element) =>
                element["id"].toString().trim() ==
                getxcontroller.rewardslist[0][0]["id"].toString().trim())
            .toList();
      }
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
}

activatereward(String id) async {
  final uri = Uri.parse('http://3.133.0.29/api/user/subscribe-reward/$id');
  final headers = {"accept": "*/*"};

  var response = await http.post(uri, headers: headers);

  return response;
}

verifyreward(String id) async {
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getString('accessToken'));
  var token = prefs.getString('accessToken');
  final uri = Uri.parse('http://3.133.0.29/api/user/subscribe-reward/$id');
  final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
  Map body = {};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  var response = await http.post(uri,
      headers: headers, body: jsonBody, encoding: encoding);
  print(response.body);
  if (response.statusCode == 201) {
    return response;
  } else {
    return null;
  }
}
