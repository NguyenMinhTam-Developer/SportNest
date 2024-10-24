import 'dart:ui';

class Colors {
  /// These are the main neutral, brand and semantic colors that make up the majority of the colors used in the design system and components.
  PrimaryColors primary = PrimaryColors();

  /// Along with primary colors, it's helpful to have a selection of secondary colors to use in components such as pills, alerts and labels. These secondary colors should be used sparingly or as accents, while the primary color(s) should take precedence.
  SecondaryColors secondary = SecondaryColors();
}

class PrimaryColors {
  _BaseColor base = _BaseColor();

  /// **Base**
  ///
  /// These are base black and white color styles to quickly swap out if you need to.
  BasicColor lightGrey = BasicColor(
    shade25: const Color(0xFFFDFDFD), // AAA 7.02
    shade50: const Color(0xFFFAFAFA), // AA 6.84
    shade100: const Color(0xFFF5F5F5), // AA 6.55
    shade200: const Color(0xFFE9EAEB), // AA 5.92
    shade300: const Color(0xFFD5D7DA), // AA 4.95
    shade400: const Color(0xFFA4A7AE), // 2.40
    shade500: const Color(0xFF717680), // AA 4.56
    shade600: const Color(0xFF535862), // AAA 7.14
    shade700: const Color(0xFF414651), // AAA 9.46
    shade800: const Color(0xFF252B37), // AAA 14.19
    shade900: const Color(0xFF181D27), // AAA 16.88
    shade950: const Color(0xFF0A0D12), // AAA 19.45
  );

  /// **Gray (light mode)**
  ///
  /// Gray is a neutral color and is the foundation of the color system. Almost everything in UI design — text, form fields, backgrounds, dividers — are usually gray.
  BasicColor darkGrey = BasicColor(
    shade25: const Color(0xFFFAFAFA), // AA 5.66
    shade50: const Color(0xFFF7F7F7), // AA 5.37
    shade100: const Color(0xFFF0F0F1), // AA 5.14
    shade200: const Color(0xFFECECED), // AA 4.95
    shade300: const Color(0xFFCECFD2), // 3.75
    shade400: const Color(0xFF94979C), // 2.94
    shade500: const Color(0xFF85888E), // 3.55
    shade600: const Color(0xFF61656C), // AAA 5.85
    shade700: const Color(0xFF373A41), // AAA 11.38
    shade800: const Color(0xFF22262F), // AAA 15.14
    shade900: const Color(0xFF13161B), // AAA 18.13
    shade950: const Color(0xFF0C0E12), // AAA 19.31
  );

  /// **Gray (dark mode)**
  ///
  /// This is a separate gray color palette used specifically for dark mode. This gray has been desaturated and optimised to work well within dark mode variables.
  BasicColor brand = BasicColor(
    shade25: const Color(0xFFFCFAFF), // AA 6.38
    shade50: const Color(0xFFF9F5FF), // AA 6.15
    shade100: const Color(0xFFF4EBFF), // AA 5.72
    shade200: const Color(0xFFE9D7FE), // AA 4.92
    shade300: const Color(0xFFD6BBFB), // 3.89
    shade400: const Color(0xFFB692F6), // 2.49
    shade500: const Color(0xFF9E77ED), // 3.32
    shade600: const Color(0xFF7F56D9), // AA 4.95
    shade700: const Color(0xFF6941C6), // AA 6.61
    shade800: const Color(0xFF53389E), // AAA 8.65
    shade900: const Color(0xFF42307D), // AAA 10.76
    shade950: const Color(0xFF2C1C5F), // AAA 14.59
  );

  /// **Brand**
  ///
  /// The brand color is your "primary" color, and is used across all interactive elements such as buttons, links, inputs, etc. This color can define the overall feel and can elicit emotion.
  BasicColor error = BasicColor(
    shade25: const Color(0xFFFFFBFA), // AA 6.39
    shade50: const Color(0xFFFEF3F2), // AA 6.04
    shade100: const Color(0xFFFEE4E2), // AA 5.45
    shade200: const Color(0xFFFECDCA), // AA 4.63
    shade300: const Color(0xFFFDA29B), // 3.38
    shade400: const Color(0xFFF97066), // 2.78
    shade500: const Color(0xFFF04438), // 3.75
    shade600: const Color(0xFFD92D20), // AA 4.83
    shade700: const Color(0xFFB42318), // AA 6.57
    shade800: const Color(0xFF912018), // AAA 8.66
    shade900: const Color(0xFF7A271A), // AAA 9.84
    shade950: const Color(0xFF55160C), // AAA 13.94
  );

