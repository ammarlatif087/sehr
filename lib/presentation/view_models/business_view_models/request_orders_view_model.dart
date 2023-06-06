import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

class RequestedOrdersViewModel extends ChangeNotifier {
  final List<RequestedOrdersModel> _requestedOrders = [
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
      isAccept: false,
      isReject: false,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
      isAccept: false,
      isReject: false,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    RequestedOrdersModel(
      customerName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
  ];
  List<RequestedOrdersModel> get requestedOrders => [..._requestedOrders];
}
