import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/inputs/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/inputs/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          removeUntil(context, Routes.main);
        } else if (state is AuthErrorState) {
          pop(context);
          showMessageDialog(context, state.massage);
        } else if (state is AuthLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  pop(context);
                },
                child: CustomSvgPicture(path: AppImages.backSvg),
              ),
            ],
          ),
        ),
        body: _registerBody(context),
        bottomNavigationBar: AuthFooter(
          text: "Already have an account?",
          buttonText: 'Sign In',
          onTap: () {
            replaceWith(context, Routes.login);
          },
        ),
      ),
    );
  }

  Widget _registerBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return MyBodyView(
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              Text(
                'Hello! Register to get started',
                style: TextStyles.headline,
              ),
              Gap(32),
              CustomTextFormField(
                controller: cubit.userNameController,
                hintText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter yor full name';
                  }
                  return null;
                },
              ),
              Gap(12),
              CustomTextFormField(
                controller: cubit.emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter yor email';
                  } else if (!isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(12),
              PasswordTextFormField(
                controller: cubit.passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              Gap(12),
              PasswordTextFormField(
                controller: cubit.passwordConfirmationController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value != cubit.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              Gap(30),
              MainButton(
                text: 'Register',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
