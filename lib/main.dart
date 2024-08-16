import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/auth_feature/presentation/views/login_view.dart';
import 'package:todo/features/home_feature/views/homa_page.dart';
import 'package:todo/features/onBoarding_feature/presentation/views/onboarding_view.dart';
import 'firebase_options.dart';
import 'utils/constants.dart';
import 'utils/helper_function/route_function.dart';
import 'utils/services/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  bool isSeen = Prefs.getBool(kIsOnBoardingViewSeen);
  bool isLoggedIn = Prefs.getBool('isLoggedIn');
  String initialRoute;

  if (!isSeen) {
    initialRoute = OnboardingView.routeName;
  } else if (isLoggedIn) {
    initialRoute = HomePage.routeName;
  } else {
    initialRoute = LoginView.routeName;


  }

  runApp(
    ToDoApp(
      initialRoute: initialRoute,
    ),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({
    super.key,
    required this.initialRoute,
  });
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: initialRoute,
    );
  }
}
