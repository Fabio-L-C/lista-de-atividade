import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_atividade/models/assignment.dart';
import 'package:lista_de_atividade/models/assignment_list.dart';
import 'package:provider/provider.dart';

class AssignmentFormPage extends StatefulWidget {
  const AssignmentFormPage({Key? key}) : super(key: key);

  @override
  State<AssignmentFormPage> createState() => _AssignmentFormPageState();
}

class _AssignmentFormPageState extends State<AssignmentFormPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Assignment? assignment =
        ModalRoute.of(context)?.settings.arguments as Assignment?;

    void _onSubmit() {
      if (_titleController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        return;
      }

      Provider.of<AssignmentList>(context, listen: false).addAssignment(
        title: _titleController.text,
        description: _descriptionController.text,
        id: assignment?.id,
      );

      _titleController.clear();
      _descriptionController.clear();

      Navigator.of(context).pop();
    }

    final appBar = AppBar(
      title: const Text('Criar uma nova tarefa'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: _onSubmit,
        ),
      ],
    );

    if (assignment != null) {
      _titleController.text = assignment.title;
      _descriptionController.text = assignment.description;
    }

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: double.infinity,
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      maxLength: 30,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Escreva o titulo",
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        102,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Escreva a descrição da tarefa"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
