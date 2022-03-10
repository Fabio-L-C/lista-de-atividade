import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_atividade/models/assignment.dart';
import 'package:lista_de_atividade/models/assignment_list.dart';
import 'package:lista_de_atividade/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AssignmentItem extends StatefulWidget {
  final Assignment assignment;
  const AssignmentItem({Key? key, required this.assignment}) : super(key: key);

  @override
  State<AssignmentItem> createState() => _AssignmentItemState();
}

class _AssignmentItemState extends State<AssignmentItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Dismissible(
        key: Key(widget.assignment.id),
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 8,
          child: ListTile(
            title: Text(
              widget.assignment.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.assignment.dateTime)),
            trailing: Checkbox(
                value: widget.assignment.isFinished,
                onChanged: (value) {
                  setState(() {
                    widget.assignment.switchStatus();
                    Provider.of<AssignmentList>(
                      context,
                      listen: false,
                    ).saveList();
                  });
                }),
          ),
        ),
        onDismissed: (direction) {
          Provider.of<AssignmentList>(context, listen: false)
              .removeAssignment(widget.assignment.id);
        },
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.ASSIGNMENT_FORM,
          arguments: widget.assignment,
        );
      },
    );
  }
}
