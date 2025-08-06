// map_page.dart
import 'package:flutter/material.dart';

class Mypagepage extends StatelessWidget {
  const Mypagepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("신고 페이지")),
      body: const Center(
        child: Text("여기에 지도를 띄우세요"),
      ),
    );
  }
}
