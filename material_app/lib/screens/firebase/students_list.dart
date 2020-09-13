import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_app/models/student.dart';
import 'package:material_app/services/db_service.dart';

class StudentsList extends StatelessWidget {
  static const routeName = '/students-list';
  final db = DBService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students List'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<Student> students = snapshot.data?.docs
                  ?.map((s) => Student.fromJson(s.data()))
                  ?.toList() ??
              [];
          students.forEach((element) {
            print(element.name);
          });
          if (!snapshot.hasData) {
            return Text('Error');
          }
          if (students.length == 0) {
            return Center(child: Text('No Students Found, start Adding some'));
          }

          return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: GestureDetector(
                    child: Icon(Icons.edit, color: Colors.blue),
                    onTap: () async {
                      await db.updateStudent(
                        Student(
                          age: students[index].age,
                          name: students[index].name,
                          id: students[index].id,
                          email:
                              '${DateTime.now().millisecondsSinceEpoch}@student.com',
                          phoneNo: students[index].phoneNo,
                        ),
                      );
                    },
                  ),
                  title: Text('${students[index].name}'),
                  subtitle: Text('${students[index].email}'),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete, color: Colors.red),
                    onTap: () async {
                      await db.deleteStudent(students[index]);
                    },
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          db.addStudent(
            Student(
                age: Random().nextInt(25),
                name: 'Student ${DateTime.now().millisecondsSinceEpoch}',
                id: '${DateTime.now().millisecondsSinceEpoch}',
                email: '${DateTime.now().millisecondsSinceEpoch}@student.com',
                phoneNo: '9277251612'),
          );
        },
      ),
    );
  }
}
