import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'src/services/app_service.dart';

import 'firebase_options.dart';
import 'src/core/design/color.dart';
import 'src/core/design/styles.dart';
import 'src/core/design/typography.dart';
import 'src/core/routes/pages.dart';
import 'src/services/authentication_service.dart';
import 'src/services/data_sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initServices();

  runApp(const App());
}

Future<void> initServices() async {
  await Get.putAsync(() => AuthService().init(), permanent: true);
  await Get.putAsync(() => AppService().init(), permanent: true);
  await Get.putAsync(() => DataSyncService().init(), permanent: true);
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: GetMaterialApp(
            getPages: AppPages.pages,
            theme: ThemeData(
              iconTheme: const IconThemeData(weight: 900),
              scaffoldBackgroundColor: AppColor.neutralColor.shade10,
              primaryColor: AppColor.primaryColor.main,
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor.main),
              appBarTheme: AppBarTheme(
                titleTextStyle: AppTypography.bodyLarge.semiBold.copyWith(color: AppColor.neutralColor.shade100),
                backgroundColor: AppColor.neutralColor.shade10,
              ),
              cardTheme: CardTheme(
                color: AppColor.neutralColor.shade10,
                surfaceTintColor: Colors.transparent,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dividerTheme: DividerThemeData(
                color: AppColor.neutralColor.shade60,
                thickness: 0.5,
                space: 0,
              ),
              inputDecorationTheme: kInputDecoration,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColor.neutralColor.shade100,
                selectionColor: AppColor.neutralColor.shade100,
                selectionHandleColor: AppColor.neutralColor.shade100,
              ),
            ),
            initialRoute: AppPages.initialRoute,
          ),
        );
      },
    );
  }
}