  /// **Error**
  ///
  /// Error colors are used across error states and in "destructive" actions. They communicate a destructive/negative action, such as removing a user from your team.
  BasicColor warning = BasicColor(
    shade25: const Color(0xFFFFFCF5), // AA 5.29
    shade50: const Color(0xFFFFFAEB), // AA 5.20
    shade100: const Color(0xFFFEF0C7), // AA 4.78
    shade200: const Color(0xFFFEDF89), // 4.16
    shade300: const Color(0xFFFEC84B), // 3.50
    shade400: const Color(0xFFFDB022), // 1.84
    shade500: const Color(0xFFF79009), // 2.34
    shade600: const Color(0xFFDC6803), // AA 3.48
    shade700: const Color(0xFFB54708), // AA 5.42
    shade800: const Color(0xFF93370D), // AAA 7.51
    shade900: const Color(0xFF7A2E0E), // AAA 9.43
    shade950: const Color(0xFF4E1D09), // AAA 13.96
  );

  /// **Warning**
  ///
  /// Warning colors can communicate that an action is potentially destructive or "on-hold". These colors are commonly used in confirmations to grab the users' attention.
  BasicColor success = BasicColor(
    shade25: const Color(0xFFF6FEF9), // AA 5.54
    shade50: const Color(0xFFECFDF3), // AA 5.39
    shade100: const Color(0xFFD1FADF), // AA 5.11
    shade200: const Color(0xFFA6F4C5), // 4.29
    shade300: const Color(0xFF6CE9A6), // 3.51
    shade400: const Color(0xFF32D583), // 2.02
    shade500: const Color(0xFF12B76A), // 2.75
    shade600: const Color(0xFF039855), // 3.90
    shade700: const Color(0xFF027A48), // AA 5.69
    shade800: const Color(0xFF05603A), // AAA 7.96
    shade900: const Color(0xFF054F31), // AAA 9.92
    shade950: const Color(0xFF053321), // AAA 13.98
  );

  /// **Success**
  ///
  /// Success colors communicate a positive action, positive trend, or a successful confirmation. If you're using green as your primary color, it can be helpful to introduce a different hue for your success green.
}

class SecondaryColors {
  /// **Gray blue**
  ///
  /// Can be swapped with the default gray color.
  BasicColor grayBlue = BasicColor(
    shade25: const Color(0xFFFCFCFD), // AAA 8.39
    shade50: const Color(0xFFF8F9FC), // AAA 8.17
    shade100: const Color(0xFFEAECF5), // AAA 7.30
    shade200: const Color(0xFFD5D9EB), // AA 6.13
    shade300: const Color(0xFFB3B8DB), // 4.42
    shade400: const Color(0xFF717BBC), // 3.99
    shade500: const Color(0xFF4E5BA6), // AA 6.22
    shade600: const Color(0xFF3E4784), // AAA 8.60
    shade700: const Color(0xFF363F72), // AAA 9.94
    shade800: const Color(0xFF293056), // AAA 12.71
    shade900: const Color(0xFF101323), // AAA 18.42
    shade950: const Color(0xFF0D0F1C), // AAA 19.05
  );

  /// **Gray cool**
  ///
  /// Can be swapped with the default gray color.
  BasicColor grayCool = BasicColor(
    shade25: const Color(0xFFFCFCFD), // AAA 7.15
    shade50: const Color(0xFFF9FAFB), // AA 6.97
    shade100: const Color(0xFFF3F3F5), // AA 6.48
    shade200: const Color(0xFFE3E8EF), // AA 5.51
    shade300: const Color(0xFFCDD5DF), // 4.03
    shade400: const Color(0xFF9AA4B2), // 3.45
    shade500: const Color(0xFF697586), // AA 5.22
    shade600: const Color(0xFF4B5565), // AAA 7.33
    shade700: const Color(0xFF364152), // AAA 8.85
    shade800: const Color(0xFF202939), // AAA 11.76
    shade900: const Color(0xFF121926), // AAA 18.41
    shade950: const Color(0xFF0C101B), // AAA 18.94
  );

