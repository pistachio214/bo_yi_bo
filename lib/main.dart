import 'package:bo_yi_bo/routers/app_routes.dart';
import 'package:bo_yi_bo/routers/app_routes_generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  //需确保加载完成
  WidgetsFlutterBinding.ensureInitialized();

  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  );

  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  GetStorage.init().then((bool e) {
    if (e) {
      runApp(const MaybeApp());
    }
  });
}

final easyLoading = EasyLoading.init();
final fToast = FToastBuilder();

class MaybeApp extends StatelessWidget {
  const MaybeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Maybe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        primarySwatch: createMaterialColor(Colors.white),
        // appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
      ),
      builder: (BuildContext context, Widget? child) {
        child = easyLoading(context, child);
        child = fToast(context, child);
        // 点击空白,键盘消失
        child = Scaffold(
          body: GestureDetector(
            onTap: () => hideKeyboard(context),
            child: child,
          ),
        );

        return child;
      },
      initialRoute: AppRoutes.main,
      defaultTransition: Transition.cupertino,
      getPages: AppRoutesGenerate.onGenerateRoute(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};

    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
