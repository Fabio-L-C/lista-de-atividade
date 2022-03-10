import 'package:flutter/material.dart';

class Assignment with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  bool isFinished;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isFinished,
  });

  void switchStatus() {
    isFinished = !isFinished;

    notifyListeners();
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toString(),
      'isFinished': isFinished,
    };
    return map;
  }

  @override
  String toString() {
    return 'id: $id, title: $title, description: $description, dateTime: $dateTime, isFinished: $isFinished';
  }
}
