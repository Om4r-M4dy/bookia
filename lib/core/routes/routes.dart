import 'package:bookia/features/Home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/forgot_password_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/password_changed.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/reset_password_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/page/register_screen.dart';
import 'package:bookia/features/details/page/details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/page/search_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  // route names
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String otpVerification = '/otpVerification';
  static const String resetPassword = '/resetPassword';
  static const String passwordChanged = '/passwordChanged';
  static const String main = '/main';
  static const String details = '/details';
  static const String search = '/search';

  // config
  // auth routes
  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: otpVerification,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: OtpVerificationScreen(email: state.extra as String),
        ),
      ),
      GoRoute(
        path: resetPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: ResetPasswordScreen(otp: extra['otp']!),
          );
        },
      ),
      GoRoute(
        path: passwordChanged,
        builder: (context, state) => const PasswordChangedScreen(),
      ),

      // main routes
      GoRoute(path: main, builder: (context, state) => const MainAppScreen()),
      GoRoute(
        path: details,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DetailsScreen(
            book: extra['book'] as Product,
            heroTag: extra['heroTag'] as String,
          );
        },
      ),
      GoRoute(
        path: search,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit()..search(''),
          child: const SearchScreen(),
        ),
      ),
    ],
  );
}
