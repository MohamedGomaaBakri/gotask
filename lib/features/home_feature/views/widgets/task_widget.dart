import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/color.dart';
import 'package:todo/features/home_feature/views/widgets/edit_modal_sheet.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.taskId,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();

  final String taskName;
  final bool isCompleted;
  final String taskId;
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isCompleted;
  }

  void toggleTaskCompletion(bool? value) {
    setState(() {
      isChecked = value!;
    });

    FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .update({'isCompleted': isChecked});
  }

  void deleteTask() {
    FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: ValueKey(widget.taskId),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {

                showModalBottomSheet(
                    context: context,
                    builder: (context) =>  EditModalBottomSheet(taskName: widget.taskName, taskId: widget.taskId),
                );


              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.taskName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Checkbox(
                activeColor: AppColor.primaryColor,
                value: isChecked,
                onChanged: toggleTaskCompletion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
