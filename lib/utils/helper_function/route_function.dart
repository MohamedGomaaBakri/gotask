import 'package:flutter/material.dart';
import 'package:todo/features/auth_feature/presentation/views/login_view.dart';
import 'package:todo/features/auth_feature/presentation/views/sign_up.dart';
import 'package:todo/features/home_feature/views/homa_page.dart';
import 'package:todo/features/onBoarding_feature/presentation/views/onboarding_view.dart';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (context) => const OnboardingView());

      case LoginView.routeName:
        return MaterialPageRoute(builder: (context) => const LoginView());

      case SignupView.routeName:
        return MaterialPageRoute(builder: (context) => const SignupView());

      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }