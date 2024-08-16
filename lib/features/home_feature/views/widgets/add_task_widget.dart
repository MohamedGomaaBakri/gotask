import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/color.dart';
import 'package:todo/utils/widgets/custom_text_form_field.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {

  late String title;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  CollectionReference Tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask() {
    return Tasks
        .add({
      'title': title,
      'createdAt': DateTime.now(),
      'isCompleted': false,
      'uId' : FirebaseAuth.instance.currentUser!.uid,
      'taskId' : FirebaseAuth.instance.currentUser!.uid + DateTime.now().toString(),

    })
        .then((value) => log('Task Added'))
        .catchError((error) => log("Failed to add task: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children:
        [
          Row(
            children:
            [
              const Checkbox(value: false, onChanged: null),

              Expanded(
                child: CustomTextFormField(
                    textInputType: TextInputType.text ,
                    hintText: 'Add Task',
                    onSaved: (p0)
                    {
                      title = p0!;
                    }
                ),
              ),
              IconButton(
                  onPressed: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      formKey.currentState!.save();
                      addTask();
                      Navigator.pop(context);
                      
                      
                    }else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }


                  } ,
                  icon:  const Icon(
                      Icons.send ,
                      color: AppColor.primaryColor,
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}

