import 'package:get/get.dart';
import 'middleware/route_auth_middleware.dart';

import 'package:bo_yi_bo/routers/app_routes.dart';
import 'package:bo_yi_bo/routers/app_routes_models.dart';

import 'package:bo_yi_bo/ui/main/view.dart';

class AppRoutesGenerate {
  static final List<AppRoutesModels> routes = <AppRoutesModels>[
    AppRoutesModels(AppRoutes.main, () => MainPage()),
  ];

  static final List<String> noValidation = <String>[
    AppRoutes.main,
  ];

  // 通用过滤器
  static final List<GetMiddleware> defaultMiddleware = <GetMiddleware>[
  ];

  static List<GetPage>? onGenerateRoute() {
    return _generateRoute(routes);
  }

  static List<GetPage>? _generateRoute(List<AppRoutesModels> routes) {
    List<GetPage> appRoutes = <GetPage>[];
    List<GetMiddleware> middlewareList = <GetMiddleware>[];

    for (var element in routes) {
      // 判定是否需要登录验证
      if (noValidation.isNotEmpty && !noValidation.contains(element.name)) {
        // defaultMiddleware.add(RouteAuthMiddleware());

        if (element.middlewares == null) {
          middlewareList = defaultMiddleware;
        } else {
          middlewareList.addAll(defaultMiddleware);
          middlewareList.addAll(element.middlewares!);
        }
      }

      if (element.children != null) {
        appRoutes.add(
          GetPage(
            name: element.name,
            page: element.page,
            transition: element.transition,
            middlewares: middlewareList,
            children: _generateRoute(element.children!)!,
          ),
        );
      } else {
        appRoutes.add(GetPage(
          name: element.name,
          page: element.page,
          transition: element.transition,
          middlewares: middlewareList,
        ));
      }
    }

    return appRoutes;
  }
}
