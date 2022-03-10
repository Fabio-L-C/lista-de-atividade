// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_de_atividade/models/assignment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentList with ChangeNotifier {
  List<Assignment> _assignmentList = [];

  List get assignmentList {
    return [..._assignmentList];
  }

  int get assignmentCount {
    return _assignmentList.length;
  }

  void addAssignment({
    required String title,
    required String description,
    String? id,
  }) {
    if (id == null) {
      _assignmentList.add(
        Assignment(
          id: Random().nextDouble().toString(),
          title: title,
          description: description.isEmpty ? '' : description,
          dateTime: DateTime.now(),
          isFinished: false,
        ),
      );
    } else {
      int index = _assignmentList.indexWhere((element) => element.id == id);
      _assignmentList[index] = Assignment(
        id: id,
        title: title,
        description: description,
        dateTime: _assignmentList[index].dateTime,
        isFinished: _assignmentList[index].isFinished,
      );
    }

    saveList();
    notifyListeners();
  }

  void removeAssignment(String id) {
    int index = _assignmentList.indexWhere((element) => element.id == id);
    _assignmentList.removeAt(index);

    saveList();
    notifyListeners();
  }

  saveList() async {
    final prefs = await SharedPreferences.getInstance();

    if (_assignmentList.isEmpty) {
      await prefs.remove('list');
    } else {
      List<String> listItems = [];

      for (Assignment item in _assignmentList) {
        listItems.add(jsonEncode(item.toMap()));
      }

      if (listItems.isNotEmpty) {
        await prefs.remove('list');
        await prefs.setStringList('list', <String>[...listItems]);
      }
    }
  }

  loadList() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('list');
    final List<String>? items = prefs.getStringList('list');

    if (items == null) {
      return;
    }

    var listItems = items.map((e) {
      var item = jsonDecode(e);

      return Assignment(
        id: item['id'].toString(),
        title: item['title'].toString(),
        description: item['description'].toString(),
        dateTime: DateTime.parse(item['dateTime']),
        isFinished: item['isFinished'],
      );
    });

    _assignmentList = listItems.isEmpty ? [] : [...listItems];
    notifyListeners();
  }
}
