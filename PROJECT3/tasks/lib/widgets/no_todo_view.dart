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
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.note_alt, size: 100),
              SizedBox(height: 12),
              Text(
                '아직 할 일이 없어요!!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                "아래 버튼을 눌러\n새 할 일을 추가해보세요.",
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
