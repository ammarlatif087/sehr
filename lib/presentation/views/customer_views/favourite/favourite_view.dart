import 'dart:async';

import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/business_model.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;
import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';
import "package:http/http.dart" as http;

import '../shop/shop_details_view.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  var getxcontroller = Get.put(AppController());
  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  Map<String, dynamic>? datatest;

  List<dynamic> _liste = [];
  List<dynamic> filterlist = [];
  List<BusinessModel> favlist = [];
  fetchorders() async {
    filterlist = await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      for (var business in getxcontroller.business) {
        for (var favBusiness in filterlist) {
          if (favBusiness["businessId"] == business.id) {
            business.isFavourite = true;
          }
        }
      }
      favlist = getxcontroller.business
          .where((business) => business.isFavourite == true)
          .toList();
    }
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;
  fetchFav() async {
    final prefs = await SharedPreferences.getInstance();

    var tokenofmy = prefs.get('accessToken').toString();

    final uri = Uri.parse('http://3.133.0.29/api/user/favorites');
    final headers = {'accept': '*/*', 'Authorization': 'Bearer $tokenofmy'};

    var response = await http.get(uri, headers: headers);

    return response;
  }

  Future apicall() async {
    var responseofdata = await fetchFav();
    _liste = convert.jsonDecode(responseofdata.body);
    return _liste;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return getxcontroller.postloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: getProportionateScreenWidth(23),
                  //     vertical: getProportionateScreenHeight(13),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       _buildSearchField(),
                  //       const Spacer(),
                  //       _buildFilterButton(),
                  //     ],
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: getProportionateScreenWidth(40),
                  //       vertical: getProportionateScreenHeight(10),
                  //     ),
                  //     child: kTextBentonSansReg(
                  //       'Favorite',
                  //       fontSize: getProportionateScreenHeight(15),
                  //     ),
                  //   ),
                  // ),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(17),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        kTextBentonSansReg(
                          "Favorites",
                          fontSize: getProportionateScreenHeight(27),
                        ),
                      ],
                    ),
                  ),
                  buildVerticleSpace(20),
                  // buildVerticleSpace(10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(24),
                          ),
                          child: nodata == true
                              ? Container(
                                  child: const Text(
                                  "No Favourite Shop",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                              : favlist.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: favlist.length,
                                      separatorBuilder: (context, index) =>
                                          buildVerticleSpace(10),
                                      padding: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(100),
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor:
                                                ColorManager.transparent,
                                            builder: (ctx) => ShopDetailsView(
                                              businessModel: favlist[index],
                                            ),
                                          );
                                        },
                                        child: CustomListTileWidget(
                                          leading: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(
                                              favlist[index].logo.toString(),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context,
                                                      e,
                                                      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                                                      StackTrace) =>
                                                  Image.asset(AppImages.menu),
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          // Image.asset(viewModel.favItems[index].shopImage),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              kTextBentonSansMed(
                                                favlist[index]
                                                    .businessName
                                                    .toString(),
                                                overFlow: TextOverflow.ellipsis,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        15),
                                              ),
                                              // buildVerticleSpace(3),
                                              kTextBentonSansReg(
                                                favlist[index].district ??
                                                    "Candy",
                                                color: ColorManager.textGrey
                                                    .withOpacity(0.8),
                                                letterSpacing:
                                                    getProportionateScreenWidth(
                                                        0.5),
                                              ),
                                              // buildVerticleSpace(3),
                                              kTextBentonSansReg(
                                                '${double.parse("${favlist[index].distance}").toStringAsFixed(2)}km away',
                                                color: ColorManager.textGrey
                                                    .withOpacity(0.8),
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        10),
                                                letterSpacing:
                                                    getProportionateScreenWidth(
                                                        0.5),
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            children: [
                                              InkWell(
                                                // onTap: () => viewModel.toggleFav(index),
                                                splashColor:
                                                    ColorManager.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Icon(
                                                  Icons.favorite_rounded,
                                                  size:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  color: ColorManager.error,
                                                ),
                                              ),
                                              // const Spacer(),
                                              // AppButtonWidget(
                                              //   ontap: () {
                                              //     showModalBottomSheet(
                                              //       context: context,
                                              //       isScrollControlled: true,
                                              //       backgroundColor:
                                              //           ColorManager.transparent,
                                              //       builder: (ctx) =>
                                              //           ShopDetailsView(
                                              //         businessModel:
                                              //             favlist[index],
                                              //       ),
                                              //     );

                                              //   },
                                              //   height:
                                              //       getProportionateScreenHeight(
                                              //           26),
                                              //   width:
                                              //       getProportionateScreenWidth(
                                              //           72),
                                              //   borderRadius:
                                              //       getProportionateScreenHeight(
                                              //           9),
                                              //   text: 'Detail',
                                              //   textSize:
                                              //       getProportionateScreenHeight(
                                              //           12),
                                              //   letterSpacing:
                                              //       getProportionateScreenWidth(
                                              //           0.5),
                                              // ),
                                              // buildVerticleSpace(5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      height: getProportionateScreenHeight(50),
      width: getProportionateScreenHeight(50),
      padding: EdgeInsets.all(
        getProportionateScreenHeight(13),
      ),
      decoration: BoxDecoration(
        color: ColorManager.secondaryLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(15),
        ),
      ),
      child: IconButton(
        splashColor: ColorManager.transparent,
        splashRadius: getProportionateScreenHeight(30),
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.secondaryLight.withOpacity(0.1),
        constraints: BoxConstraints(
          maxHeight: getProportionateScreenHeight(50),
          maxWidth: getProportionateScreenWidth(280),
        ),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(15),
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(18),
            vertical: getProportionateScreenHeight(13),
          ),
          child: Image.asset(AppIcons.searchIcon),
        ),
        hintText: 'What do you want to order?',
        hintStyle: TextStyleManager.regularTextStyle(
          color: ColorManager.icon.withOpacity(0.4),
          fontSize: getProportionateScreenHeight(12),
        ),
      ),
    );
  }
}
