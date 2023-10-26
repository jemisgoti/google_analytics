part of 'analytics_cubit.dart';

// abstract class AnalyticsState extends Equatable {
//   const AnalyticsState();
// }

abstract class AnalyticsState extends Equatable {
  const AnalyticsState({
    required this.startDate,
    required this.endDate,
    this.cityWiseData,
    this.usersData,
    this.monthWiseData,
    this.accounts,
    this.profiles,
  });
  final DateTime startDate;
  final DateTime endDate;
  final GaData? cityWiseData;
  final GaData? usersData;
  final GaData? monthWiseData;
  final Accounts? accounts;
  final Profiles? profiles;

  @override
  List<Object> get props => <Object>[
        startDate,
        endDate,
        cityWiseData ?? '',
        usersData ?? '',
        monthWiseData ?? '',
        accounts ?? '',
        profiles ?? '',
      ];
}

class AnalyticsDateUpdated extends AnalyticsState {
  const AnalyticsDateUpdated({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory AnalyticsDateUpdated.fromState(
    AnalyticsState state,
    DateTime start,
    DateTime end,
  ) =>
      AnalyticsDateUpdated(
        startDate: start,
        endDate: end,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class AnalyticsAccountLoading extends AnalyticsState {
  const AnalyticsAccountLoading({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory AnalyticsAccountLoading.fromState(
    AnalyticsState state,
  ) =>
      AnalyticsAccountLoading(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class AnalyticsAccountFetched extends AnalyticsState {
  const AnalyticsAccountFetched({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory AnalyticsAccountFetched.fromState(
    AnalyticsState state,
    Accounts? accounts,
    Profiles? profiles,
  ) =>
      AnalyticsAccountFetched(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: accounts,
        profiles: profiles,
      );
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });

  factory AnalyticsInitial.demo() {
    final DateTime now = DateTime.now();

    final DateTime startDate = now.copyWith(day: 1, year: 2021, month: 1);
    final DateTime endDate = DateTime(now.year, now.month + 1).subtract(
      const Duration(days: 1),
    );
    return AnalyticsInitial(startDate: startDate, endDate: endDate);
  }
}

class CityAnalyticsFetched extends AnalyticsState {
  const CityAnalyticsFetched({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory CityAnalyticsFetched.fromState(AnalyticsState state, GaData? data) =>
      CityAnalyticsFetched(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: data,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class CityAnalyticsLoading extends AnalyticsState {
  const CityAnalyticsLoading({
    required super.startDate,
    required super.endDate,
    super.cityWiseData,
    super.usersData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory CityAnalyticsLoading.fromState(AnalyticsState state) =>
      CityAnalyticsLoading(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class UserAnalyticsLoading extends AnalyticsState {
  const UserAnalyticsLoading({
    required super.startDate,
    required super.endDate,
    required super.usersData,
    super.cityWiseData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory UserAnalyticsLoading.fromState(AnalyticsState state) =>
      UserAnalyticsLoading(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class UserAnalyticsFetched extends AnalyticsState {
  const UserAnalyticsFetched({
    required super.startDate,
    required super.endDate,
    required super.usersData,
    super.cityWiseData,
    super.monthWiseData,
    super.accounts,
    super.profiles,
  });
  factory UserAnalyticsFetched.fromState(AnalyticsState state, GaData? data) =>
      UserAnalyticsFetched(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: data,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class MonthlyAnalyticsFetched extends AnalyticsState {
  const MonthlyAnalyticsFetched({
    required super.startDate,
    required super.endDate,
    required super.monthWiseData,
    super.cityWiseData,
    super.usersData,
    super.accounts,
    super.profiles,
  });
  factory MonthlyAnalyticsFetched.fromState(
    AnalyticsState state,
    GaData? data,
  ) =>
      MonthlyAnalyticsFetched(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: data,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}

class MonthlyAnalyticsLoading extends AnalyticsState {
  const MonthlyAnalyticsLoading({
    required super.startDate,
    required super.endDate,
    required super.monthWiseData,
    super.cityWiseData,
    super.usersData,
    super.accounts,
    super.profiles,
  });
  factory MonthlyAnalyticsLoading.fromState(AnalyticsState state) =>
      MonthlyAnalyticsLoading(
        startDate: state.startDate,
        endDate: state.endDate,
        cityWiseData: state.cityWiseData,
        usersData: state.usersData,
        monthWiseData: state.monthWiseData,
        accounts: state.accounts,
        profiles: state.profiles,
      );
}