  /// **Gray modern**
  ///
  /// Can be swapped with the default gray color.
  BasicColor grayModern = BasicColor(
    shade25: const Color(0xFFFCFCFD), // AAA 7.35
    shade50: const Color(0xFFF8FAFC), // AAA 7.20
    shade100: const Color(0xFFEEF2F6), // AA 6.69
    shade200: const Color(0xFFE3E8EF), // AA 6.12
    shade300: const Color(0xFFCDD5DF), // AA 5.08
    shade400: const Color(0xFF9AA4B2), // 2.52
    shade500: const Color(0xFF697586), // AA 4.67
    shade600: const Color(0xFF4B5565), // AAA 7.53
    shade700: const Color(0xFF364152), // AAA 10.32
    shade800: const Color(0xFF202939), // AAA 14.60
    shade900: const Color(0xFF121926), // AAA 17.60
    shade950: const Color(0xFF0D121C), // AAA 18.74
  );

  /// **Gray neutral**
  ///
  /// Can be swapped with the default neutral color.
  BasicColor grayNeutral = BasicColor(
    shade25: const Color(0xFFFCFCFD), // AAA 7.18
    shade50: const Color(0xFFF9FAFB), // AAA 7.04
    shade100: const Color(0xFFF3F4F6), // AA 6.69
    shade200: const Color(0xFFE5E7EB), // AA 5.94
    shade300: const Color(0xFFD2D6DB), // AA 5.04
    shade400: const Color(0xFF9DA4AE), // 2.51
    shade500: const Color(0xFF6C737F), // AA 4.77
    shade600: const Color(0xFF4D5761), // AAA 7.36
    shade700: const Color(0xFF384250), // AAA 10.17
    shade800: const Color(0xFF1F2A37), // AAA 14.53
    shade900: const Color(0xFF111927), // AAA 17.61
    shade950: const Color(0xFF0D121C), // AAA 18.74
  );

  /// **Gray iron**
  ///
  /// Can be swapped with the default neutral color.
  BasicColor grayIron = BasicColor(
    shade25: const Color(0xFFFCFCFC), // AAA 7.54
    shade50: const Color(0xFFFAFAFA), // AAA 7.42
    shade100: const Color(0xFFF4F4F5), // AAA 7.04
    shade200: const Color(0xFFE4E4E7), // AA 6.10
    shade300: const Color(0xFFD1D1D6), // AA 5.09
    shade400: const Color(0xFFA0A0AB), // 2.58
    shade500: const Color(0xFF70707B), // AA 4.89
    shade600: const Color(0xFF51525C), // AAA 7.74
    shade700: const Color(0xFF3F3F46), // AAA 10.44
    shade800: const Color(0xFF26272B), // AAA 14.92
    shade900: const Color(0xFF18181B), // AAA 17.34
    shade950: const Color(0xFF131316), // AAA 18.54
  );

  /// **Gray true**
  ///
  /// Can be swapped with the default neutral color.
  BasicColor grayTrue = BasicColor(
    shade25: const Color(0xFFFCFCFC), // AAA 7.61
    shade50: const Color(0xFFF7F7F7), // AAA 7.29
    shade100: const Color(0xFFF3F3F3), // AAA 7.16
    shade200: const Color(0xFFE5E5E5), // AA 6.20
    shade300: const Color(0xFFD6D6D6), // AA 5.37
    shade400: const Color(0xFFA3A3A3), // 2.52
    shade500: const Color(0xFF737373), // AA 4.74
    shade600: const Color(0xFF525252), // AAA 7.81
    shade700: const Color(0xFF424242), // AAA 10.04
    shade800: const Color(0xFF292929), // AAA 14.54
    shade900: const Color(0xFF141414), // AAA 18.42
    shade950: const Color(0xFF0F0F0F), // AAA 19.16
  );

