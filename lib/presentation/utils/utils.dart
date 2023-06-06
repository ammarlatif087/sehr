import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/src/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static fieldFocusChange(
    BuildContext context,
    FocusNode currentNode,
    FocusNode nextNode,
  ) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  static snackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorManager.error,
        content: Text(message),
      ),
    );
  }

  static toastMessage(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: ColorManager.error,
      textColor: ColorManager.textGrey,
    );
  }

  static flushBarErrorMessage(BuildContext context, String message) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10),
        ),
        padding: EdgeInsets.all(getProportionateScreenHeight(10)),
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(6)),
        duration: const Duration(seconds: 3),
        message: message,
      )..show(context),
    );
  }

  static const String KEY = "IMAGE_KEY";

  static Future<String?> getImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY);
  }

  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY, value);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
