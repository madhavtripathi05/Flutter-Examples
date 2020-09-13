import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_app/models/student.dart';

/*
  Firestore stores data within "documents",
  which are contained within "collections". 
  Documents can also contain nested collections.
  */

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference studentsRef = firestore.collection('students');

class DBService {
  // Realtime Changes in DB
  Stream studentsStream = studentsRef.snapshots();

  // Adding Item to DB
  Future<void> addStudent(Student student) async {
    try {
      // this will add new document with auto generated id
      //* await studentsRef.add(student.toJson());
      // if you want to specify your id:
      await studentsRef.doc('${student.id}').set(student.toJson());
    } catch (e) {
      print(e);
    }
  }

  // Updating student data
  Future<void> updateStudent(Student student) async {
    try {
      await studentsRef.doc('${student.id}').update(student.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteStudent(Student student) async {
    try {
      // updating student data
      await studentsRef.doc('${student.id}').delete();
    } catch (e) {
      print(e);
    }
  }

  // Querying Items from DB
  Future getStudentsWhere(String key, dynamic value) async {
    return studentsRef
        .where('age', isLessThan: 21)
        .orderBy('age', descending: true)
        .get();
  }

  /*
   Firestore provides out of the box support for offline capabilities. 
   When reading and writing data, Firestore uses a local database which 
   automatically synchronizes with the server.
  */
}