  /// **Gray warm**
  ///
  /// Can be swapped with the default neutral color.
  BasicColor grayWarm = BasicColor(
    shade25: const Color(0xFFFDFDFC), // AAA 7.49
    shade50: const Color(0xFFFAFAF9), // AAA 7.30
    shade100: const Color(0xFFF5F5F4), // AA 6.99
    shade200: const Color(0xFFE7E5E4), // AA 6.088
    shade300: const Color(0xFFD7D3D0), // AA 5.12
    shade400: const Color(0xFFA9A29D), // 2.51
    shade500: const Color(0xFF79716B), // AA 4.78
    shade600: const Color(0xFF57534E), // AAA 7.62
    shade700: const Color(0xFF44403C), // AAA 10.27
    shade800: const Color(0xFF292524), // AAA 15.16
    shade900: const Color(0xFF1C1917), // AAA 17.48
    shade950: const Color(0xFF171412), // AAA 18.33
  );

  /// **Moss**
  ///
  /// Can be swapped with the default success color.
  BasicColor moss = BasicColor(
    shade25: const Color(0xFFFAFDF7), // AA 6.88
    shade50: const Color(0xFFF5FBEE), // AA 6.69
    shade100: const Color(0xFFE6F4D7), // AA 6.15
    shade200: const Color(0xFFCEEAB0), // AA 5.38
    shade300: const Color(0xFFACDC79), // AA 4.46
    shade400: const Color(0xFF86C83C), // 1.97
    shade500: const Color(0xFF669F2A), // 3.20
    shade600: const Color(0xFF4F7A21), // AA 5.05
    shade700: const Color(0xFF3F621A), // AAA 7.06
    shade800: const Color(0xFF335015), // AAA 9.13
    shade900: const Color(0xFF2B4212), // AAA 11.10
    shade950: const Color(0xFF1A280B), // AAA 15.52
  );

  /// **Green light**
  ///
  /// Can be swapped with the default success color.
  BasicColor greenLight = BasicColor(
    shade25: const Color(0xFFFAFEF5), // AA 5.04
    shade50: const Color(0xFFF3FEE7), // AA 4.94
    shade100: const Color(0xFFE4FBCC), // AA 4.64
    shade200: const Color(0xFFCDF9AB), // 4.34
    shade300: const Color(0xFFAEF667), // 3.72
    shade400: const Color(0xFF85E513), // 1.83
    shade500: const Color(0xFF66C61C), // 2.18
    shade600: const Color(0xFF4CA30D), // 3.20
    shade700: const Color(0xFF3B7C0F), // AA 5.15
    shade800: const Color(0xFF326212), // AAA 7.28
    shade900: const Color(0xFF2B5314), // AAA 8.93
    shade950: const Color(0xFF15290A), // AAA 15.51
  );

  /// **Green**
  ///
  /// Can be swapped with the default success color.
  BasicColor green = BasicColor(
    shade25: const Color(0xFFF6FEF9), // AAA 5.70
    shade50: const Color(0xFFEDFCF2), // AA 5.51
    shade100: const Color(0xFFD3F8DF), // AA 5.08
    shade200: const Color(0xFFAAF0C4), // 4.44
    shade300: const Color(0xFF73E2A3), // 3.65
    shade400: const Color(0xFF3CCB7F), // 2.09
    shade500: const Color(0xFF16B364), // 2.73
    shade600: const Color(0xFF099250), // 4.00
    shade700: const Color(0xFF087443), // AA 5.85
    shade800: const Color(0xFF095C37), // AAA 8.08
    shade900: const Color(0xFF084C2E), // AAA 10.07
    shade950: const Color(0xFF052E1C), // AAA 14.85
  );

