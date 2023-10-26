import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/src/core/services/analytics_service.dart';
import 'package:test_app/src/core/theme/assets_path.dart';
import 'package:test_app/src/core/theme/colors.dart';
import 'package:test_app/src/features/analytics/presentation/pages/dashboard.dart';
import 'package:test_app/src/features/analytics/presentation/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/welcome';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    firstRun();
  }

  void firstRun() {
    Future<dynamic>.delayed(const Duration(seconds: 1)).then((dynamic value) {
      AnalyticService().issLoggedIn.then((bool value) {
        if (value) {
          context.go(Dashboard.routeName);
        } else {
          context.go(LoginScreen.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: white,
        body: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                AssetPath.logo,
                width: 80,
                height: 80,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.sizeOf(context).height / 2 + 80,
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(
                    backgroundColor: darkGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
