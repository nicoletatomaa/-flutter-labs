import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Culorile din Figma (Primary / Greyscale / Alert).
class AppColors {
  static const primary = Color(0xFF22C55E); // Primary/500
  static const primary50 = Color(0xFFE9F9EF); // Primary/50
  static const grey900 = Color(0xFF0D0D12);
  static const grey700 = Color(0xFF272835);
  static const grey400 = Color(0xFF818898);
  static const grey300 = Color(0xFFA4ACB9);
  static const grey200 = Color(0xFFC1C7D0);
  static const grey100 = Color(0xFFDFE1E7);
  static const grey25 = Color(0xFFF6F8FA);
  static const white = Color(0xFFFFFFFF);
  static const error = Color(0xFFDF1C41); // punctul roșu de la clopoțel
  static const warning = Color(0xFFFFBE4C); // steaua de rating
}

/// Stilurile de text din Figma (font: Plus Jakarta Sans).
/// letter-spacing -0.02em din Figma => size * -0.02.
class AppText {
  static TextStyle _s(
    double size,
    FontWeight weight,
    Color color, {
    double height = 1.55,
    bool tight = true,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: tight ? size * -0.02 : 0,
    );
  }

  // Heading
  static TextStyle h4({Color color = AppColors.grey900}) =>
      _s(24, FontWeight.w700, color, height: 1.5, tight: false);
  static TextStyle h6({Color color = AppColors.grey900}) =>
      _s(18, FontWeight.w700, color, height: 1.4, tight: false);

  // Body
  static TextStyle bodyLargeSemibold({Color color = AppColors.grey900}) =>
      _s(18, FontWeight.w600, color, tight: false);
  static TextStyle bodyMediumSemibold({Color color = AppColors.grey900}) =>
      _s(16, FontWeight.w600, color);
  static TextStyle bodySmallRegular({Color color = AppColors.grey400}) =>
      _s(14, FontWeight.w400, color);
  static TextStyle bodySmallMedium({Color color = AppColors.grey400}) =>
      _s(14, FontWeight.w500, color);
  static TextStyle bodySmallSemibold({Color color = AppColors.grey900}) =>
      _s(14, FontWeight.w600, color);
  static TextStyle bodyXSmallRegular({Color color = AppColors.white}) =>
      _s(12, FontWeight.w400, color);
  static TextStyle bodyXSmallMedium({Color color = AppColors.white}) =>
      _s(12, FontWeight.w500, color);
  static TextStyle bodyXSmallSemibold({Color color = AppColors.white}) =>
      _s(12, FontWeight.w600, color);

  // "210 kcl" / "120 min"
  static TextStyle caption({Color color = AppColors.grey200}) =>
      _s(11, FontWeight.w600, color);
}
