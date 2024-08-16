import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/home_feature/views/widgets/add_task_widget.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,

        ),
        child:const AddTaskWidget(),
      ),
    );
  }
}
