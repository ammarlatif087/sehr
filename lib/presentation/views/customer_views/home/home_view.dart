import 'dart:async';

import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/business_model.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';

import 'package:sehr/presentation/view_models/customer_view_models/home_view_model.dart';

import '../../../common/custom_chip_widget.dart';
import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';
import '../shop/shop_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  List<BusinessModel>? filterbussinessshops = [];
  List<String> searchlist = ["1"];
  var getxcontroller = Get.put(AppController());
  List<dynamic> filterlisttype = [];
  List sekectedfilter = [];
  bool setdata = false;
  @override
  void initState() {
    // fetchorders();
    dataListener();

    // TODO: implement initState
    super.initState();
  }

  late bool isloaded = getxcontroller.business.isEmpty ? false : true;
  int seconds = 0;
  bool noshop = false;

  dataListener() {
    Timer.periodic(const Duration(milliseconds: 1), (timers) async {
      if (mounted) {
        if (getxcontroller.business.isEmpty) {
          seconds++;
          if (seconds == 10000) {
            if (mounted) {
              setState(() {
                isloaded = true;
                noshop = true;
                timers.cancel();
              });
            }
          }
        } else {
          if (getxcontroller.filterlistFavo.isNotEmpty) {
            for (var business in getxcontroller.business) {
              for (var favBusiness in getxcontroller.filterlistFavo) {
                if (favBusiness["businessId"] == business.id) {
                  business.isFavourite = true;
                }
              }
            }
            getxcontroller.filterlistFavo.clear();
          }
          filterbussinessshops = getxcontroller.business;

          if (mounted) {
            setState(() {
              isloaded = true;
            });
          }

          timers.cancel();
        }
      }
    });
  }

  Map<String, dynamic>? datatest;

  // List<dynamic> _liste = [];
  // List<dynamic> filterlist = [];
  // List<BusinessModel> favlist = [];
  // fetchorders() async {
  //   filterlist = await apicall();
  //   if (filterlist.isEmpty) {
  //     nodata = true;
  //   } else {
  //     for (var business in getxcontroller.business) {
  //       for (var favBusiness in filterlist) {
  //         if (favBusiness["businessId"] == business.id) {
  //           business.isFavourite = true;
  //         }
  //       }
  //     }
  //     favlist = getxcontroller.business
  //         .where((business) => business.isFavourite == true)
  //         .toList();
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // bool nodata = false;
  // fetchFav() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   var tokenofmy = prefs.get('accessToken').toString();

  //   final uri = Uri.parse('http://3.133.0.29/api/user/favorites');
  //   final headers = {'accept': '*/*', 'Authorization': 'Bearer $tokenofmy'};

  //   var response = await http.get(uri, headers: headers);

  //   return response;
  // }

  // Future apicall() async {
  //   var responseofdata = await fetchFav();
  //   _liste = convert.jsonDecode(responseofdata.body);
  //   return _liste;
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getxcontroller.postloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isloaded == true
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(23),
                        vertical: getProportionateScreenHeight(13),
                      ),
                      child: Column(
                        children: [
                          // const SearchRow(),
                          Row(
                            children: [
                              _buildSearchField(_controller, (a) {
                                if (mounted) {
                                  setState(() {
                                    filterbussinessshops = getxcontroller
                                        .business
                                        .where((element) => (element
                                            .businessName
                                            .toString()
                                            .toLowerCase()
                                            .trim()
                                            .contains(_controller.text
                                                .toString()
                                                .toLowerCase()
                                                .trim())))
                                        .toList();
                                    if (filterbussinessshops!.isEmpty) {
                                      searchlist.clear();
                                    } else {
                                      searchlist.add("1");
                                    }
                                  });
                                }
                              }),
                              const Spacer(),
                              PopupMenuButton(
                                offset: Offset(
                                  getProportionateScreenWidth(0),
                                  getProportionateScreenHeight(50),
                                ),
                                padding: EdgeInsets.zero,
                                icon: Container(
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenHeight(50),
                                  padding: EdgeInsets.all(
                                    getProportionateScreenHeight(13),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorManager.secondaryLight
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenHeight(15),
                                    ),
                                  ),
                                  child: Image.asset(
                                    AppIcons.filterIcon,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                itemBuilder: (context) {
                                  return ["1'sKM", "5'sKM", "15'sKM"]
                                      .map(
                                        (e) => PopupMenuItem(
                                            child: Text(e),
                                            onTap: () async {
                                              String ramge = e == "1'sKM"
                                                  ? "100"
                                                  : e == "5'sKM"
                                                      ? "500"
                                                      : "10000";

                                              if (mounted) {
                                                setState(() {
                                                  filterbussinessshops =
                                                      getxcontroller
                                                          .business
                                                          .where((element) =>
                                                              (element
                                                                      .distance!
                                                                      .truncate() <
                                                                  int.parse(
                                                                      ramge)))
                                                          .toList();
                                                  if (filterbussinessshops!
                                                      .isEmpty) {
                                                    noshop = true;
                                                  } else {
                                                    noshop = false;
                                                  }
                                                });
                                              }
                                            }),
                                      )
                                      .toList();
                                },
                              ),
                            ],
                          ),
                          buildVerticleSpace(12),
                          // Row(
                          //   children: viewModel.selectedFilters
                          //       .map(
                          //         (filter) => Padding(
                          //           padding: EdgeInsets.only(
                          //             right: getProportionateScreenWidth(10),
                          //           ),
                          //           child: Chip(
                          //             backgroundColor: ColorManager.secondaryLight
                          //                 .withOpacity(0.15),
                          //             deleteIconColor: ColorManager.icon,
                          //             padding: EdgeInsets.only(
                          //               left: getProportionateScreenWidth(20),
                          //             ),
                          //             labelPadding: EdgeInsets.zero,
                          //             label: kTextBentonSansMed(
                          //               filter,
                          //               fontSize: getProportionateScreenHeight(12),
                          //               color: ColorManager.icon,
                          //             ),
                          //             deleteIcon: Icon(
                          //               Icons.close,
                          //               size: getProportionateScreenHeight(16),
                          //             ),
                          //             onDeleted: () {
                          //               viewModel.selectFilter(filter);
                          //             },
                          //           ),
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomChipWidget(text: 'Popular'),
                          ),
                        ],
                      ),
                    ),
                    noshop != false
                        ? Container(
                            child: const Center(
                                child: Text(
                              "No Shop NearBy Found",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )
                        : searchlist.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 600,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Center(
                                      child: Text(
                                        "No search keywords Found",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(24),
                                    ),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: filterbussinessshops!.length,
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
                                                businessModel:
                                                    filterbussinessshops![
                                                        index]),
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: CustomListTileWidget(
                                          leading: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(
                                              filterbussinessshops![index]
                                                  .logo
                                                  .toString(),
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
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              kTextBentonSansMed(
                                                "${filterbussinessshops![index].businessName}",
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        15),
                                                overFlow: TextOverflow.ellipsis,
                                              ),
                                              // buildVerticleSpace(3),
                                              kTextBentonSansReg(
                                                filterbussinessshops![index]
                                                        .district ??
                                                    "Candy",
                                                color: ColorManager.textGrey
                                                    .withOpacity(0.8),
                                                letterSpacing:
                                                    getProportionateScreenWidth(
                                                        0.5),
                                              ),
                                              // buildVerticleSpace(3),
                                              kTextBentonSansReg(
                                                '${double.parse("${filterbussinessshops![index].distance}").toStringAsFixed(2)}km away',
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
                                                onTap: () {
                                                  filterbussinessshops![index]
                                                              .isFavourite !=
                                                          true
                                                      ? getxcontroller
                                                          .addToFavourite(
                                                              filterbussinessshops![
                                                                      index]
                                                                  .id)
                                                      : getxcontroller
                                                          .deleteFromFavourite(
                                                              filterbussinessshops![
                                                                      index]
                                                                  .id);
                                                  var bools =
                                                      filterbussinessshops![
                                                                      index]
                                                                  .isFavourite ==
                                                              true
                                                          ? false
                                                          : true;
                                                  // getxcontroller.toggleFav(
                                                  //     filterbussinessshops![index].id
                                                  //         as int,
                                                  //     filterbussinessshops![index]
                                                  //         .isFavourite as bool);
                                                  filterbussinessshops![index]
                                                      .isFavourite = bools;
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                },
                                                splashColor:
                                                    ColorManager.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    getProportionateScreenHeight(
                                                        2),
                                                  ),
                                                  child: Icon(
                                                      filterbussinessshops![
                                                                  index]
                                                              .isFavourite!
                                                          ? Icons
                                                              .favorite_rounded
                                                          : Icons
                                                              .favorite_border_rounded,
                                                      size:
                                                          getProportionateScreenHeight(
                                                              20),
                                                      color:
                                                          ColorManager.error),
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
                                              //       builder: (ctx) => ShopDetailsView(
                                              //           businessModel:
                                              //               filterbussinessshops![
                                              //                   index]),
                                              //     ).then((value) {
                                              //       setState(() {});
                                              //     });
                                              //   },
                                              //   height:
                                              //       getProportionateScreenHeight(
                                              //           30),
                                              //   width:
                                              //       getProportionateScreenWidth(
                                              //           70),
                                              //   text: 'Detail',
                                              //   textSize:
                                              //       getProportionateScreenHeight(
                                              //           10),
                                              //   letterSpacing:
                                              //       getProportionateScreenWidth(
                                              //           0.5),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ],
                )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
    });
  }

  Widget _buildFilterButton(BuildContext context, HomeViewModel viewModel) {
    return PopupMenuButton(
      offset: Offset(
        getProportionateScreenWidth(0),
        getProportionateScreenHeight(50),
      ),
      padding: EdgeInsets.zero,
      icon: Container(
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
        child: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      itemBuilder: (context) {
        return viewModel.filterList
            .map(
              (e) => PopupMenuItem(
                child: Text(e),
                onTap: () => viewModel.selectFilter(e),
              ),
            )
            .toList();
      },
    );
  }

  Widget _buildSearchField(TextEditingController controller, function(e)) {
    return TextFormField(
      onChanged: function,
      controller: controller,
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

// class SearchRow extends StatelessWidget {
//   const SearchRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildSearchField(),
//         const Spacer(),
//         _buildFilterButton(context),
//       ],
//     );
//   }

// }
