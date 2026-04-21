import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/inputs/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPassSuccessState) {
          pop(context);
          pushTo(
            context,
            Routes.otpVerification,
            extra: context.read<AuthCubit>().emailController.text,
          );
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
          text: "Remember Password?",
          buttonText: 'Login',
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
              Text('Forgot Password?', style: TextStyles.headline),
              Gap(10),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyles.body.copyWith(color: AppColors.greyColor),
              ),
              Gap(32),
              CustomTextFormField(
                controller: cubit.emailController,
                hintText: 'Enter your email',
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
              Gap(30),
              MainButton(
                text: 'Send Code',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.forgotPassword();
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
