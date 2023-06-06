import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/views/drawer/rewardAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';
import 'dart:convert' as convert;

class MemberShipView extends StatefulWidget {
  const MemberShipView({super.key});

  @override
  State<MemberShipView> createState() => _MemberShipViewState();
}

class _MemberShipViewState extends State<MemberShipView> {
  checkdrade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    membership = prefs.getString("gradeId").toString();

    print(membership);
    setState(() {});
  }

  String membership = "";
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

    var responseofdata = await _apicall.fetchMembersShip();

    datatest = convert.jsonDecode(responseofdata.body);

    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  String gradename = "";

  checkinformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gradekey = prefs.getString("Grade").toString();
    if (gradekey.toString() == "null") {
      fetchorders();
    } else {
      setState(() {
        gradename = gradekey;
        isactivated = true;
        filterlist.add("1");
      });
    }
  }

  bool isactivated = false;

  @override
  void initState() {
    checkdrade();
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
                    child: kTextBentonSansBold("Membership",
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
                              itemBuilder: (context, index) {
                                return membership.toLowerCase() ==
                                        filterlist[index]["id"]
                                            .toString()
                                            .toLowerCase()
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorManager.primary)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Activated Membership"),
                                              GestureDetector(
                                                onTap: () {},
                                                child: CustomCardWidget(
                                                  titleText: filterlist[index]
                                                      ["title"],
                                                  valueText: 'Activate',
                                                  description:
                                                      'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {},
                                        child: CustomCardWidget(
                                          titleText: filterlist[index]["title"],
                                          valueText: 'Activate',
                                          description:
                                              'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
                                        ),
                                      );
                              }),
                        )
                      : CustomCardWidget(
                          titleText: gradename,
                          valueText: 'Activated',
                          description:
                              'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
                        ),
                ],
              ),
      ),
    );
  }
}
