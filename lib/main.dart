import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'generated/locales.g.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'src/core/design/color.dart';
import 'src/core/design/styles.dart';
import 'src/core/design/typography.dart';
import 'src/core/routes/pages.dart';
import 'src/controllers/application_controller.dart';
import 'src/controllers/authentication_controller.dart';
import 'src/core/services/notification_service.dart';
import 'src/controllers/language_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize Firebase first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Then initialize other services
  await initGlobalControllers();

  // Initialize timezone data
  tz.initializeTimeZones();

  // Initialize notification service
  await NotificationService().initialize();

  runApp(const App());
}

Future<void> initGlobalControllers() async {
  await Get.putAsync(() => LanguageController().init(), permanent: true);

  Get.put(AuthenticationController(), permanent: true);
  Get.put(ApplicationController(), permanent: true);
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
                surfaceTintColor: Colors.white,
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
                color: AppColor.neutralColor.shade50,
                thickness: 1.w,
                space: 1.w,
              ),
              inputDecorationTheme: kInputDecoration,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColor.neutralColor.shade100,
                selectionColor: AppColor.neutralColor.shade100,
                selectionHandleColor: AppColor.neutralColor.shade100,
              ),
            ),
            initialRoute: AppPages.initialRoute,
            translationsKeys: AppTranslation.translations,
            supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN'), Locale('ko', 'KR')],
            fallbackLocale: const Locale('en', 'US'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Get.find<LanguageController>().currentLocale,
          ),
        );
      },
    );
  }
}
