class AuthParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  int? verifyCode;

  AuthParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.verifyCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "verify_code": verifyCode,
    };
  }
}
