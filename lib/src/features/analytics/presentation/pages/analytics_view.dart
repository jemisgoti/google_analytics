import 'dart:developer' as dev;
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/theme/dimension.dart';
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/user_chart.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({
    super.key,
  });

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView>
    with AutomaticKeepAliveClientMixin {
  Color mainLineColor = Colors.teal;

  Color belowLineColor = Colors.deepOrange;

  Color aboveLineColor = Colors.black;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
      case 1:
        text = 'Feb';
      case 2:
        text = 'Mar';
      case 3:
        text = 'Apr';
      case 4:
        text = 'May';
      case 5:
        text = 'Jun';
      case 6:
        text = 'Jul';
      case 7:
        text = 'Aug';
      case 8:
        text = 'Sep';
      case 9:
        text = 'Oct';
      case 10:
        text = 'Nov';
      case 11:
        text = 'Dec';
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${value.round()}', style: style),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.wait(<Future<void>>[
      context.read<AnalyticsCubit>().getMonthlData(),
      context.read<AnalyticsCubit>().getUserData(),
    ]);
  }

  double cutOffYValue = 50;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(mainMargin),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.wait(<Future<void>>[
            context.read<AnalyticsCubit>().getMonthlData(),
            context.read<AnalyticsCubit>().getUserData(),
          ]);
        },
        child: ListView(
          children: <Widget>[
            WhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const TitleText('Monthly User '),
                  const SizedBox(
                    height: subMargin,
                  ),
                  SizedBox(
                    height: 250,
                    width: MediaQuery.sizeOf(context).width,
                    child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
                      builder: (BuildContext context, AnalyticsState state) {
                        if (state is MonthlyAnalyticsLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          final analytics.GaData? data = state.monthWiseData;
                          if (data == null || data.totalResults == 0) {
                            return const Center(
                              child: TitleText('No Properties found.'),
                            );
                          }

                          dev.log(data.toJson().toString());
                          final double maxY = getMax(data);
                          return LineChart(
                            LineChartData(
                              lineTouchData:
                                  const LineTouchData(enabled: false),
                              lineBarsData: getData(data),
                              minY: 0,
                              maxY: getMax(data),
                              titlesData: FlTitlesData(
                                topTitles: const AxisTitles(),
                                rightTitles: const AxisTitles(),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 18,
                                    interval: 1,
                                    getTitlesWidget: bottomTitleWidgets,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  axisNameSize: 20,
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: maxY / 5,
                                    reservedSize: 40,
                                    getTitlesWidget: leftTitleWidgets,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                                border: Border.all(),
                              ),
                              gridData: FlGridData(
                                horizontalInterval: 1,
                                verticalInterval: maxY / 10,
                                drawHorizontalLine: false,
                                drawVerticalLine: false,
                                checkToShowVerticalLine: (double value) => true,
                                checkToShowHorizontalLine: (double value) =>
                                    true,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: mainMargin,
            ),
            WhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const TitleText('Users'),
                  const SizedBox(
                    height: subMargin,
                  ),
                  BlocBuilder<AnalyticsCubit, AnalyticsState>(
                    builder: (BuildContext context, AnalyticsState state) {
                      if (state is UserAnalyticsLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else {
                        final analytics.GaData? data = state.usersData;
                        if (data == null || data.totalResults == 0) {
                          return const Center(
                            child: TitleText('No Properties found.'),
                          );
                        }
                        return UserChart(data: data);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  double getMax(analytics.GaData data) {
    final Map<int, List<String>> rows = data.rows!.asMap();

    final List<double> spot = <double>[];
    rows.forEach((int key, List<String> value) {
      spot.add(double.parse(value[1]));
    });
    return spot.reduce(max);
  }

  List<LineChartBarData> getData(analytics.GaData data) {
    final Map<int, List<String>> rows = data.rows!.asMap();

    final List<FlSpot> spot = <FlSpot>[];

    rows.forEach((int key, List<String> value) {
      spot.add(FlSpot(key.toDouble(), double.parse(value[1])));
    });

    return <LineChartBarData>[
      LineChartBarData(
        spots: spot,
        isCurved: true,
        color: mainLineColor,
        belowBarData: BarAreaData(
          show: true,
          color: belowLineColor,
          cutOffY: cutOffYValue,
          applyCutOffY: true,
        ),
        aboveBarData: BarAreaData(
          show: true,
          color: aboveLineColor,
          cutOffY: cutOffYValue,
          applyCutOffY: true,
        ),
        dotData: const FlDotData(
          show: false,
        ),
      ),
    ];
  }
}
