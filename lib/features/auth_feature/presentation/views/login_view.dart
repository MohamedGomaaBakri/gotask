import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/auth_feature/data/repos_impl/repo_ipml.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:todo/utils/services/firebase_services.dart';
import 'widgets/loginviewbodyconsumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'loginPage';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => SigninCubit(
            RepoIpml(
              firebaseServices: FirebaseServices(),
            )),
        child: const Loginviewbodyconsumer(),
      ),
    );
  }
}
