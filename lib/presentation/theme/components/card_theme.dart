import 'package:flutter/material.dart';

import '../../src/index.dart';

CardTheme getCardTheme() {
  return CardTheme(
    color: ColorManager.elevationColor,
    shadowColor: ColorManager.grey,
    elevation: AppSize.s50,
  );
}
