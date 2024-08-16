import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/auth_feature/data/repos_impl/repo_ipml.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:todo/utils/services/firebase_services.dart';
import 'widgets/signupviewbodyconsumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => SignupCubit(
            RepoIpml(
              firebaseServices: FirebaseServices(),
            ),
        ),
        child: const Signupviewbodyconsumer(),
      ),
    );
  }
}
