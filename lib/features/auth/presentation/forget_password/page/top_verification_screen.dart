import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart'; 
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pop(context);
          pushTo(
            context,
            Routes.resetPassword,
            extra: {
              'otp': cubit.pinController.text,
            },
          );
        } else if (state is ResendCodeSuccessState) {
          pop(context); 
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Code resent successfully')),
          );
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
        body: _registerBody(context),
        bottomNavigationBar: AuthFooter(
          text: "Didn’t received code?",
          buttonText: 'Resend',
          onTap: () {
            cubit.resendVerifyCode();
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
                'OTP Verification',
                style: TextStyles.headline,
              ),
              Gap(10),
              Text(
                "Enter the verification code we just sent on your email address.",
                style: TextStyles.body.copyWith(color: AppColors.greyColor),
              ),
              Gap(32),
              Pinput(
                    controller: cubit.pinController,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    defaultPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      textStyle: TextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1 ,color: AppColors.borderColor),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      textStyle: TextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1.2 ,color: AppColors.primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty == true) {
                        return 'Please enter the verification code';
                      } else if (value.length < 4) {
                        return 'Please enter a valid verification code';
                      }
                      return null;
                    },
                  ),
              Gap(30),
              MainButton(
                text: 'Verify',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.checkForgetPassword();
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
