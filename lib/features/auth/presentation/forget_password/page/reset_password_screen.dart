import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/inputs/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.otp});

  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = context.read<AuthCubit>();
    cubit.pinController.text = widget.otp;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPassSuccessState) {
          pop(context);
          pushTo(context, Routes.passwordChanged);
        } else if (state is AuthErrorState) {
          pop(context);
          showErrorDialog(context, state.massage);
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
        body: _resetPasswordBody(context),
      ),
    );
  }

  Widget _resetPasswordBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return MyBodyView(
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              Text('Create New Password', style: TextStyles.headline),
              Gap(10),
              Text(
                "Your new password must be unique from those previously used.",
                style: TextStyles.body.copyWith(color: AppColors.greyColor),
              ),
              Gap(32),
              PasswordTextFormField(
                controller: cubit.passwordController,
                hintText: 'New Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              Gap(15),
              PasswordTextFormField(
                controller: cubit.passwordConfirmationController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password confirmation';
                  } else if (value != cubit.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              Gap(30),
              MainButton(
                text: 'Reset Password',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.resetPassword();
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