  /// **Teal**
  ///
  /// Can be swapped with the default success color.
  BasicColor teal = BasicColor(
    shade25: const Color(0xFFF6FEFC), // AAA 5.43
    shade50: const Color(0xFFF0FDF9), // AA 5.33
    shade100: const Color(0xFFCCFBEF), // AA 4.93
    shade200: const Color(0xFF99F6E0), // 4.40
    shade300: const Color(0xFF5FE9D0), // 3.72
    shade400: const Color(0xFF2DD4BF), // 1.88
    shade500: const Color(0xFF15B79E), // 2.53
    shade600: const Color(0xFF0E9384), // 3.80
    shade700: const Color(0xFF107569), // AA 5.56
    shade800: const Color(0xFF125D56), // AAA 7.70
    shade900: const Color(0xFF134E48), // AAA 9.49
    shade950: const Color(0xFF042F2E), // AAA 15.46
  );

  /// **Cyan**
  BasicColor cyan = BasicColor(
    shade25: const Color(0xFFF5FEFF), // AA 5.48
    shade50: const Color(0xFFECFDFF), // AA 5.36
    shade100: const Color(0xFFCFF9FE), // AA 4.98
    shade200: const Color(0xFFA5F0FC), // 4.40
    shade300: const Color(0xFF67E3F9), // 3.72
    shade400: const Color(0xFF22CCEE), // 1.91
    shade500: const Color(0xFF06AED4), // 2.62
    shade600: const Color(0xFF088AB2), // 3.97
    shade700: const Color(0xFF0E7090), // AA 5.61
    shade800: const Color(0xFF155B75), // AAA 7.53
    shade900: const Color(0xFF164C63), // AAA 9.34
    shade950: const Color(0xFF083344), // AAA 14.44
  );

  /// **Blue light**
  BasicColor blueLight = BasicColor(
    shade25: const Color(0xFFF5FBFF), // AA 5.61
    shade50: const Color(0xFFF0F9FF), // AA 5.49
    shade100: const Color(0xFFE0F2FE), // AA 5.10
    shade200: const Color(0xFFB9E6FE), // 4.40
    shade300: const Color(0xFF7CD4FD), // 3.53
    shade400: const Color(0xFF36BFFA), // 2.10
    shade500: const Color(0xFF0BA5EC), // 2.76
    shade600: const Color(0xFF0086C9), // 3.99
    shade700: const Color(0xFF026AA2), // AA 5.85
    shade800: const Color(0xFF065986), // AAA 7.55
    shade900: const Color(0xFF0B4A6F), // AAA 9.44
    shade950: const Color(0xFF082F49), // AAA 14.53
  );

  /// **Blue**
  BasicColor blue = BasicColor(
    shade25: const Color(0xFFF5FAFF), // AA 5.70
    shade50: const Color(0xFFEFF8FF), // AA 5.57
    shade100: const Color(0xFFD1E9FF), // AA 4.79
    shade200: const Color(0xFFB2DDFF), // 4.18
    shade300: const Color(0xFF84CAFF), // 3.38
    shade400: const Color(0xFF53B1FD), // 2.31
    shade500: const Color(0xFF2E90FA), // 3.23
    shade600: const Color(0xFF1570EF), // AA 4.56
    shade700: const Color(0xFF175CD3), // AA 5.98
    shade800: const Color(0xFF1849A9), // AAA 8.18
    shade900: const Color(0xFF194185), // AAA 9.83
    shade950: const Color(0xFF102A59), // AAA 14.11
  );

  /// **Blue dark**
  BasicColor blueDark = BasicColor(
    shade25: const Color(0xFFF5FBFF), // AA 6.00
    shade50: const Color(0xFFEFF4FF), // AA 5.79
    shade100: const Color(0xFFD1E0FF), // AA 4.80
    shade200: const Color(0xFFB2CCFF), // 3.94
    shade300: const Color(0xFF84ADFF), // 2.85
    shade400: const Color(0xFF528BFF), // 3.23
    shade500: const Color(0xFF2970FF), // 4.32
    shade600: const Color(0xFF155EEF), // AA 5.41
    shade700: const Color(0xFF004EEB), // AA 6.38
    shade800: const Color(0xFF0040C1), // AAA 8.38
    shade900: const Color(0xFF00359E), // AAA 10.48
    shade950: const Color(0xFF002266), // AAA 14.78
  );

