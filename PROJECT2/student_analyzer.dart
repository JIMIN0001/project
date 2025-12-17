import 'dart:io';

/// 점수만 나타내는 부모 클래스 Score
class Score {
  int score;

  Score(this.score);

  void showInfo() {
    print('점수: $score');
  }
}

/// 학생 이름 + 점수를 나타내는 자식 클래스 StudentScore extends Score
class StudentScore extends Score {
  String name;

  StudentScore({required this.name, required int score}) : super(score);

  @override
  void showInfo() {
    print('이름: $name, 점수: $score');
  }
}

/// students.txt 파일을 읽어서 List<StudentScore>로 만들어 주는 함수
List<StudentScore> loadStudentData(String filePath) {
  final List<StudentScore> students = [];

  try {
    final file = File(filePath);

    if (!file.existsSync()) {
      print("파일을 찾을 수 없습니다: $filePath");
      exit(1);
    }

    final lines = file.readAsLinesSync();

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      final parts = line.split(',');
      if (parts.length != 2) {
        throw FormatException('잘못된 데이터 형식: $line');
      }

      final String name = parts[0].trim();
      final int score = int.parse(parts[1].trim());

      students.add(StudentScore(name: name, score: score));
    }
  } catch (e) {
    print("학생 데이터를 불러오는 데 실패했습니다: $e");
    exit(1);
  }

  return students;
}

/// 1번 기능: 우수생(평균 점수가 가장 높은 학생) 출력
void showTopStudent(List<StudentScore> students) {
  if (students.isEmpty) {
    print("학생 데이터가 없습니다.");
    return;
  }

  // 이름별로 점수들을 모아두는 Map
  final Map<String, List<int>> scoreMap = {};

  for (final s in students) {
    scoreMap.putIfAbsent(s.name, () => []);
    scoreMap[s.name]!.add(s.score);
  }

  String topName = scoreMap.keys.first;
  double topAverage = -1;

  scoreMap.forEach((name, scores) {
    final int sum = scores.fold(0, (acc, v) => acc + v);
    final double avg = sum / scores.length;

    if (avg > topAverage) {
      topAverage = avg;
      topName = name;
    }
  });

  print("우수생: $topName (평균 점수: ${topAverage.toStringAsFixed(2)})");
}

/// 2번 기능: 전체 평균 점수 출력
void showOverallAverage(List<StudentScore> students) {
  if (students.isEmpty) {
    print("학생 데이터가 없습니다.");
    return;
  }

  final int sum = students.map((s) => s.score).fold(0, (acc, v) => acc + v);
  final double avg = sum / students.length;

  print("전체 평균 점수: ${avg.toStringAsFixed(2)}");
}

void main() {
  // 1) 파일에서 학생 데이터 읽어오기
  final List<StudentScore> students = loadStudentData("students.txt");

  // 2) 메뉴 방식 반복
  while (true) {
    print("===== 학생 성적 분석 프로그램 =====");
    print("1. 우수생 보기");
    print("2. 전체 평균 점수 보기");
    print("0. 종료");
    stdout.write("번호를 입력하세요: ");

    String? input = stdin.readLineSync();
    if (input == null) {
      print("입력을 다시 시도해주세요.\n");
      continue;
    }

    input = input.trim();

    if (input == "1") {
      showTopStudent(students);
    } else if (input == "2") {
      showOverallAverage(students);
    } else if (input == "0") {
      print("프로그램을 종료합니다.");
      break;
    } else {
      print("잘못된 번호입니다. 다시 입력해주세요.");
    }

    print(""); // 한 줄 띄우기
  }
}
