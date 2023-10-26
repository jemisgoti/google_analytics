import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/core/theme/colors.dart';
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/widgets/buttons.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';

class DateRangeTab extends StatefulWidget {
  const DateRangeTab({required this.onFetch, super.key});

  final void Function(DateTime start, DateTime end) onFetch;
  @override
  State<DateRangeTab> createState() => _DateRangeTabState();
}

class _DateRangeTabState extends State<DateRangeTab> {
  static final DateTime now = DateTime.now();

  DateTime start = now.copyWith(day: 1, year: 2021, month: 1);
  DateTime end = DateTime(now.year, now.month + 1).subtract(
    const Duration(days: 1),
  );

  @override
  void initState() {
    super.initState();
  }

  void listenState() {
    context.read<AnalyticsCubit>().stream.listen((AnalyticsState event) {
      start = event.startDate;
      end = event.endDate;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: start,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2300),
                      ).then((DateTime? value) {
                        if (value != null) {
                          start = value;
                          setState(() {});
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.date_range),
                          const SizedBox(
                            width: subMargin,
                          ),
                          TitleText(
                            start.toLocal().toString().substring(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: subMargin,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: end,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2300),
                      ).then((DateTime? value) {
                        if (value != null) {
                          end = value;
                          setState(() {});
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.date_range),
                          const SizedBox(
                            width: subMargin,
                          ),
                          TitleText(
                            end.toLocal().toString().substring(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            PrimaryButton(
              title: 'Set Date',
              onTap: () {
                widget.onFetch(start, end);
              },
            ),
          ],
        ),
      );
}
