import 'package:flutter/material.dart';
import 'package:lista_de_atividade/components/assignment_item.dart';
import 'package:lista_de_atividade/models/assignment_list.dart';
import 'package:lista_de_atividade/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assignmentList = Provider.of<AssignmentList>(context, listen: false);
    assignmentList.loadList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Consumer<AssignmentList>(
        builder: (context, value, child) => assignmentList.assignmentCount != 0
            ? ListView.builder(
                itemCount: assignmentList.assignmentCount,
                itemBuilder: (ctx, index) {
                  return AssignmentItem(
                      assignment: assignmentList.assignmentList[index]);
                },
              )
            : const Center(
                child: Text('Nenhuma tarefa cadastrada'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.ASSIGNMENT_FORM);
        },
      ),
    );
  }
}
