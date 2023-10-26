import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/src/core/services/analytics_service.dart';
import 'package:test_app/src/core/theme/colors.dart';
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/features/analytics/presentation/pages/analytics_view.dart';
import 'package:test_app/src/features/analytics/presentation/pages/city_wise_user.dart';
import 'package:test_app/src/features/analytics/presentation/pages/home_page.dart';
import 'package:test_app/src/features/analytics/presentation/pages/splash_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const String routeName = '/dashboard';
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  List<Widget> pages = <Widget>[
    const HomePage(),
    const AnalyticsView(),
    const CityWiseUsers(),
  ];
  AnalyticService analyticService = AnalyticService();
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          title: Text(getTitle()),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await handleSignOut();
              },
              icon: const Icon(CupertinoIcons.power),
            ),
            const SizedBox(
              width: mainMargin,
            ),
          ],
        ),
        body: PageView(
          controller: controller,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.jumpToPage,
          currentIndex: index,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.table_chart,
              ),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.location_city,
              ),
              label: 'City',
            ),
          ],
        ),
      );

  Future<void> handleSignOut() async {
    await AnalyticService().handleSignOut();
    await analyticService.issLoggedIn.then((bool value) {
      if (!value) {
        context.go(SplashScreen.routeName);
      }
    });
  }

  String getTitle() {
    switch (index) {
      case 0:
        return 'Dashbord';
      case 1:
        return 'User Data';
      case 2:
        return 'Ctiy Wise Users';
    }
    return '';
  }
}
