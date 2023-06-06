import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/notifications/notifications.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';
import 'package:sehr/presentation/view_models/bottom_nav_view_model.dart';
import 'package:sehr/presentation/views/bottom_navigation/permissionhandler.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:sehr/presentation/views/drawer/reward_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';
import '../../view_models/customer_view_models/home_view_model.dart';

var notificationcontrollers = Get.put(NotificationController());

// ignore: must_be_immutable
class BottomNavigationView extends StatefulWidget {
  int pageindexview = 0;
  BottomNavigationView({super.key, required this.pageindexview});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  Timer? _timer;
  Timer? _notificatintimer;

  String showbussinespages = "";

  String _userRole = '';

  int pageindex = 0;

  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  bool nodata = false;

  var getxcontroller = Get.put(AppController());
  timerofreward() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (getxcontroller.postloading3.value == true) {
        if (getxcontroller.rewardsdata == null &&
            getxcontroller.rewardslist.isEmpty) {
          // _timer!.cancel();
          timer.cancel();
          Get.offAll(() => const RewardView());
        } else {}
      }
    });
  }

  Future apicall() async {
    print("object checkinh");
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await _orderApi
        .fetchorderrequest(prefs.getString("sehrcode").toString());
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      if (element["status"].toString() == "pending") {
        filterlist.add(element);
      }
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    // var profileType =
    //     Provider.of<ProfileViewModel>(context, listen: false).selectedUserRole;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return ChangeNotifierProvider(
        create: (context) => CustomerBottomNavViewModel(),
        child: Consumer<AuthViewModel>(builder: (context, viewModel, child) {
          if (address == null) {
            viewModel.init();
          }
          return SafeArea(
            child: Consumer<CustomerBottomNavViewModel>(
              builder: (ctx, viewModel, child) {
                return WillPopScope(
                  onWillPop: () async {
                    if (viewModel.index == 2) {
                      viewModel.pageChange(0);
                    } else {
                      Get.back();
                    }
                    return false;
                  },
                  child: Scaffold(
                    // drawer: const Drawer(),
                    appBar: viewModel.index == 2 ? null : _buildAppBar(context),

                    body: showbussinespages == "true"
                        ? viewModel.businessPages[viewModel.index]
                        : viewModel.customerPages[viewModel.index],
                    // : viewModel.businessPages[viewModel.index],

                    // bottomNavigationBar: ,
                    bottomNavigationBar: _userRole == 'business'
                        ? _buildBottomNavigation(_userRole)
                        : viewModel.index == 2
                            ? null
                            : _buildBottomNavigation(_userRole),
                  ),
                );
              },
            ),
          );
        }));
  }

  checklocation() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      } else {
        Get.offAll(() => const PermissionHandler());
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  fetchscreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showbussinespages = prefs.getString("openbussiness").toString();
    _userRole = prefs.getString("userRole").toString();
    if (_userRole == "null") {
      _userRole = "user";
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    timerofreward();
    checklocation();
    fetchscreen();
    notificationInitialize();
    // TODO: implement initState
    super.initState();
  }

  notificationInitialize() {
    _notificatintimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_userRole == 'business') {
        if (mounted) {
          await apicall();
          // ignore: use_build_context_synchronously
          notificationcontrollers.callNotifications(filterlist, context);
        }
      } else {
        _notificatintimer!.cancel();
      }
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.primary,
      leadingWidth: getProportionateScreenWidth(30),
      leading: IconButton(
        onPressed: () {
          if (ZoomDrawer.of(context)!.isOpen()) {
            ZoomDrawer.of(context)!.close();
          } else {
            ZoomDrawer.of(context)!.open();
          }
          // final zoomDrawer = ZoomDrawer.of(context);
          // if (zoomDrawer != null) {
          //   if (zoomDrawer.isOpen()) {
          //     zoomDrawer.close();
          //   } else {
          //     zoomDrawer.open();
          //   }
          // }
        },
        icon: const Icon(Icons.menu),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kTextBentonSansMed(
            'Current Location',
            fontSize: getProportionateScreenHeight(16),
            color: ColorManager.white,
          ),
          kTextBentonSansReg(
            address.toString() == "null" ? "" : address.toString(),
            fontSize: getProportionateScreenHeight(13),
            color: ColorManager.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(String userRole) {
    return Container(
      height: getProportionateScreenHeight(65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getProportionateScreenHeight(22),
          ),
          topRight: Radius.circular(
            getProportionateScreenHeight(22),
          ),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: 10.0,
            // spreadRadius: 1.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Consumer<CustomerBottomNavViewModel>(
        builder: (context, viweModel, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            userRole == 'user'
                ? viweModel.customerPages.length
                : viweModel.businessPages.length,
            (index) => InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    pageindex = index;
                  });
                  viweModel.pageChange(index);
                }
              },
              child: userRole == 'user'
                  ? index == 2
                      ? Lottie.asset(
                          AppIcons.lottieIcon2,
                          height: getProportionateScreenHeight(55),
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          viweModel.customerIcons[index],
                          height: getProportionateScreenHeight(25),
                          color: viweModel.index == index
                              ? ColorManager.primary
                              : null,
                        )
                  : Image.asset(
                      viweModel.businessIcons[index],
                      height: index == 2
                          ? getProportionateScreenHeight(55)
                          : getProportionateScreenHeight(25),
                      color: viweModel.index == index
                          ? ColorManager.primary
                          : null,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
