import 'package:flutter/material.dart';
import 'package:lista_de_atividade/models/assignment_list.dart';
import 'package:lista_de_atividade/pages/assignment_form_page.dart';
import 'package:lista_de_atividade/pages/home_page.dart';
import 'package:lista_de_atividade/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssignmentList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const HomePage(),
        routes: {
          AppRoutes.HOME_PAGE: (ctx) => const HomePage(),
          AppRoutes.ASSIGNMENT_FORM: (ctx) => const AssignmentFormPage(),
        },
      ),
    );
  }
}
