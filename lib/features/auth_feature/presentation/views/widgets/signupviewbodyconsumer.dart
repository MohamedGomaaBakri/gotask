import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signup_cubit/signup_cubit.dart';

import 'signup_view_body.dart';

class Signupviewbodyconsumer extends StatelessWidget {
  const Signupviewbodyconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if(state is SignupSuccess){
          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(
              backgroundColor: Color(0xFF2D9F5D),
              content: Text('Account created successfully'),
            ),
          );
        }else if(state is SignupError){
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
            inAsyncCall: state is SignupLoading ? true : false,
            child: const SignupViewBody()
        );
      },
    );
  }
}
