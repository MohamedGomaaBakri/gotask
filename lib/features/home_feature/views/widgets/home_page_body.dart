import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/color.dart';
import 'package:todo/features/auth_feature/presentation/views/login_view.dart';
import 'package:todo/utils/services/shared_prefs.dart';
import 'all_tasks_body.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    final userEmail = currentUser?.email;
    final String userDisplayName = userEmail != null ? userEmail.split('@').first : 'User';
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title : Text(
            userDisplayName,
            style: const TextStyle(
              color: AppColor.primaryColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: ()
                {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                  Prefs.setBool('isLoggedIn', false);
                },
                icon: const Icon(
                    Icons.exit_to_app_outlined ,
                  color: AppColor.primaryColor,
                ),
              ),
            ),

          ],
          bottom: const TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            indicatorColor:Color(0xff00BF54),
            labelColor: Color(0xff00BF54),
            unselectedLabelColor: AppColor.primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        body:   const TabBarView(
          children: [
            Center(
                child: AllTasksBody(isCompletedTab: false,),
            ),
            Center(
              child: AllTasksBody(isCompletedTab: true,),
            ),
          ],
        ),
      ) ,
    );
  }
}
