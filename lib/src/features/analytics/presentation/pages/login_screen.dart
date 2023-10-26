import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/src/core/services/analytics_service.dart';
import 'package:test_app/src/core/theme/assets_path.dart';
import 'package:test_app/src/core/theme/colors.dart';
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/widgets/buttons.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/pages/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ButtonController buttonController = ButtonController();

  AnalyticService analyticService = AnalyticService();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(mainMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                AssetPath.loginSvg,
                width: 250,
                height: 250,
              ),
              const SizedBox(
                height: mainMargin,
              ),
              const HeadLine('Log in to Google Analytics'),
              const SizedBox(
                height: mainMargin,
              ),
              const Paragraph(
                '''To see your Google Analytics data, you need to sign in using your Google account.''',
              ),
              const SizedBox(
                height: mainMargin,
              ),
              PrimaryButton(
                onTap: onButtonPress,
                controller: buttonController,
                title: 'Sign in with Google',
              ),
            ],
          ),
        ),
      );
  Future<void> onButtonPress() async {
    buttonController.toggleLoading();
    await analyticService.handleSignIn();

    await analyticService.issLoggedIn.then((bool value) {
      if (value) {
        buttonController.toggleLoading();
        context.go(Dashboard.routeName);
      } else {}
    });
  }
}
