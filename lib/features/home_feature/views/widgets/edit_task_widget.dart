import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/color.dart';
import 'package:todo/utils/widgets/custom_text_form_field.dart';

class EditTaskWidget extends StatefulWidget {
  final String? title;
  final String? taskId;
  final bool isCompleted;

  const EditTaskWidget({
    super.key,
    this.title,
    this.taskId,
    this.isCompleted = false,
  });

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  late String title;
  late bool isCompleted;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> saveTask() async {
    if (widget.taskId != null) {
      return tasks.doc(widget.taskId).update({
        'title': title,
        'isCompleted': isCompleted,
      }).then((value) => log('Task Updated'))
          .catchError((error) => log("Failed to update task: $error"));
    } else {
      return tasks.add({
        'title': title,
        'createdAt': DateTime.now(),
        'isCompleted': isCompleted,
        'uId': FirebaseAuth.instance.currentUser!.uid,
      }).then((value) => log('Task Added'))
          .catchError((error) => log("Failed to add task: $error"));
    }
  }

  @override
  void initState() {
    super.initState();
    title = widget.title ?? '';
    isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: (value) {
                  setState(() {
                    isCompleted = value!;
                  });
                },
              ),
              Expanded(
                child: CustomTextFormField(
                  initialValue: title,
                  textInputType: TextInputType.text,
                  hintText: 'Add Task',
                  onSaved: (p0) {
                    title = p0!;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    saveTask();
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
