import 'dart:convert' as convert;

import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/profile/add_bio/apicalling.dart';

import '../../common/app_button_widget.dart';
import '../../common/drop_down_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

loadingshowdialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Please Wait")
                ],
              )
            ],
          ),
        );
      });
}

class SetLocationView extends StatefulWidget {
  // final File imageFile;
  const SetLocationView({
    super.key,
    // required this.imageFile,
  });

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  final BioApiCalls _orderApi = BioApiCalls();

  bool dataloading = false;

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  //provience

  Map<String, dynamic>? provincetest;
  final List<dynamic> _list2 = [];

  List<dynamic> filterlist2 = [];
  //districts data

  Map<String, dynamic>? districtTest;
  final List<dynamic> _districtlist = [];
  List<dynamic> filterdristrict = [];

// tehsil data

  Map<String, dynamic>? tehsiltest;
  final List<dynamic> _tehsillist = [];
  List<dynamic> filtertehsil = [];
  @override
  Widget build(BuildContext context) {
    return dataloading == false
        ? Scaffold(
            body: Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Image.asset(
                    AppImages.pattern2,
                    color: ColorManager.primary.withOpacity(0.1),
                  ),
                  ChangeNotifierProvider<ProfileViewModel>(
                    create: (context) => ProfileViewModel(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopBackButtonWidget(),
                        buildVerticleSpace(20),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(27),
                          ),
                          child: kTextBentonSansMed(
                            'Set Your Location',
                            fontSize: getProportionateScreenHeight(25),
                          ),
                        ),
                        buildVerticleSpace(20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(22),
                          ),
                          child: Container(
                            // height: getProportionateScreenHeight(287),
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(22),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.05),
                                  blurRadius: getProportionateScreenHeight(15),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(11),
                                    vertical: getProportionateScreenHeight(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppIcons.pinIcon,
                                        height:
                                            getProportionateScreenHeight(33),
                                        width: getProportionateScreenHeight(33),
                                      ),
                                      buildHorizontalSpace(14),
                                      kTextBentonSansMed(
                                        'Address',
                                        fontSize:
                                            getProportionateScreenHeight(15),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(17),
                                    right: getProportionateScreenWidth(8),
                                  ),
                                  child: Consumer<ProfileViewModel>(
                                    builder: (context, viewModel, child) =>
                                        Form(
                                      key: viewModel.customerAddressFormKey,
                                      child: Column(
                                        children: [
                                          buildVerticleSpace(12),
                                          TextFieldWidget(
                                            controller:
                                                viewModel.addressTextController,
                                            hintText: 'Address',
                                            fillColor: ColorManager.lightGrey,
                                            blurRadius:
                                                getProportionateScreenHeight(3),
                                          ),
                                          buildVerticleSpace(12),
                                          DropDownWidget(
                                              bgColor: ColorManager.lightGrey,
                                              dropdownColor: ColorManager.white,
                                              blurRadius:
                                                  getProportionateScreenHeight(
                                                      3),
                                              lableText: 'Province',
                                              hintText: 'Select Your Province',
                                              selectedOption:
                                                  viewModel.selectedProvince,
                                              dropdownMenuItems: filterlist2
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                    (value) => DropdownMenuItem(
                                                      value: value["title"],
                                                      child: kTextBentonSansReg(
                                                          value["title"]),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChange: (value) async {
                                                String? data;
                                                cities = data;
                                                divisions = data;
                                                tehsils = data;
                                                var listdistrictId = filterlist2
                                                    .where((element) =>
                                                        (element["title"]
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim() ==
                                                            value
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim()))
                                                    .toList();
                                                loadingshowdialog(context);
                                                filterdristrict.clear();
                                                filterlist.clear();
                                                filtertehsil.clear();

                                                await citycall(listdistrictId
                                                    .first["id"]
                                                    .toString());

                                                viewModel.setProvince(value!);
                                                Navigator.pop(context);
                                              }),
                                          buildVerticleSpace(12),
                                          DropDownWidget(
                                              bgColor: ColorManager.lightGrey,
                                              dropdownColor: ColorManager.white,
                                              blurRadius:
                                                  getProportionateScreenHeight(
                                                      3),
                                              lableText: 'Division',
                                              hintText: 'Select Your Division',
                                              selectedOption: cities,
                                              dropdownMenuItems: filterlist
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                    (value) => DropdownMenuItem(
                                                      value: value["title"]
                                                          .toString(),
                                                      child: kTextBentonSansReg(
                                                          value["title"]
                                                              .toString()),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChange: (value) async {
                                                String? data;
                                                cities = data;
                                                cities = value;
                                                var listdistrictId = filterlist
                                                    .where((element) =>
                                                        (element["title"]
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim() ==
                                                            value
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim()))
                                                    .toList();
                                                loadingshowdialog(context);
                                                filterdristrict.clear();
                                                filtertehsil.clear();

                                                await districtsdata(
                                                    listdistrictId.first["id"]
                                                        .toString());

                                                viewModel.setCity(value!);
                                                Navigator.pop(context);
                                                //
                                              }),
                                          buildVerticleSpace(12),
                                          DropDownWidget(
                                              bgColor: ColorManager.lightGrey,
                                              dropdownColor: ColorManager.white,
                                              blurRadius:
                                                  getProportionateScreenHeight(
                                                      3),
                                              lableText: 'District',
                                              hintText: 'Select District',
                                              selectedOption: divisions,
                                              dropdownMenuItems: filterdristrict
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                    (value) => DropdownMenuItem(
                                                      value: value["title"]
                                                          .toString(),
                                                      child: kTextBentonSansReg(
                                                          value["title"]),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChange: (value) async {
                                                String? data;
                                                divisions = data;
                                                divisions = value;
                                                var listdistrictId = filterdristrict
                                                    .where((element) =>
                                                        (element["title"]
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim() ==
                                                            value
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim()))
                                                    .toList();
                                                loadingshowdialog(context);
                                                filtertehsil.clear();
                                                await tehsildata(listdistrictId
                                                    .first["id"]
                                                    .toString());

                                                viewModel.setDistrict(value!);
                                                Navigator.pop(context);
                                              }),
                                          buildVerticleSpace(12),
                                          DropDownWidget(
                                              bgColor: ColorManager.lightGrey,
                                              dropdownColor: ColorManager.white,
                                              blurRadius:
                                                  getProportionateScreenHeight(
                                                      3),
                                              lableText: 'Tehsil',
                                              hintText: 'Select Tehsil',
                                              selectedOption: tehsils,
                                              dropdownMenuItems: filtertehsil
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                    (value) => DropdownMenuItem(
                                                      value: value["title"]
                                                          .toString(),
                                                      child: kTextBentonSansReg(
                                                          value["title"]),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChange: (value) {
                                                String? data;
                                                tehsils = data;
                                                tehsils = value;
                                                viewModel.setTehsil(value!);
                                              }),
                                          buildVerticleSpace(12),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // buildVerticleSpace(50),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(118),
                          ),
                          child: Consumer<ProfileViewModel>(
                            builder: (context, value, child) => AppButtonWidget(
                              ontap: () {
                                // Get.toNamed(Routes.verificationCodeRoute);

                                // value.registerMultiPartApi(context);
                                value.addUserAddressAndGoNext(context);
                              },
                              text: 'Next',
                            ),
                          ),
                        ),
                        buildVerticleSpace(50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  String? cities;
  String? citiesdemo;
  String? tehsils;
  String? divisions;

  Future citycall(String id) async {
    filterlist.clear();
    var responseofdata = await _orderApi
        .adressdetailsApi("http://3.133.0.29/api/divisions?provinceId=$id");

    datatest = convert.jsonDecode(responseofdata.body);
    _list.clear();
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  fetchorders() async {
    await proviencecall();

    dataloading = true;
    setState(() {});
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  Future proviencecall() async {
    var responseofdata =
        await _orderApi.adressdetailsApi("http://3.133.0.29/api/proviences");
    provincetest = convert.jsonDecode(responseofdata.body);
    _list2.add(provincetest == null ? [] : provincetest!.values.toList());
    _list2[0][0].forEach((element) {
      filterlist2.add(element);
    });

    return provincetest;
  }

  Future tehsildata(String districtid) async {
    var responseofdata = await _orderApi.adressdetailsApi(
        "http://3.133.0.29/api/divisions/$districtid/district/$districtid/tehsils");

    tehsiltest = convert.jsonDecode(responseofdata.body);
    _tehsillist.clear();
    _tehsillist.add(tehsiltest == null ? [] : tehsiltest!.values.toList());
    _tehsillist[0][0].forEach((element) {
      filtertehsil.add(element);
    });

    return tehsiltest;
  }

  Future districtsdata(String divisionid) async {
    var responseofdata = await _orderApi.adressdetailsApi(
        "http://3.133.0.29/api/divisions/$divisionid/district");
    districtTest = convert.jsonDecode(responseofdata.body);
    _districtlist.clear();
    _districtlist
        .add(districtTest == null ? [] : districtTest!.values.toList());
    _districtlist[0][0].forEach((element) {
      filterdristrict.add(element);
    });

    return districtTest;
  }
}
