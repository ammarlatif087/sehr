
import '../../app/index.dart';

class ShopDataModel extends ChangeNotifier {
  final String shopImage;
  final String shopName;
  final String shopCategory;
  final String shopDescription;
  bool isFavourite;

  ShopDataModel({
    required this.shopImage,
    required this.shopName,
    required this.shopCategory,
    required this.shopDescription,
    this.isFavourite = false,
  });

//   // void toggleFav() {
//   //   isFavourite = !isFavourite;
//   //   notifyListeners();
//   // }
}

class CustomerRecentOrdersModel {
  final String itemName;
  final String shopName;
  final double price;
  bool isFavourite;

  CustomerRecentOrdersModel({
    required this.itemName,
    required this.shopName,
    required this.price,
    this.isFavourite = false,
  });
}

class BusinessRecentOrdersModel {
  final String customerName;
  final String shopName;
  final double price;
  bool isCompleted;

  BusinessRecentOrdersModel({
    required this.customerName,
    required this.shopName,
    required this.price,
    this.isCompleted = false,
  });
}

class RequestedOrdersModel {
  final String customerName;
  final String shopName;
  final double price;
  bool isAccept;
  bool isReject;

  RequestedOrdersModel({
    required this.customerName,
    required this.shopName,
    required this.price,
    this.isAccept = false,
    this.isReject = false,
  });
}