  /// **Indigo**
  BasicColor indigo = BasicColor(
    shade25: const Color(0xFFF5F8FF), // AAA 7.60
    shade50: const Color(0xFFEEF4FF), // AAA 7.31
    shade100: const Color(0xFFE0EAFF), // AA 6.68
    shade200: const Color(0xFFC7D7FE), // AA 5.61
    shade300: const Color(0xFFA4BCFD), // 4.30
    shade400: const Color(0xFF8098F9), // 2.70
    shade500: const Color(0xFF6172F3), // 4.03
    shade600: const Color(0xFF444CE7), // AA 6.11
    shade700: const Color(0xFF3538CD), // AAA 8.08
    shade800: const Color(0xFF2D31A6), // AAA 9.99
    shade900: const Color(0xFF2D3282), // AAA 11.11
    shade950: const Color(0xFF1F2555), // AAA 14.48
  );

  /// **Violet**
  BasicColor violet = BasicColor(
    shade25: const Color(0xFFFBFAFF), // AAA 6.96
    shade50: const Color(0xFFF5F3FF), // AA 6.59
    shade100: const Color(0xFFECE9FE), // AA 6.08
    shade200: const Color(0xFFDDD6FE), // AA 5.20
    shade300: const Color(0xFFC3B5FD), // 3.90
    shade400: const Color(0xFFA48AFB), // 2.76
    shade500: const Color(0xFF875BF7), // 4.31
    shade600: const Color(0xFF7839EE), // AA 5.80
    shade700: const Color(0xFF6927DA), // AAA 7.23
    shade800: const Color(0xFF5720B7), // AAA 9.14
    shade900: const Color(0xFF491C96), // AAA 11.11
    shade950: const Color(0xFF2E125E), // AAA 15.39
  );

  /// **Purple**
  BasicColor purple = BasicColor(
    shade25: const Color(0xFFFAFAFF), // AAA 7.41
    shade50: const Color(0xFFF4F3FF), // AAA 7.01
    shade100: const Color(0xFFEBE9FE), // AA 6.47
    shade200: const Color(0xFFD9D6FE), // AA 5.50
    shade300: const Color(0xFFBDB4FE), // 4.08
    shade400: const Color(0xFF9B8AFB), // 2.82
    shade500: const Color(0xFF7A5AF8), // AA 4.52
    shade600: const Color(0xFF6938EF), // AA 6.15
    shade700: const Color(0xFF5925DC), // AAA 7.71
    shade800: const Color(0xFF4A1FB8), // AAA 9.63
    shade900: const Color(0xFF3E1C96), // AAA 11.59
    shade950: const Color(0xFF27115F), // AAA 15.76
  );

  /// **Fuchsia**
  BasicColor fuchsia = BasicColor(
    shade25: const Color(0xFFFEFAFF), // AA 6.24
    shade50: const Color(0xFFFDF4FF), // AA 6.00
    shade100: const Color(0xFFFBE8FF), // AA 5.55
    shade200: const Color(0xFFF6D0FE), // AA 4.71
    shade300: const Color(0xFFEEAAFD), // 3.62
    shade400: const Color(0xFFE478FA), // 2.51
    shade500: const Color(0xFFD444F1), // 3.56
    shade600: const Color(0xFFBA24D5), // AA 4.88
    shade700: const Color(0xFF9F1AB1), // AA 6.44
    shade800: const Color(0xFF821890), // AAA 8.45
    shade900: const Color(0xFF6F1877), // AAA 10.13
    shade950: const Color(0xFF47104C), // AAA 14.51
  );

  /// **Pink**
  BasicColor pink = BasicColor(
    shade25: const Color(0xFFFEF6FB), // AA 5.45
    shade50: const Color(0xFFFDF2FA), // AA 5.30
    shade100: const Color(0xFFFCE7F6), // AA 4.93
    shade200: const Color(0xFFFCCEEE), // 4.19
    shade300: const Color(0xFFFAA7E0), // 3.21
    shade400: const Color(0xFFF670C7), // 2.60
    shade500: const Color(0xFFEE46BC), // 3.36
    shade600: const Color(0xFFDD2590), // 4.42
    shade700: const Color(0xFFC11574), // AA 5.78
    shade800: const Color(0xFF9E165F), // AAA 7.68
    shade900: const Color(0xFF851651), // AAA 9.41
    shade950: const Color(0xFF4E0D30), // AAA 14.74
  );

