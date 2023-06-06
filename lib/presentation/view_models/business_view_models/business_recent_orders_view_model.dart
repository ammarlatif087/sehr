import 'package:sehr/app/index.dart';

import '../../../domain/models/models.dart';

class BusinessRecentOrdersViewModel extends ChangeNotifier {
  final List<BusinessRecentOrdersModel> _recentOrders = [
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    BusinessRecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
  ];
  List<BusinessRecentOrdersModel> get recentOrders => [..._recentOrders];
}
