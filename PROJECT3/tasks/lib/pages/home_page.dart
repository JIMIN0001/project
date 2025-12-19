import 'package:flutter/material.dart';
import '../models/todo_entity.dart';
import '../widgets/no_todo_view.dart';
import '../widgets/todo_view.dart';
import 'todo_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDoEntity> _todos = [];

  Future<void> _addTodo() async {
    final todo = await showModalBottomSheet<ToDoEntity>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AddTodoBottomSheet(),
    );

    if (todo != null) {
      setState(() => _todos.add(todo));
    }
  }

  void _updateTodo(int index, ToDoEntity updated) {
    setState(() => _todos[index] = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 191, 210),
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: const Text(
          "지민's Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _todos.isEmpty
            ? NoTodoView(onAdd: _addTodo)
            : ListView.separated(
                padding: const EdgeInsets.only(top: 20), // 리스트가 있을 때의 간격
                itemCount: _todos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final todo = _todos[index];

                  return ToDoView(
                    todo: todo,
                    onChanged: (updated) => _updateTodo(index, updated),
                    onTap: () async {
                      final result = await Navigator.push<ToDoEntity>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ToDoDetailPage(todo: todo),
                        ),
                      );
                      if (result != null) {
                        _updateTodo(index, result);
                      }
                    },
                  );
                },
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _AddTodoBottomSheet extends StatelessWidget {
  const _AddTodoBottomSheet();

  @override
  Widget build(BuildContext context) {
    String title = '';
    String? description;
    bool isFavorite = false;
    bool showDesc = false;

    void saveToDo() {
      final t = title.trim();
      if (t.isEmpty) return;

      Navigator.of(context).pop(
        ToDoEntity(
          title: t,
          description: (description == null || description!.trim().isEmpty)
              ? null
              : description!.trim(),
          isFavorite: isFavorite,
          isDone: false,
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, setModalState) {
        final isSaveEnabled = title.trim().isNotEmpty;

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: '새 할 일',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
                onChanged: (v) => setModalState(() => title = v),
                onSubmitted: (_) {
                  if (!isSaveEnabled) return;
                  saveToDo();
                },
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  if (!showDesc)
                    IconButton(
                      onPressed: () => setModalState(() => showDesc = true),
                      icon: const Icon(Icons.short_text_rounded, size: 24),
                    ),
                  IconButton(
                    onPressed: () =>
                        setModalState(() => isFavorite = !isFavorite),
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: isSaveEnabled ? saveToDo : null,
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: isSaveEnabled ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              if (showDesc) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(hintText: '세부정보 추가'),
                        maxLines: null, // 줄바꿈
                        onChanged: (v) => setModalState(() => description = v),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
