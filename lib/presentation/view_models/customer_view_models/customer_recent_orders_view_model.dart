import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

class CustomerRecentOrdersViewModel extends ChangeNotifier {
  final List<CustomerRecentOrdersModel> _orders = [
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CustomerRecentOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
  ];

  List<CustomerRecentOrdersModel> get orders => [..._orders];
}
