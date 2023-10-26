import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/analytics/v3.dart' as analytics;
import 'package:test_app/src/core/widgets/text.dart';
import 'package:test_app/src/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:test_app/src/features/analytics/presentation/widgets/white_card.dart';

class CityWiseUsers extends StatefulWidget {
  const CityWiseUsers({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => CityWiseUsersState();
}

class CityWiseUsersState extends State<CityWiseUsers>
    with AutomaticKeepAliveClientMixin {
  int touchedIndex = -1;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<AnalyticsCubit>().getCityWiseData(loading: false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double height = constraints.biggest.height;
          return WhiteCard(
            padding: 0,
            child: RefreshIndicator(
              onRefresh: () => context
                  .read<AnalyticsCubit>()
                  .getCityWiseData(loading: false),
              child: ListView(
                children: <Widget>[
                  BlocConsumer<AnalyticsCubit, AnalyticsState>(
                    listener: (BuildContext context, AnalyticsState state) {},
                    buildWhen:
                        (AnalyticsState previous, AnalyticsState current) =>
                            current is CityAnalyticsFetched ||
                            current is CityAnalyticsLoading,
                    builder: (BuildContext context, AnalyticsState state) {
                      final analytics.GaData? data = state.cityWiseData;
                      if (state is CityAnalyticsLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (data != null) {
                        return SizedBox(
                          height: height,
                          child: DemoTableBody(
                            data: state.cityWiseData!,
                          ),
                        );
                      } else {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: TitleText('No Data'),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DemoTableBody extends StatefulWidget {
  const DemoTableBody({required this.data, super.key});
  final analytics.GaData data;
  @override
  _DemoTableBodyState createState() => _DemoTableBodyState();
}

class _DemoTableBodyState extends State<DemoTableBody> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  // A Variable to hold the length of table based on the condition of comparing the actual data length with the PaginatedDataTable.defaultRowsPerPage

  int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    //Obtain the data to be displayed from the Derived DataTableSource

    final DTS dts = DTS(widget.data);

    // dts.rowcount provides the actual data length, ForInstance, If we have 7 data stored in the DataTableSource Object, then we will get 12 as dts.rowCount

    final int tableItemsCount = dts.rowCount;

    // PaginatedDataTable.defaultRowsPerPage provides value as 10

    const int defaultRowsPerPage = 15;

    // We are checking whether tablesItemCount is less than the defaultRowsPerPage which means we are actually checking the length of the data in DataTableSource with default PaginatedDataTable.defaultRowsPerPage i.e, 10

    final bool isRowCountLessDefaultRowsPerPage =
        tableItemsCount < defaultRowsPerPage;

    // Assigning rowsPerPage as 10 or acutal length of our data in stored in the DataTableSource Object

    _rowsPerPage =
        isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
    return SingleChildScrollView(
      child: PaginatedDataTable(
        onRowsPerPageChanged:
            isRowCountLessDefaultRowsPerPage // The source of problem!
                ? null
                : (int? rowCount) {
                    setState(() {
                      _rowsPerPage1 = rowCount!;
                    });
                  },
        columns: const <DataColumn>[
          DataColumn(label: Text('City')),
          DataColumn(label: Text('Users')),
        ],
        source: dts,
        rowsPerPage:
            isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
      ),
    );
  }
}

class DTS extends DataTableSource {
  DTS(this.data);
  final analytics.GaData data;
  @override
  DataRow getRow(int index) => DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text(data.rows![index][0])),
          DataCell(Text(data.rows![index][1])),
        ],
      );

  @override
  int get rowCount =>
      data.rows!.length; // Manipulate this to which ever value you wish

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
