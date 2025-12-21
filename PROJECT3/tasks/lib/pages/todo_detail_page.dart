import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

// 할 일 하나의 상세 내용을 보여주는 페이지
class ToDoDetailPage extends StatefulWidget {
  // 이전 화면(HomePage)에서 전달받은 할 일 데이터
  final ToDoEntity todo;
  const ToDoDetailPage({super.key, required this.todo});

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  // 현재 페이지의 상태를 관리할 변수 (현재 페이지 반영을 위해 필요)
  late ToDoEntity _currentTodo = widget.todo;

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
            // 뒤로 갈 때 최종적으로 변경된 데이터를 홈으로 전달 (과제 요건 준수)
            Navigator.pop(context, _currentTodo);
          },
        ),
        actions: [
          // 즐겨찾기 상태 토글 버튼
          IconButton(
            icon: Icon(
              _currentTodo.isFavorite ? Icons.star : Icons.star_border,
              color: const Color(0xFF8D7B68),
            ),
            onPressed: () {
              // 현재 페이지에 즉시 반영하기 위해 setState 사용
              setState(() {
                _currentTodo = _currentTodo.copyWith(
                  isFavorite: !_currentTodo.isFavorite,
                );
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(_currentTodo.description ?? ''), // 변경된 상태의 데이터를 표시
      ),
    );
  }
}
