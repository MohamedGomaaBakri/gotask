import 'package:flutter/material.dart';
import 'package:todo/features/onBoarding_feature/presentation/views/widgets/page_view_item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, required this.myController});
  final PageController myController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: myController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: const [
        PageViewItem(
          title: 'Task Management & To-Do List',
          subtitle:
              'This productive tool is designed to help you better manage your task project-wise conveniently!',
        ),
        PageViewItem(
          title: 'Manage',
          subtitle:
              'Manage your tasks and projects in one place. Add, edit, and delete tasks, and organize projects by priority, status, and deadline.',
        ),
        PageViewItem(
          title: 'Keep',
          subtitle:
              'Keep track of your tasks and projects in one place. Add, edit, and delete tasks, and organize projects by priority, status, and deadline.',
        ),
      ],
    );
  }
}
