import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/date_range_tab.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/user_chart.dart';

class PropertyData extends StatefulWidget {
  const PropertyData({required this.profile, super.key});
  final analytics.Profile profile;
  @override
  State<PropertyData> createState() => _PropertyDataState();
}

class _PropertyDataState extends State<PropertyData> {
  DateTime? start;
  DateTime? end;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.profile.name ?? ''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(mainMargin),
          child: ListView(
            children: <Widget>[
              DateRangeTab(
                onFetch: (DateTime start, DateTime end) {
                  this.start = start;
                  this.end = end;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: subMargin,
              ),
            ],
          ),
        ),
      );
}
