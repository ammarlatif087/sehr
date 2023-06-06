import 'package:sehr/app/index.dart';

class TotalSaleViewModel extends ChangeNotifier {
  final commisionTextController = TextEditingController();

  int tabIndex = 0;
  void changeDuration(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
