import 'package:sehr/app/index.dart';

import '../../src/index.dart';

class PayementViewModel extends ChangeNotifier {
  PaymentType? paymentType;
  List<PaymentType> paymentTypeList = [
    PaymentType.easyPaisa,
    PaymentType.visa,
    PaymentType.jazzCash,
  ];

  final Map<String, String> _paymentNumber = {
    AppImages.easypaisa: '2121 6352 8465 ****',
    AppImages.visa: '2121 6352 8465 ****',
    AppImages.jazzCash: '2121 6352 8465 ****',
  };
  List<String> get paymentImages => [..._paymentNumber.keys];
  List<String> get paymentNumber => [..._paymentNumber.values];

  void selecPayment(PaymentType type) {
    paymentType = type;
    notifyListeners();
  }
}
