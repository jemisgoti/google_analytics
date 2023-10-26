// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/analytics/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;

class AnalyticService {
  factory AnalyticService() => _instance;

  AnalyticService._internal() {
    listenAuth();
  }
  // AnalyticService() {
  //   listenAuth();
  // }

  static final AnalyticService _instance = AnalyticService._internal();
  //
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
    scopes: <String>[
      AnalyticsApi.analyticsScope,
      AnalyticsApi.analyticsEditScope,
      AnalyticsApi.analyticsManageUsersReadonlyScope,
      AnalyticsApi.analyticsManageUsersScope,
      AnalyticsApi.analyticsProvisionScope,
      AnalyticsApi.analyticsReadonlyScope,
      AnalyticsApi.analyticsUserDeletionScope,
    ],
  );

  final ValueNotifier<GoogleSignInAccount?> currentUser = ValueNotifier(null);
  Future<bool> get issLoggedIn => _googleSignIn.isSignedIn();
  GoogleSignInAccount? get user => currentUser.value;
  void listenAuth() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      currentUser.value = account;

      //TODO: call api function
    });
    _googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error); // ignore: avoid_print
    }
  }

  Future<void> handleSignOut() async {
    await _googleSignIn.disconnect();
    currentUser.value = null;
  }

  Future<Accounts?> getAccounts() async {
    log('Fetching accounts');
    // Retrieve an [auth.AuthClient] from the current [GoogleSignIn] instance.
    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');
    try {
      final AnalyticsApi analyticsApi = AnalyticsApi(client!);

      return analyticsApi.management.accounts.list();
    } on DetailedApiRequestError catch (e) {
      log(e.message ?? 'Error while fetching data');
    }
    return null;
  }

  Future<Profiles?> getProfiles() async {
    log('Fetching properties');
    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');
    try {
      final AnalyticsApi analyticsApi = AnalyticsApi(client!);
      return await analyticsApi.management.profiles.list('~all', '~all');
    } on DetailedApiRequestError catch (e) {
      log(e.message ?? 'Error while fetching data');
    }
    return null;
  }

  Future<GaData?> getMonthlyData({
    required String id,
    required DateTime start,
    required DateTime end,
  }) async {
    log('Fetching monthly data');
    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');

    final AnalyticsApi api = AnalyticsApi(client!);

    try {
      final GaData data = await api.data.ga.get(
        'ga:$id',
        start.toString().substring(0, 10),
        end.toString().substring(0, 10),
        'ga:pageviews',
        includeEmptyRows: true,
        dimensions: 'ga:month',
      );
      return data;
    } on DetailedApiRequestError catch (e) {
      log(e.message ?? 'Error while fetching data');
    }
    return null;
  }

  Future<GaData?> getUsersData({
    required String id,
    required DateTime start,
    required DateTime end,
  }) async {
    log('Fetching user data');
    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');

    final AnalyticsApi analyticApi = AnalyticsApi(client!);

    try {
      final GaData data = await analyticApi.data.ga.get(
        'ga:$id',
        start.toString().substring(0, 10),
        end.toString().substring(0, 10),
        'ga:users,ga:newUsers',
      );

      return data;
    } on DetailedApiRequestError catch (e) {
      log(e.message ?? 'Error while fetching data');
    }
    return null;
  }

  Future<GaData?> getCityWiseUser({
    required String id,
    required DateTime start,
    required DateTime end,
  }) async {
    log('Fetching city wise data');
    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');

    final AnalyticsApi analyticApi = AnalyticsApi(client!);

    try {
      final GaData data = await analyticApi.data.ga.get(
        'ga:$id',
        start.toString().substring(0, 10),
        end.toString().substring(0, 10),
        'ga:users',
        dimensions: 'ga:city',
      );

      return data;
    } on DetailedApiRequestError catch (e) {
      log(e.message ?? 'Error while fetching data');
    }
    return null;
  }
}
