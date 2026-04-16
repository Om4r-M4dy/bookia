import 'dart:developer';

import 'package:bookia/core/local/shared_pref.dart';
import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.saveToken(data.data?.token);
        SharedPref.saveUserInfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.saveToken(data.data?.token);
        SharedPref.saveUserInfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> forgetPassword(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.forgetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> checkForgetPassword(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.checkForgetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> resetPassword(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.resetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> resendVerifyCode() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.resendVerifyCode,
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
