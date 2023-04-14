import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/service_locator.dart';
import '../../../routes/app_routers.gr.dart';
import '../domain/usecase/check_user_login_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        serviceLocator<CheckUserLoginStatus>().checkIfUserLoggedIn().then((isUserLoggedIn) {
          AutoRouter.of(context).pushAndPopUntil(
            isUserLoggedIn ? const HomepageScreen() : const AuthenticationScreen(),
            predicate: (_) => false,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Splash Screen',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: 200.0,
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
