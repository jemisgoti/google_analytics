import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/utils/url_utils.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/pages/account_details.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class AnalyticsAccount extends StatelessWidget {
  const AnalyticsAccount({super.key});

  @override
  Widget build(BuildContext context) => WhiteCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TitleText('Accounts'),
            const SizedBox(
              height: subMargin,
            ),
            BlocConsumer<AnalyticsCubit, AnalyticsState>(
              listener: (BuildContext context, AnalyticsState state) {},
              // buildWhen: (AnalyticsState previous, AnalyticsState current) =>
              //     current is AnalyticsAccountFetched ||
              //     current is AnalyticsAccountLoading,
              builder: (BuildContext context, AnalyticsState state) {
                if (state is AnalyticsAccountLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  final analytics.Accounts? accounts = state.accounts;
                  if (accounts == null || accounts.items!.isEmpty) {
                    return const Center(
                      child: TitleText('No Properties found.'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: accounts.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final analytics.Account account = accounts.items![index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute<dynamic>(
                              builder: (BuildContext context) => AccountDetails(
                                account: account,
                              ),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text(account.name ?? ''),
                        subtitle: Text(
                          account.created!.toLocal().toString(),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            openUrl(account.selfLink!);
                          },
                          icon: const Icon(Icons.link),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      );
}
