import 'package:flutter/material.dart';

class Task {
  String title;
  String subject;
  DateTime deadline;
  String note;
  bool isDone;

  Task({
    required this.title,
    required this.subject,
    required this.deadline,
    required this.note,
    this.isDone = false,
  });
}

void main(){
  runApp(const StudentTaskManager());
}

class StudentTaskManager extends StatelessWidget {
  const StudentTaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar : AppBar(
          title: const Text('Student Task Manager'),
        ),

        body: const Center(
          child: Text(
            'Belum ada tugas',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}