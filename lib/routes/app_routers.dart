import 'package:auto_route/auto_route.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute<bool>(page: SplashPage, initial: true),
    AutoRoute<bool>(page: LoginPage, path: LoginPage.routeName),
    AutoRoute<bool>(page: HomePage, path: HomePage.routeName),
  ],
  replaceInRouteName: 'Page,Route',
)
class $FlutterRouter {}
