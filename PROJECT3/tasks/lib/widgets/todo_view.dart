import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

// 할 일 하나를 리스트에서 보여주는 아이템 위젯
class ToDoView extends StatelessWidget {
  // 표시할 할 일 데이터
  final ToDoEntity todo;

  // 체크/즐겨찾기 상태가 바뀔 때 HomePage로 전달하는 콜백
  final ValueChanged<ToDoEntity> onChanged;

  // 아이템을 눌렀을 때 상세 페이지로 이동하기 위한 콜백
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
      // 아이템 전체를 눌렀을 때 상세 페이지로 이동
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // 리스트 아이템 카드 스타일
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF2EAD6),
        ),
        child: Row(
          children: [
            // 완료 여부 토글 버튼
            IconButton(
              icon: Icon(
                color: const Color(0xFF8D7B68),
                todo.isDone ? Icons.check_circle : Icons.circle_outlined,
              ),
              onPressed: () => onChanged(todo.copyWith(isDone: !todo.isDone)),
            ),

            // 할 일 제목 영역
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  // 완료된 할 일은 취소선 표시
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            // 즐겨찾기 토글 버튼
            IconButton(
              icon: Icon(
                todo.isFavorite ? Icons.star : Icons.star_border,
                color: const Color(0xFF8D7B68),
              ),
              onPressed: () =>
                  onChanged(todo.copyWith(isFavorite: !todo.isFavorite)),
            ),
          ],
        ),
      ),
    );
  }
}
