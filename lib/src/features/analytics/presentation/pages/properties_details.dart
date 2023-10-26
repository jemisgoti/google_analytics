import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/utils/url_utils.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({required this.profile, super.key});
  final analytics.Profile profile;
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.profile.name ?? ''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(mainMargin),
          child: WhiteCard(
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const TitleText('Name: '),
                    Flexible(child: Paragraph(widget.profile.name ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Created: '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.created!.toLocal().toString() ?? '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Updated: '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.updated!.toLocal().toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Name: '),
                    Flexible(child: Paragraph(widget.profile.name ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('ID: '),
                    Flexible(child: Paragraph(widget.profile.id ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Stared: '),
                    Flexible(
                      child: Paragraph(widget.profile.starred.toString()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Kind: '),
                    Flexible(child: Paragraph(widget.profile.kind ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Bot filter : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.botFilteringEnabled.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Eccomerce Tracting : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.eCommerceTracking.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Enhance Ecommerce : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.enhancedECommerceTracking.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Stripe Site Seach : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.stripSiteSearchCategoryParameters
                            .toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Stripe Serarch Query : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.stripSiteSearchQueryParameters
                            .toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Account ID : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.accountId.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Currency : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.currency.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Default Page : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.defaultPage.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Exclude Query Parameter : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.excludeQueryParameters.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Web Property ID : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.webPropertyId.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Website URL : '),
                    Flexible(
                      child: Paragraph(
                        widget.profile.websiteUrl.toString(),
                      ),
                    ),
                  ],
                ),
                const TitleText('Parrent Link : '),
                GestureDetector(
                  onTap: () {
                    openUrl(widget.profile.parentLink!.href.toString());
                  },
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Paragraph(
                          widget.profile.parentLink!.href.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: subMargin,
                ),
                const TitleText('Child Link : '),
                GestureDetector(
                  onTap: () {
                    openUrl(widget.profile.childLink!.href!);
                  },
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Paragraph(
                          widget.profile.childLink!.href ?? '',
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: subMargin,
                ),
                const TitleText('Self Link : '),
                GestureDetector(
                  onTap: () {
                    openUrl(widget.profile.selfLink!);
                  },
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Paragraph(
                          widget.profile.selfLink!,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: subMargin,
                ),
              ],
            ),
          ),
        ),
      );
}