  /// **Rose**
  BasicColor rose = BasicColor(
    shade25: const Color(0xFFFFF5F6), // AA 5.76
    shade50: const Color(0xFFFFF1F3), // AA 5.61
    shade100: const Color(0xFFFEE4E6), // AA 5.13
    shade200: const Color(0xFFFECDD6), // 4.37
    shade300: const Color(0xFFFEA3B4), // 3.25
    shade400: const Color(0xFFFD6F8E), // 2.67
    shade500: const Color(0xFFF63D68), // 3.62
    shade600: const Color(0xFFE31B54), // AA 4.61
    shade700: const Color(0xFFC01048), // AA 6.16
    shade800: const Color(0xFFA11043), // AAA 7.86
    shade900: const Color(0xFF89123E), // AAA 9.46
    shade950: const Color(0xFF510B24), // AAA 14.75
  );

  /// **Orange dark**
  ///
  /// Can be swapped with the default warning color.
  BasicColor orangeDark = BasicColor(
    shade25: const Color(0xFFFFF9F5), // AA 6.10
    shade50: const Color(0xFFFFF4ED), // AA 5.88
    shade100: const Color(0xFFFEE6D5), // AA 5.31
    shade200: const Color(0xFFFDDAE6), // AA 4.69
    shade300: const Color(0xFFFFC066), // 3.09
    shade400: const Color(0xFFFB892E), // 2.87
    shade500: const Color(0xFFF4440D), // 3.45
    shade600: const Color(0xFFE62E05), // 4.41
    shade700: const Color(0xFFBC1B06), // AA 6.36
    shade800: const Color(0xFF97180C), // AAA 8.56
    shade900: const Color(0xFF771A0D), // AAA 10.83
    shade950: const Color(0xFF57130A), // AAA 13.97
  );

  /// **Orange**
  ///
  /// Can be swapped with the default warning color.
  BasicColor orange = BasicColor(
    shade25: const Color(0xFFFEFAF5), // AA 5.55
    shade50: const Color(0xFFFEF6EE), // AA 5.39
    shade100: const Color(0xFFFDEAD7), // AA 4.92
    shade200: const Color(0xFFF9DBAF), // 4.33
    shade300: const Color(0xFFF7B27A), // 3.18
    shade400: const Color(0xFFF38744), // 2.51
    shade500: const Color(0xFFEF6820), // 3.14
    shade600: const Color(0xFFE04F16), // 3.96
    shade700: const Color(0xFFB93815), // AA 5.77
    shade800: const Color(0xFF932F19), // AAA 7.89
    shade900: const Color(0xFF772917), // AAA 9.93
    shade950: const Color(0xFF511C10), // AAA 13.78
  );

  /// **Yellow**
  ///
  /// Can be swapped with the default warning color.
  BasicColor yellow = BasicColor(
    shade25: const Color(0xFFFEFDF0), // AA 5.06
    shade50: const Color(0xFFFEFBE8), // AA 4.98
    shade100: const Color(0xFFFEF7C3), // AA 4.76
    shade200: const Color(0xFFFEEE95), // 4.41
    shade300: const Color(0xFFFDE272), // 4.02
    shade400: const Color(0xFFFAC515), // 1.60
    shade500: const Color(0xFFEAAC08), // 2.04
    shade600: const Color(0xFFCA8504), // 3.05
    shade700: const Color(0xFFA15C07), // AA 5.18
    shade800: const Color(0xFF854A0E), // AAA 7.03
    shade900: const Color(0xFF713B12), // AAA 8.98
    shade950: const Color(0xFF422006), // AAA 12.04
  );
}

class _BaseColor {
  Color white = const Color(0xFFFFFFFF);
  Color black = const Color(0xFF000000);
  Color transparent = const Color(0x00FFFFFF);
}

class BasicColor {
  final Color shade25;
  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;
  final Color shade950;

  BasicColor({
    required this.shade25,
    required this.shade50,
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
    required this.shade950,
  });
}
