import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/drop_down_widget.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/add_bio/apicalling.dart';

import 'dart:convert' as convert;

import '../../../common/app_button_widget.dart';
import '../../../src/index.dart';

class AddBusinessDetailsView extends StatefulWidget {
  const AddBusinessDetailsView({super.key});

  @override
  State<AddBusinessDetailsView> createState() => _AddBusinessDetailsViewState();
}

class _AddBusinessDetailsViewState extends State<AddBusinessDetailsView> {
  final BioApiCalls _orderApi = BioApiCalls();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {}
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;

  Future apicall() async {
    var responseofdata =
        await _orderApi.adressdetailsApi("http://3.133.0.29/api/category");
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      print(element);
      filterlist.add(element);
    });

    return datatest;
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<AuthViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(35),
                      left: getProportionateScreenWidth(25),
                    ),
                    child: InkWell(
                      onTap: () => Get.offAll(() => DrawerView(
                            pageindex: 0,
                          )),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(15),
                      ),
                      child: Container(
                        height: getProportionateScreenHeight(45),
                        width: getProportionateScreenHeight(45),
                        decoration: BoxDecoration(
                          color: ColorManager.secondaryLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(15),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ColorManager.icon,
                          size: getProportionateScreenHeight(22),
                        ),
                      ),
                    ),
                  ),
                  buildVerticleSpace(24),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Fill in your business\ndetail to get started',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(34),
                  Consumer<ProfileViewModel>(
                    builder: (context, viewModel, child) => Form(
                      key: viewModel.businessFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              controller: viewModel.businessNameTextController,
                              hintText: 'Business / Company',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business/Company name is required';
                                } else if (value.length < 3) {
                                  return 'Invalid Business/Company name';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            TextFieldWidget(
                              controller: viewModel.ownerNameTextController,
                              hintText: 'Owner Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Owner name is required';
                                } else if (value.length < 3) {
                                  return 'Invalid Owner name';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            TextFieldWidget(
                              controller:
                                  viewModel.shopKeeperMobileNoTextController,
                              hintText: 'Mobile Number',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mobile number is required';
                                } else if (value.length < 11) {
                                  return 'Invalid mobile number';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            DropDownWidget(
                                lableText: 'Category',
                                hintText: 'Select Category',
                                selectedOption:
                                    viewModel.selectedBusinessCategory,
                                dropdownMenuItems: filterlist
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem(
                                        value: value["id"].toString(),
                                        child: kTextBentonSansReg(
                                          value["title"],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChange: (value) {
                                  var _list = filterlist
                                      .where((element) =>
                                          element["id"].toString() == value)
                                      .toList();
                                  viewModel.setBusinessOption(
                                      value!, _list.first["title"]);
                                }),
                            buildVerticleSpace(20),
                            TextFieldWidget(
                              maxlines: 10,
                              controller: viewModel.descriptioncontroller,
                              hintText: 'Description About',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'description is required';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(95),
                              ),
                              child: AppButtonWidget(
                                ontap: () {
                                  viewModel.addBussinessDataAndGoNext(context);
                                  // Get.toNamed(Routes.photoSelectionRoute);
                                  // print(value.selectedProfileType);
                                },
                                text: 'Next',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
