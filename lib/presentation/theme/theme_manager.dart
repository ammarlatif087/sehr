import 'package:flutter/material.dart';

import '../src/index.dart';
import 'components/index.dart';

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    primaryColor: ColorManager.primary,
    // brightness: Brightness.light,
    // primaryColorDark: ColorManager.darkPrimary,
    // primaryColorLight: ColorManager.primaryOpacity70,
    // disabledColor: ColorManager.grey1,
    // splashColor: ColorManager.primaryOpacity70,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.secondary, // accent color
    ),
    fontFamily: AppFontFamiy.bentonSans,
    textTheme: getTextTheme(context),
    appBarTheme: getAppBarTheme(),
    cardTheme: getCardTheme(),
    // buttonTheme: GetButtonTheme.appButtonTheme(),
    textButtonTheme: GetButtonTheme.textButtonThemeData(),
    elevatedButtonTheme: GetButtonTheme.elevatedButtonTheme(),
    // inputDecorationTheme: getInputDecoration(),
  );
}
