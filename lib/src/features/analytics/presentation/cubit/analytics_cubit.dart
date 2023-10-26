import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:googleapis/analytics/v3.dart';

import 'package:test_app/src/core/services/analytics_service.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit() : super(AnalyticsInitial.demo());

  AnalyticService analyticService = AnalyticService();
  String propertyID = '0';

  void setDate(DateTime start, DateTime end) {
    emit(AnalyticsDateUpdated.fromState(state, start, end));
  }

  Future<void> getUserData({bool loading = true}) async {
    if (loading) {
      emit(UserAnalyticsLoading.fromState(state));
    }

    final GaData? data = await analyticService.getUsersData(
      id: propertyID,
      start: state.startDate,
      end: state.endDate,
    );

    emit(UserAnalyticsFetched.fromState(state, data));
  }

  Future<void> fetchAccountDetails({bool loading = true}) async {
    if (loading) {
      emit(AnalyticsAccountLoading.fromState(state));
    }

    final Profiles? profiles = await analyticService.getProfiles();
    if (profiles != null) {
      if (profiles.items!.isNotEmpty) {
        propertyID = profiles.items!.first.id!;
      }
    }
    final Accounts? accounts = await analyticService.getAccounts();
    emit(AnalyticsAccountFetched.fromState(state, accounts, profiles));
  }

  Future<void> getCityWiseData({bool loading = true}) async {
    if (loading) {
      emit(CityAnalyticsLoading.fromState(state));
    }

    final GaData? data = await analyticService.getCityWiseUser(
      id: propertyID,
      start: state.startDate,
      end: state.endDate,
    );

    emit(CityAnalyticsFetched.fromState(state, data));
  }

  Future<void> getMonthlData({bool loading = true}) async {
    if (loading) {
      emit(MonthlyAnalyticsLoading.fromState(state));
    }

    final GaData? data = await analyticService.getMonthlyData(
      id: propertyID,
      start: state.startDate,
      end: state.endDate,
    );

    emit(MonthlyAnalyticsFetched.fromState(state, data));
  }
}
