import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 22,
            right: 22,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                CustomSvgPicture(path: AppImages.logoSvg),
                Gap(28),
                Text('Order Your Book Now!', style: TextStyles.subtitle2),
                Spacer(flex: 5),
                MainButton(
                  text: 'Login',
                  onPressed: () {
                    pushTo(context, Routes.login);
                  },
                ),
                Gap(15),
                MainButton(
                  text: 'Register',
                  onPressed: () {
                    pushTo(context, Routes.register);
                  },
                  bgColor: AppColors.backgroundColor,
                  textColor: AppColors.darkColor,
                  borderColor: AppColors.darkColor,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
