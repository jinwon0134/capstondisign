import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _mainButton(context, '신고하기', () {}),
              const SizedBox(height: 20),
              _mainButton(context, '흡연장 찾기', () {}),
              const SizedBox(height: 20),
              _mainButton(context, '금연 시간', () {}, subtitle: '1일 10시간 31분 15초'),
              const SizedBox(height: 20),
              _mainButton(context, '절약한 금액', () {}, subtitle: '6,700.64₩'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainButton(BuildContext context, String title, VoidCallback onTap,
      {String? subtitle}) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDFFFE0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
