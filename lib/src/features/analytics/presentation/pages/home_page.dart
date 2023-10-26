import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/src/core/services/analytics_service.dart';
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/accounts.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/date_range_tab.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/profiles.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<AnalyticsCubit>().fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () =>
          context.read<AnalyticsCubit>().fetchAccountDetails(loading: false),
      child: ListView(
        padding: const EdgeInsets.all(mainMargin),
        children: <Widget>[
          WhiteCard(
            child: ValueListenableBuilder<GoogleSignInAccount?>(
              valueListenable: AnalyticService().currentUser,
              builder: (
                BuildContext context,
                GoogleSignInAccount? user,
                Widget? child,
              ) =>
                  user == null
                      ? const HeadLine('No Logged In')
                      : ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: GoogleUserCircleAvatar(
                            identity: user,
                          ),
                          title: Text(user.displayName ?? ''),
                          subtitle: Text(user.email),
                        ),
            ),
          ),
          const SizedBox(
            height: mainMargin,
          ),
          const AnalyticsAccount(),
          const SizedBox(
            height: mainMargin,
          ),
          const AnalyticProfile(),
          const SizedBox(
            height: mainMargin,
          ),
          DateRangeTab(
            onFetch: (DateTime start, DateTime end) async {
              final AnalyticsCubit cubit = context.read<AnalyticsCubit>()
                ..setDate(start, end);
              await cubit.getMonthlData();
              await cubit.getUserData();
              await cubit.getCityWiseData();
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
