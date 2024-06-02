import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import 'package:time_planner/app/data/theme/themeService.dart';
import 'package:time_planner/app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  await GetStorage.init();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const time_plannerApp()));
}

class time_plannerApp extends StatelessWidget {
  const time_plannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      theme: CustomTheme().customLightTheme,
      darkTheme: CustomTheme().customDarkTheme,
      themeMode: ThemeService().getThemeMode(),
      title: "Aplikasi Jadwal Kegiatan Dinas Pemuda, Olahraga dan Pariwisata",
      initialRoute: ROUTES.getSplashScreenRoute,
      getPages: ROUTES.routes,
    );
  }
}
