import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

class ToDoView extends StatelessWidget {
  final ToDoEntity todo;
  final ValueChanged<ToDoEntity> onChanged;
  final VoidCallback onTap;

  const ToDoView({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                todo.isDone ? Icons.check_circle : Icons.circle_outlined,
              ),
              onPressed: () => onChanged(todo.copyWith(isDone: !todo.isDone)),
            ),

            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            IconButton(
              icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
              onPressed: () =>
                  onChanged(todo.copyWith(isFavorite: !todo.isFavorite)),
            ),
          ],
        ),
      ),
    );
  }
}
