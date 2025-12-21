import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

// 할 일 하나의 상세 내용을 보여주는 페이지
class ToDoDetailPage extends StatelessWidget {
  // 이전 화면(HomePage)에서 전달받은 할 일 데이터
  final ToDoEntity todo;

  const ToDoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 메인 홈페이지와 동일한 아이보리 배경색 적용
      backgroundColor: const Color(0xFFFFFBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2EAD6),
        // 뒤로 가기 버튼 → 이전 화면으로 돌아가며 todo 전달
        leading: BackButton(
          color: const Color(0xFF8D7B68),
          onPressed: () {
            Navigator.pop(context, todo);
          },
        ),
        actions: [
          // 즐겨찾기 상태 토글 버튼
          IconButton(
            icon: Icon(
              todo.isFavorite ? Icons.star : Icons.star_border,
              color: const Color(0xFF8D7B68),
            ),
            onPressed: () {
              // 즐겨찾기 값을 변경한 todo를 만들어 이전 화면으로 전달
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
        // 할 일의 상세 설명 표시 (없으면 빈 문자열)
        child: Text(todo.description ?? ''),
      ),
    );
  }
}
