import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:todo/features/auth_feature/presentation/views/widgets/login_view_body.dart';
import 'package:todo/features/home_feature/views/homa_page.dart';

class Loginviewbodyconsumer extends StatelessWidget {
  const Loginviewbodyconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF2D9F5D),
              content: Text('Logged in successfully'),
            ),
          );
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false);
        } else if (state is SigninError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SigninLoading ? true : false,
        child: const LoginViewBody());
      },
    );
  }
}
