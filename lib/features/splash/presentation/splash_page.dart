import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/service_locator.dart';
import '../../../routes/app_routers.gr.dart';
import '../domain/usecase/login_status_usecase.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        serviceLocator<LoginStatusUsecase>().checkIfUserLoggedIn().then((isUserLoggedIn) {
          AutoRouter.of(context).pushAndPopUntil(
            isUserLoggedIn ? const HomeRoute() : const LoginRoute(),
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
