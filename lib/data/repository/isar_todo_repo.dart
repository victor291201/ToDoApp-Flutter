import 'package:isar/isar.dart';
import 'package:to_o_pp/data/models/isar_todo.dart';
import 'package:to_o_pp/domain/models/todo.dart';
import 'package:to_o_pp/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo{
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future <List<Todo>> getTodos() async{
    final todos = await db.todoIsars.where().findAll();

    return todos.map((todoIsar)=>todoIsar.toDomain()).toList();
  }

  @override
  Future<void> addTodo(Todo newTodo) {
    final todoIsar = TodoIsar.fromDomain(newTodo);
    return db.writeTxn(()=>db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> updateTodo(Todo todo) {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(()=>db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async{
    await db.writeTxn(()=>db.todoIsars.delete(todo.id));
  }
}