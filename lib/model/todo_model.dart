// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docId;
  final String titleTask;
  final String descriptionsTask;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool isDone;

  TodoModel({
    this.docId,
    required this.titleTask,
    required this.descriptionsTask,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titleTask': titleTask,
      'descriptionsTask': descriptionsTask,
      'category': category,
      'dateTask': dateTask,
      'timeTask': timeTask,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docId: map['docId'] != null ? map['docId'] as String : null,
      titleTask: map['titleTask'] as String,
      descriptionsTask: map['descriptionsTask'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TodoModel.fromShapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docId: doc.id,
      titleTask: doc['titleTask'],
      descriptionsTask: doc['descriptionsTask'],
      category: doc['category'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
      isDone: doc['isDone'],
    );
  }
}
