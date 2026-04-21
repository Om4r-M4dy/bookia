import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/repository/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final pinController = TextEditingController();

  Future<void> login() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    var data = await AuthRepo.login(params);
    if (data != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      name: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );
    var data = await AuthRepo.register(params);
    if (data != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }

  Future<void> forgotPassword() async {
    emit(AuthLoadingState());
    var params = AuthParams(email: emailController.text);
    var data = await AuthRepo.forgetPassword(params);
    if (data != null) {
      emit(ForgotPassSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }

  Future<void> checkForgetPassword() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      email: emailController.text,
      verifyCode: int.parse(pinController.text),
    );
    var data = await AuthRepo.checkForgetPassword(params);
    if (data != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }

  Future<void> resetPassword() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      verifyCode: int.parse(pinController.text),
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );
    var data = await AuthRepo.resetPassword(params);
    if (data != null) {
      emit(ResetPassSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }

  Future<void> resendVerifyCode() async {
    emit(AuthLoadingState());
    var data = await AuthRepo.resendVerifyCode();
    if (data != null) {
      emit(ResendCodeSuccessState());
    } else {
      emit(AuthErrorState(massage: 'Something went wrong, please try again'));
    }
  }
}
