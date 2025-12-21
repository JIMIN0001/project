import 'package:flutter/material.dart';
import 'pages/home_page.dart';

// 앱 실행 시작점
void main() {
  runApp(const MyApp());
}

// 앱 전체 뼈대(MaterialApp)를 만드는 최상위 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 오른쪽 위 DEBUG 배너 숨김
      debugShowCheckedModeBanner: false,

      // 앱을 켰을 때 처음 보여줄 화면
      home: const HomePage(),
    );
  }
}
