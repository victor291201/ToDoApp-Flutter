import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:to_o_pp/data/models/isar_todo.dart';
import 'package:to_o_pp/data/repository/isar_todo_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_o_pp/domain/repository/todo_repo.dart';
import 'package:to_o_pp/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  final isarTodoRepo = IsarTodoRepo(isar);
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
