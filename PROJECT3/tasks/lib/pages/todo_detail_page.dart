import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

class ToDoDetailPage extends StatelessWidget {
  final ToDoEntity todo;
  const ToDoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, todo);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
            onPressed: () {
              Navigator.pop(
                context,
                todo.copyWith(isFavorite: !todo.isFavorite),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(todo.description ?? ''),
      ),
    );
  }
}
