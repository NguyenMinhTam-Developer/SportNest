// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../core/design/color.dart';
// import '../../core/design/typography.dart';
// import 'input_label.dart';

// class InputField extends StatelessWidget {
//   const InputField({
//     super.key,
//     this.controller,
//     required this.name,
//     required this.labelText,
//     required this.hintText,
//     this.errorText,
//     this.keyboardType,
//     this.textInputAction,
//     this.enabled = true,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.validator,
//   });

//   final TextEditingController? controller;
//   final String name;
//   final String labelText;
//   final String hintText;
//   final String? errorText;

//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool enabled;
//   final bool obscureText;

//   final Widget? suffixIcon;

//   final String? Function(String?)? validator;

//   @override
//   Widget build(BuildContext context) {
//     return InputLabel(
//       labelText: labelText,
//       errorText: errorText,
//       child: FormBuilderTextField(
//         name: name,
//         controller: controller,
//         enabled: enabled,
//         obscureText: obscureText,
//         style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
//         keyboardType: keyboardType,
//         textInputAction: textInputAction,
//         validator: validator,
//       ),
//     );
//   }
// }
