import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/auth_feature/presentation/views/login_view.dart';
import 'package:todo/features/onBoarding_feature/presentation/views/widgets/custom_page_view.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/services/shared_prefs.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {

  late PageController myController;
  var pageIndex = 0;
  @override
  void initState() {
    super.initState();
    myController = PageController();
    myController.addListener(() {
      setState(() {
        pageIndex = myController.page!.round();

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
           Expanded(
            child: CustomPageView(
              myController: myController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DotsIndicator(
                  position: pageIndex.toDouble(),
                  dotsCount: 3,
                  decorator:  DotsDecorator(
                    activeSize: const Size(15, 15),
                    size: const Size(10, 10),
                    color:  const Color(0xff1b506f).withOpacity(0.5) ,
                    activeColor:  const Color(0xff1b506f) ,
                  ),
                ),
                Visibility(
                  visible: pageIndex == 2,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(60, 70),
                      backgroundColor: const Color(0xff1b506f) ,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: ()
                    {
                      Prefs.setBool(kIsOnBoardingViewSeen, true);
                        Navigator.pushReplacementNamed(context, LoginView.routeName);
                    } ,
                      child: const Icon(Icons.arrow_forward_ios ,
                        color: Colors.white,
                      ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
