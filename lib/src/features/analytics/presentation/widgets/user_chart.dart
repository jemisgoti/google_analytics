import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/services/analytics_service.dart';
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class UserChart extends StatefulWidget {
  const UserChart({
    required this.data,
    super.key,
  });
  final analytics.GaData data;
  @override
  State<StatefulWidget> createState() => UserChartState();
}

class UserChartState extends State<UserChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (BuildContext context, AnalyticsState state) => Builder(
          builder: (BuildContext context) {
            final analytics.GaData data = widget.data;
        
            final int users = int.parse(data.totalsForAllResults!['ga:users']!);
         
            final int newUsers =
                int.parse(data.totalsForAllResults!['ga:newUsers']!);
            return data.totalResults == 0
                ? const Center(
                    child: TitleText('No Data'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (
                                FlTouchEvent event,
                                PieTouchResponse? pieTouchResponse,
                              ) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 2,
                            centerSpaceRadius: 0,
                            sections: showingSections(users, newUsers),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Indicator(
                            color: Colors.black,
                            text: 'Existing Users(${users - newUsers})',
                            isSquare: false,
                            size: 8,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.deepOrange,
                            text: 'New Users($newUsers)',
                            isSquare: false,
                            size: 8,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.green,
                            text: 'Total Users($users)',
                            isSquare: false,
                            size: 8,
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      );

  List<PieChartSectionData> showingSections(int users, int newUsers) {
    final int differs = users - newUsers;
    final double usersPercent = differs / users;
    final double newUserPercent = newUsers / users;
    return List.generate(2, (int i) {
      final bool isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18.0 : 14.0;
      final double radius = isTouched ? 80.0 : 70.0;
      const List<Shadow> shadows = <Shadow>[Shadow(blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.black,
            value: usersPercent,
            title: '${usersPercent.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value: newUserPercent,
            title: '${newUserPercent.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    required this.color,
    required this.text,
    required this.isSquare,
    super.key,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      );
}
