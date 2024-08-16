import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/features/auth_feature/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:todo/utils/widgets/custom_button.dart';
import 'package:todo/utils/widgets/custom_password_field.dart';
import 'package:todo/utils/widgets/custom_text_form_field.dart';
import 'terms_and_condition_widget.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String name, email, password;
  late bool isAccepted = false;

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
                    fit: BoxFit.cover, // استخدم BoxFit.cover لتغطية الخلفية بالكامل
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
                      'Sign Up to get started',
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
                                textInputType: TextInputType.name,
                                hintText: 'Enter your name',
                                onSaved: (value) {
                                  name = value!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
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
                              const SizedBox(
                                height: 16,
                              ),
                              TermsAndConditionWidget(
                                onChanged: (value) {
                                  isAccepted = value;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    if (isAccepted) {
                                      context.read<SignupCubit>().createUserWithEmailAndPassword(
                                        email,
                                        password,
                                        name,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Please accept terms and conditions'),
                                        ),
                                      );
                                    }
                                  } else {
                                    autoValidateMode = AutovalidateMode.always;
                                    setState(() {});
                                  }
                                },
                                text: 'Sign Up',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Have an account? Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF2D9F5D),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
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
