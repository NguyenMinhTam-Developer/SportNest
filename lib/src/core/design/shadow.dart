import 'package:flutter/material.dart';

class AppShadow {
  static BoxShadow softShadow = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.04),
    blurRadius: 60,
    spreadRadius: 0,
    offset: const Offset(0, 6),
  );

  static BoxShadow dropShadow = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.06),
    blurRadius: 40,
    spreadRadius: 0,
    offset: const Offset(0, 0),
  );
}
