import 'package:flutter/material.dart';

// 할 일이 하나도 없을 때 보여주는 안내 화면 위젯
class NoTodoView extends StatelessWidget {
  // HomePage에서 전달받은 "할 일 추가" 함수
  final VoidCallback onAdd;

  const NoTodoView({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Align(
      // 화면 상단 중앙에 위치
      alignment: Alignment.topCenter,
      child: Container(
        // 가로는 패딩을 제외한 화면 전체 사용
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // 빈 상태를 강조하기 위한 배경색과 둥근 모서리
          color: const Color(0xFFF2EAD6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // 내용 크기만큼만 높이 차지
          mainAxisSize: MainAxisSize.min,
          children: [
            // 할 일이 없음을 보여주는 이미지
            Image.asset(
              'assets/note.webp',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),

            // 안내 제목 문구
            const Text(
              '아직 할 일이 없어요!!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // 할 일 추가를 유도하는 설명 문구
            const Text(
              '아래 버튼을 눌러\n새 할 일을 추가해보세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
