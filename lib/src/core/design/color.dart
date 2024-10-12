// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AppColor {
  static _PrimaryColor primaryColor = _PrimaryColor();
  static _SecondaryColor secondaryColor = _SecondaryColor();
  static _SuccessColor successColor = _SuccessColor();
  static _ErrorColor errorColor = _ErrorColor();
  static _InfoColor infoColor = _InfoColor();
  static _NeutralColor neutralColor = _NeutralColor();
}

class _PrimaryColor {
  Color get main => const Color(0xFF4C4DDC);
  Color get surface => const Color(0xFFF5F5FF);
  Color get border => const Color(0xFFDFE0F3);
  Color get hover => const Color(0xFF3334CC);
  Color get pressed => const Color(0xFF085885);
  Color get focus => const Color(0xFFDBDBF8);
}

class _SecondaryColor {
  Color get main => const Color(0xFFFFD33C);
  Color get surface => const Color(0xFFFFF6D8);
  Color get border => const Color(0xFFFFF0BE);
  Color get hover => const Color(0xFFD5B032);
  Color get pressed => const Color(0xFF806A1E);
  Color get focus => const Color(0xFFFFF6D8);
}

class _SuccessColor {
  Color get main => const Color(0xFF50CD89);
  Color get surface => const Color(0xFFF2FFF8);
  Color get border => const Color(0xFFC5EED8);
  Color get hover => const Color(0xFF46B277);
  Color get pressed => const Color(0xFF28593F);
  Color get focus => const Color(0xFFDCF5E7);
}

class _ErrorColor {
  Color get main => const Color(0xFFF14141);
  Color get surface => const Color(0xFFFFF2F2);
  Color get border => const Color(0xFFFAC0C0);
  Color get hover => const Color(0xFFD93A3A);
  Color get pressed => const Color(0xFF802A2A);
  Color get focus => const Color(0xFFFCD9D9);
}

class _InfoColor {
  Color get main => const Color(0xFF7239EA);
  Color get surface => const Color(0xFFF6F2FF);
  Color get border => const Color(0xFFD0BDF8);
  Color get hover => const Color(0xFF6633D1);
  Color get pressed => const Color(0xFF3F2478);
  Color get focus => const Color(0xFFE3D7FB);
}

class _NeutralColor {
  Color get shade10 => const Color(0xFFFFFFFF);
  Color get shade20 => const Color(0xFFF5F5F5);
  Color get shade30 => const Color(0xFFEDEDED);
  Color get shade40 => const Color(0xFFD6D6D6);
  Color get shade50 => const Color(0xFFC2C2C2);
  Color get shade60 => const Color(0xFF878787);
  Color get shade70 => const Color(0xFF606060);
  Color get shade80 => const Color(0xFF383838);
  Color get shade90 => const Color(0xFF403A3A);
  Color get shade100 => const Color(0xFF101010);
}
