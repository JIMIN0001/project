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
  // 할 일 목록 데이터를 저장하는 리스트
  final List<ToDoEntity> _todos = [];

  // 새 할 일을 추가하기 위해 BottomSheet를 띄우는 함수
  Future<void> _addTodo() async {
    // showModalBottomSheet를 통해 사용자 입력을 받음
    final todo = await showModalBottomSheet<ToDoEntity>(
      context: context,
      isScrollControlled: true, // 키보드가 올라올 때 시트가 가려지지 않도록 설정
      backgroundColor: const Color(0xFFF2EAD6), // 시트 전체 배경색 통일
      shape: const RoundedRectangleBorder(
        // 시트 상단 모서리 둥글게
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => _AddTodoBottomSheet(),
    );

    // 입력받은 데이터가 null이 아니면 리스트에 추가하고 화면 갱신
    if (todo != null) {
      setState(() => _todos.add(todo));
    }
  }

  // 특정 인덱스의 할 일을 업데이트하는 함수 (체크박스 상태 등 변경 시 사용)
  void _updateTodo(int index, ToDoEntity updated) {
    setState(() => _todos[index] = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 전체 배경색 설정
      backgroundColor: const Color(0xFFFFFBEB),
      // 키보드 호출 시 화면이 위로 밀려 올라가는 현상 방지
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2EAD6),
        title: const Text(
          "지민's Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        // 할 일 목록이 비었는지 여부에 따라 다른 화면을 보여줌 (삼항 연산자)
        child: _todos.isEmpty
            ? NoTodoView(onAdd: _addTodo) // 목록이 비었을 때 보여줄 위젯
            : ListView.separated(
                // 목록이 있을 때 보여줄 리스트 뷰
                padding: const EdgeInsets.only(top: 20), // 리스트 상단 여백
                itemCount: _todos.length, // 아이템 개수
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 8), // 아이템 사이 간격
                itemBuilder: (context, index) {
                  final todo = _todos[index];

                  return ToDoView(
                    todo: todo,
                    // 체크/즐겨찾기 변경 시, 해당 할 일 상태를 리스트에 반영
                    onChanged: (updated) => _updateTodo(index, updated),
                    // 항목 클릭 시 상세 페이지로 이동
                    onTap: () async {
                      final result = await Navigator.push<ToDoEntity>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ToDoDetailPage(todo: todo),
                        ),
                      );
                      // 상세 페이지에서 수정 후 돌아왔을 때 반영
                      if (result != null) {
                        _updateTodo(index, result);
                      }
                    },
                  );
                },
              ),
      ),

      // 우측 하단 할 일 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: const Color(0xFF8D7B68),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// 새 할 일을 입력받는 BottomSheet 위젯
class _AddTodoBottomSheet extends StatelessWidget {
  //글자 입력 상태를 고정해주는 장치
  final TextEditingController _titleController = TextEditingController();
  _AddTodoBottomSheet();

  @override
  Widget build(BuildContext context) {
    String title = ''; // 제목 저장 변수
    String? description; // 상세 내용 저장 변수
    bool isFavorite = false; // 중요 표시 여부
    bool showDesc = false; // 상세 내용 입력 필드 표시 여부

    // 입력 데이터를 ToDoEntity 객체로 만들어 반환하고 시트를 닫는 함수
    void saveToDo() {
      final t = title.trim();
      if (t.isEmpty) return; // 제목이 비어있으면 저장 안 함

      Navigator.of(context).pop(
        ToDoEntity(
          title: t,
          description: (description == null || description!.trim().isEmpty)
              ? null
              : description!.trim(),
          isFavorite: isFavorite,
          isDone: false, // 처음 생성 시엔 항상 미완료 상태
        ),
      );
    }

    // 모달 내에서 로컬 상태 변경을 위해 StatefulBuilder 사용
    return StatefulBuilder(
      builder: (context, setModalState) {
        // 제목이 입력되어야 저장 버튼 활성화
        final isSaveEnabled = title.trim().isNotEmpty;

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            // 키보드 높이만큼 하단 패딩을 주어 입력 필드가 가려지지 않게 함
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 내용만큼만 높이 차지
            children: [
              // 제목 입력 필드
              TextField(
                controller: _titleController,
                autofocus: true,
                cursorColor: const Color(0xFF8D7B68), // 커서 색상
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

              // 상세 정보 토글, 중요 표시, 저장 버튼이 있는 행
              Row(
                children: [
                  if (!showDesc) // 상세 내용 필드가 닫혀있을 때만 표시
                    IconButton(
                      onPressed: () => setModalState(() => showDesc = true),
                      icon: const Icon(
                        Icons.short_text_rounded,
                        size: 24,
                        color: Color(0xFF8D7B68),
                      ),
                    ),
                  // 중요(별표) 버튼
                  IconButton(
                    onPressed: () =>
                        setModalState(() => isFavorite = !isFavorite),
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: const Color(0xFF8D7B68),
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  // 저장 버튼
                  TextButton(
                    onPressed: isSaveEnabled ? saveToDo : null,
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: isSaveEnabled
                            ? const Color(0xFF8D7B68)
                            : Color(0xFF8D7B68).withValues(alpha: 0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // 상세정보 입력 필드 (아이콘 클릭 시에만 나타남)
              if (showDesc) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        // 커서 색상 통일
                        cursorColor: const Color(0xFF8D7B68),
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: '세부정보 추가',
                          //하단 선 삭제
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        maxLines: null,
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
