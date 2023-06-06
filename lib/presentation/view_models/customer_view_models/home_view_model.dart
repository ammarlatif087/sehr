import 'package:geolocator/geolocator.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/models.dart';

import '../../../domain/models/business_model.dart';
import '../../../domain/models/userFavouriteBusinessModel.dart';

import '../../../domain/repository/business_repository.dart';
import '../../src/index.dart';

String? address;
Position? position;

class HomeViewModel extends ChangeNotifier {
  BusinessRepository model = BusinessRepository();

  // ignore: unused_field
  final NetworkApiService _networkApiService = NetworkApiService();
  BusinessModel businessModel = BusinessModel();
  List<UserFavouriteBusiness> listOfUserFavouriteBusiness = [];

  // final NetworkApiService _networkApiService = NetworkApiService();

  List<BusinessModel>? business = [];
  List<BusinessModel> favBusinesses = [];

  HomeViewModel() {
    init();
  }

  init() async {
    notifyListeners();
  }

  final List<ShopDataModel> _shops = [
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 1',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 4',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 5',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 6',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 7',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 8',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 9',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
  ];

  List<ShopDataModel> get shops => [..._shops];

  List<ShopDataModel> get favItems {
    // return _shops.where((element) => element.isFavourite).toList();
    return [
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 1',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
    ];
  }

  Set<String> selectedFilters = {};
  List<String> filterList = ['Filter 1', 'Filter 2', 'Filter 3'];

  void selectFilter(String value) {
    if (selectedFilters.contains(value)) {
      selectedFilters.remove(value);
    } else {
      selectedFilters.add(value);
    }
    notifyListeners();
    // print(selectedFilters);
  }

  String internererror = "";

//  final filteredData = data.where((item) => selectedFilters.contains(item.filter)).toList();

  ///    Get List of Shops
  ///
  ///
  ///h

  /// Toggle Favourite

  ///   Add Business To Favourite

  ///   Delete Business From Favourite

  ///  Get user Favourite Business
}
