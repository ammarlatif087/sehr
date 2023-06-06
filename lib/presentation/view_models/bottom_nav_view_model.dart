import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/views/business_views/progress/business_progress_veiw.dart';
import 'package:sehr/presentation/views/business_views/recent_orders/business_recent_orders_view.dart';
import 'package:sehr/presentation/views/business_views/requested_order/requested_orders_view.dart';
import 'package:sehr/presentation/views/business_views/total_sales/total_sales_view.dart';
import 'package:sehr/presentation/views/business_views/total_sales/totalcomission.dart';
import 'package:sehr/presentation/views/customer_views/favourite/favourite_view.dart';
import 'package:sehr/presentation/views/customer_views/home/home_view.dart';
import 'package:sehr/presentation/views/customer_views/progress/customer_progress_view.dart';
import 'package:sehr/presentation/views/customer_views/scanner/scanner_view.dart';

import '../src/index.dart';
import '../views/customer_views/recent_orders.dart/customer_recent_orders_view.dart';

class CustomerBottomNavViewModel extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  bool dashboardscreenbussiness = false;

  void chnagescreen() {
    dashboardscreenbussiness = true;
    ChangeNotifier();
    notifyListeners();
  }

  void pageChange(int index) {
    // if (index == 2) {
    //   Get.toNamed(Routes.scannerRoute);
    // }
    _index = index;

    notifyListeners();
  }

  // Customer Bottom Navigation Items Data
  final Map<Widget, String> _customerBottomNavItems = {
    const HomeView(): AppIcons.homeIcon,
    const ProgressView(): AppIcons.progressIcon,
    const ScannerView(): AppIcons.scannerIcon,
    const FavouriteView(): AppIcons.favouriteIcon,
    const CustomerRecentOrdersView(): AppIcons.cart1Icon,
  };

  List<Widget> get _customerPages =>
      _customerBottomNavItems.entries.map((e) => e.key).toList();
  List<Widget> get customerPages => _customerPages;

  List<String> get _customerIcons =>
      _customerBottomNavItems.entries.map((e) => e.value).toList();
  List<String> get customerIcons => _customerIcons;

  // Business Bottom Navigation Items Data
  final Map<Widget, String> _businessBottomNavItems = {
    const BusinessRecentOrdersView(): AppIcons.recentIcon,
    const TotalSalesView(): AppIcons.progress2Icon,
    const RequestedOrdersView(): AppIcons.requestIcon,
    const TotalCommission(): AppIcons.progressIcon,
    const BusinessProgresView(): AppIcons.businessIcon,
  };

  List<Widget> get _businessPages =>
      _businessBottomNavItems.entries.map((e) => e.key).toList();
  List<Widget> get businessPages => _businessPages;

  List<String> get _businessIcons =>
      _businessBottomNavItems.entries.map((e) => e.value).toList();
  List<String> get businessIcons => _businessIcons;
}
