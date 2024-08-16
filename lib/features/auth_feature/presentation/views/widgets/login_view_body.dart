import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:todo/utils/services/shared_prefs.dart';
import 'package:todo/utils/widgets/custom_button.dart';
import 'package:todo/utils/widgets/custom_password_field.dart';
import 'package:todo/utils/widgets/custom_text_form_field.dart';
import 'custom_divider.dart';
import 'custom_social_container.dart';
import 'signup_text.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    'assets/images/background.svg',
                    fit: BoxFit.cover,
                  ),
                ),

                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '  To-Do ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Login in to your account',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              CustomTextFormField(
                                textInputType: TextInputType.emailAddress,
                                hintText: 'Enter your email',
                                onSaved: (value) {
                                  email = value!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomPasswordField(
                                onSaved: (value) {
                                  password = value!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  formKey.currentState!.save();
                                  if (email.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Please enter your email'),
                                      ),
                                    );
                                    return;
                                  }
                                  try {
                                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Color(0xFF2D9F5D),
                                        content: Text('Password reset link has been sent to your email'),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Failed to send password reset link, please make sure your email is correct'),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Forgot Your Password ?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF2D9F5D),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomButton(
                                text: 'Login',
                                onPressed: () {
                                  formKey.currentState!.save();
                                  if (formKey.currentState!.validate()) {
                                    context.read<SigninCubit>().signInWithEmailAndPassword(email, password);
                                    Prefs.setBool('isLoggedIn', true);
                                  } else {
                                    autoValidateMode = AutovalidateMode.always;
                                    setState(() {});
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const CustomDivider(),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSocialContainer(
                                    onTap: () {
                                      context.read<SigninCubit>().signInWithGoogle();
                                      Prefs.setBool('isLoggedIn', true);
                                    },
                                    image: 'assets/images/SocialgoogleIcon.svg',
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  CustomSocialContainer(
                                    onTap: () {
                                      context.read<SigninCubit>().signInWithFacebook();
                                      Prefs.setBool('isLoggedIn', true);
                                    },
                                    image: 'assets/images/SocialFaceBookIcon.svg',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const SignupText(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
