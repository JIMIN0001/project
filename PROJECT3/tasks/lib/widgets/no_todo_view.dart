import 'package:flutter/material.dart';

class NoTodoView extends StatelessWidget {
  final VoidCallback onAdd;
  const NoTodoView({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, //
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity, // 화면 너비(좌우 패딩 제외) 꽉
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(49, 91, 135, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/note.webp',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              const Text(
                '아직 할 일이 없어요!!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                '아래 버튼을 눌러\n새 할 일을 추가해보세요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
