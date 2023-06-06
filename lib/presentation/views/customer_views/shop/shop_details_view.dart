import 'package:sehr/core/mapscreen/MapScreen.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/views/customer_views/shop/ButtonContact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../app/index.dart';

import '../../../../domain/models/business_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

// ignore: must_be_immutable
class ShopDetailsView extends StatefulWidget {
  BusinessModel businessModel;
  ShopDetailsView({
    required this.businessModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ShopDetailsView> createState() => _ShopDetailsViewState();
}

class _ShopDetailsViewState extends State<ShopDetailsView> {
  var getxcontroller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return getxcontroller.postloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                // color: ColorManager.white,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: Image.network(
                          widget.businessModel.logo.toString(),
                          errorBuilder: (context,
                                  e,
                                  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                                  StackTrace) =>
                              Image.asset(AppImages.menu),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: SizeConfig.screenHeight * 0.55,
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                getProportionateScreenHeight(30)),
                            topRight: Radius.circular(
                                getProportionateScreenHeight(30)),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(30),
                                  vertical: getProportionateScreenHeight(40),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomChipWidget(text: 'Popular'),
                                    GestureDetector(
                                      onTap: () {
                                        widget.businessModel.isFavourite != true
                                            ? getxcontroller.addToFavourite(
                                                widget.businessModel.id)
                                            : getxcontroller
                                                .deleteFromFavourite(
                                                    widget.businessModel.id);
                                        var bools =
                                            widget.businessModel.isFavourite ==
                                                    true
                                                ? false
                                                : true;
                                        // getxcontroller.toggleFav(
                                        //     filterbussinessshops![index].id
                                        //         as int,
                                        //     filterbussinessshops![index]
                                        //         .isFavourite as bool);
                                        widget.businessModel.isFavourite =
                                            bools;
                                        for (var business
                                            in getxcontroller.business) {
                                          if (widget.businessModel.id ==
                                              business.id) {
                                            business.isFavourite = bools;
                                          }
                                        }
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius:
                                            getProportionateScreenHeight(17),
                                        backgroundColor:
                                            ColorManager.error.withOpacity(0.1),
                                        child: Icon(
                                          widget.businessModel.isFavourite ==
                                                  true
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: ColorManager.errorLight,
                                          size:
                                              getProportionateScreenHeight(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildVerticleSpace(20),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(33),
                                  vertical: getProportionateScreenHeight(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kTextBentonSansMed(
                                      '${widget.businessModel.businessName}',
                                      fontSize:
                                          getProportionateScreenHeight(27),
                                    ),
                                    buildVerticleSpace(20),
                                    Row(
                                      children: [
                                        kTextBentonSansMed(
                                          'Sehr Code : ',
                                        ),
                                        kTextBentonSansMed(
                                          widget.businessModel.sehrCode
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    buildVerticleSpace(20),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: ColorManager.primaryLight,
                                        ),
                                        buildHorizontalSpace(13),
                                        kTextBentonSansReg(
                                          '${widget.businessModel.distance?.toStringAsFixed(2)} Km',
                                          color: ColorManager.textGrey
                                              .withOpacity(0.2),
                                        ),
                                      ],
                                    ),
                                    buildVerticleSpace(25),
                                    SizedBox(
                                      height: getProportionateScreenHeight(88),
                                      child: kTextBentonSansMed(
                                        widget.businessModel.about.toString(),
                                        height: 1.5,
                                        maxLines: 4,
                                        overFlow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    buildVerticleSpace(40),
                                    Row(
                                      children: [
                                        AppButtonWidget(
                                          ontap: () {
                                            contactusdialog(
                                                context,
                                                widget.businessModel.mobile
                                                    .toString());
                                          },
                                          height:
                                              getProportionateScreenHeight(26),
                                          width:
                                              getProportionateScreenWidth(72),
                                          borderRadius:
                                              getProportionateScreenHeight(18),
                                          text: 'Contact',
                                          textSize:
                                              getProportionateScreenHeight(12),
                                          letterSpacing:
                                              getProportionateScreenWidth(0.5),
                                        ),
                                        const Spacer(),
                                        AppButtonWidget(
                                          ontap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapDirection(
                                                        phonenumber: widget
                                                            .businessModel
                                                            .mobile
                                                            .toString(),
                                                        shopname: widget
                                                            .businessModel
                                                            .businessName
                                                            .toString(),
                                                        destLatitude:
                                                            double.parse(widget
                                                                .businessModel
                                                                .lat
                                                                .toString()),
                                                        destLongitude:
                                                            double.parse(widget
                                                                .businessModel
                                                                .lon
                                                                .toString()),
                                                      )),
                                            );
                                          },
                                          height:
                                              getProportionateScreenHeight(26),
                                          width:
                                              getProportionateScreenWidth(115),
                                          borderRadius:
                                              getProportionateScreenHeight(18),
                                          text: 'GO to Shop ↗',
                                          textSize:
                                              getProportionateScreenHeight(12),
                                          letterSpacing:
                                              getProportionateScreenWidth(0.5),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

contactusdialog(BuildContext context, String phone) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Contact Shop",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  "For further questions, contact using our contact Phone."),
              const SizedBox(
                height: 15,
              ),
              ButtonContact(
                  title: phone,
                  onPressed: () {
                    UrlLauncher.launch("tel://$phone");
                  },
                  color: HexColor.fromHex('#15BE77')),
              Container(),
            ],
          ),
        );
      });
}
