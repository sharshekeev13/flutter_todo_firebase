import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_firebase/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  //CREATE
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //UPDATE
  void updateTask(String? docId, bool? valueUpdate) {
    todoCollection.doc(docId).update({'isDone': valueUpdate});
  }

  //DELETE
  void deleteTask(String? docId) {
    todoCollection.doc(docId).delete();
  }
}
