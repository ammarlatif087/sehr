import 'package:flutter/material.dart';

import '../../src/index.dart';

class GetButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          getProportionateScreenWidth(319),
          getProportionateScreenHeight(63),
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: ColorManager.secondary,
        shape: const StadiumBorder(),
      ),
    );
  }

  static TextButtonThemeData textButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        foregroundColor: ColorManager.black,
        textStyle: TextStyleManager.regularTextStyle(
          fontSize: getProportionateScreenHeight(24),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlineButtonTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.light
        ? OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.amber,
              foregroundColor: Colors.black87,
            ),
          )
        : OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white70,
            ),
          );
  }

  static ButtonThemeData appButtonTheme() {
    return ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.textGrey,
      splashColor: ColorManager.primaryLight,
    );
  }
}
