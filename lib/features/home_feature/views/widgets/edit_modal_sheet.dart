import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/home_feature/views/widgets/edit_task_widget.dart';

class EditModalBottomSheet extends StatelessWidget {
  const EditModalBottomSheet({super.key, required this.taskName, required this.taskId});
  final String taskName;
  final String taskId;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,

        ),
        child: EditTaskWidget(
          title: taskName ,
          taskId: taskId,
        ),
      ),
    );
  }
}
