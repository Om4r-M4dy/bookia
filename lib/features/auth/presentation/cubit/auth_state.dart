class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class ForgotPassSuccessState extends AuthState {}

class ResendCodeSuccessState extends AuthState {}

class ResetPassSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String massage;
  AuthErrorState({required this.massage});
}
