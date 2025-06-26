import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.report, 'label': '신고하기'},
    {'icon': Icons.place, 'label': '흡연장 찾기'},
    {'icon': Icons.access_time, 'label': '금연 효과'},
    {'icon': Icons.person, 'label': '마이 페이지'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CleanZone 홈')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16), // 리스트를 아래로 내림
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: menuItems.map((item) {
            return GestureDetector(
              onTap: () {
                print('${item['label']} 클릭됨');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 3.0, // 테두리 굵게
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 50, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(item['label'], style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
