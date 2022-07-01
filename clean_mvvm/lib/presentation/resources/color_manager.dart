import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#ed9728");
  static Color darkGray = HexColor.fromHex("#525252");
  static Color gray = HexColor.fromHex("#737477");
  static Color lightGray = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color gray1 = HexColor.fromHex("#707070");
  static Color gray2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#ffffff");
  static Color error = HexColor.fromHex("#e61f34"); //red
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      // 8 char with opacity 100%
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
