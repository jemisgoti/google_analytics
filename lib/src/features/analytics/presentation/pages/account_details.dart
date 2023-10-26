import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/utils/url_utils.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({required this.account, super.key});
  final analytics.Account account;
  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.account.name ?? ''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(mainMargin),
          child: WhiteCard(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const TitleText('Name: '),
                    Flexible(child: Paragraph(widget.account.name ?? '')),
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
                        widget.account.created!.toLocal().toString() ?? '',
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
                        widget.account.updated!.toLocal().toString(),
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
                    Flexible(child: Paragraph(widget.account.name ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('ID: '),
                    Flexible(child: Paragraph(widget.account.id ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Stared: '),
                    Flexible(
                      child: Paragraph(widget.account.starred.toString()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Kind: '),
                    Flexible(child: Paragraph(widget.account.kind ?? '')),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                Row(
                  children: <Widget>[
                    const TitleText('Permissio : '),
                    Flexible(
                      child: Paragraph(
                        widget.account.permissions!.effective.toString() ?? '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: subMargin,
                ),
                GestureDetector(
                  onTap: () {
                    openUrl(widget.account.childLink!.href!);
                  },
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Paragraph(
                          widget.account.childLink!.href ?? '',
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: subMargin,
                ),
                GestureDetector(
                  onTap: () {
                    openUrl(widget.account.selfLink!);
                  },
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Paragraph(
                          widget.account.selfLink!,
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
