import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/pages/properties_details.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AnalyticProfile extends StatelessWidget {
  const AnalyticProfile({super.key});
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) => WhiteCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TitleText('Properties'),
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
                  final analytics.Profiles? profiles = state.profiles;
                  if (profiles == null || profiles.items!.isEmpty) {
                    return const Center(
                      child: TitleText('No Properties found.'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: profiles.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final analytics.Profile profile = profiles.items![index];
                      return Column(
                        children: <Widget>[
                          RadioListTile<String>(
                            onChanged: (String? value) {},
                            value: profile.id!,

                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue:
                                context.read<AnalyticsCubit>().propertyID,
                            contentPadding: EdgeInsets.zero,
                            title: Text(profile.name ?? ''),
                            subtitle: Text(
                              profile.created!.toLocal().toString(),
                            ),
                            // trailing: IconButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       CupertinoPageRoute<dynamic>(
                            //         builder: (BuildContext context) => PropertyData(
                            //           profile: profile,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   icon: const Icon(Icons.bar_chart_outlined),
                            // ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  openUrl(profile.selfLink!);
                                },
                                child: const Text('Open In Browser'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          ProfileDetails(
                                        profile: profile,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('View Details'),
                              ),
                            ],
                          ),
                        ],
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
