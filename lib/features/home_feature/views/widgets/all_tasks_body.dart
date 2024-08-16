import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/color.dart';
import 'package:todo/features/home_feature/views/widgets/task_widget.dart';
import 'modal_bottom_sheet.dart';

class AllTasksBody extends StatefulWidget {
  const AllTasksBody({super.key, required this.isCompletedTab});
  final bool isCompletedTab;
  @override
  State<AllTasksBody> createState() => _AllTasksBodyState();
}

class _AllTasksBodyState extends State<AllTasksBody> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('isCompleted', isEqualTo: widget.isCompletedTab)
            .where('uId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              key: ValueKey(widget.isCompletedTab),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                return TaskWidget(
                    taskName: '${snapshot.data!.docs[index]['title']}',
                  isCompleted: doc['isCompleted'],
                  taskId: doc.id,
                );
              },
            );
          }else if(snapshot.hasError){
            log('snapshot.hasError ${snapshot.error}');
            return Text('${snapshot.error}');
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: ()
        {
          showModalBottomSheet(
              context: context,
              builder: (context) => const
              ModalBottomSheet()
          );
        },
        child: const Icon(
          size: 40,
            Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
