import 'package:capston/Page/find_id_page.dart';
import 'package:capston/Page/find_password_page.dart';
import 'package:flutter/material.dart';
import 'package:capston/Page/main_page.dart';
import 'package:capston/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'), // 여기서 타이틀 설정
        foregroundColor: Colors.black, // 글자색 설정 (기본 흰색이라 눈에 안 띌 수도 있어서)
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFDFFFE0),
                borderRadius: BorderRadius.circular(30),
              ),
              width: 300,
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '아이디',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비밀번호',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MainPage()),
                        );
                      },
                      child: const Text('로그인'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FindIdPage()),
                    );
                  },
                  child: const Text(
                    '아이디 찾기',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                const Text(" | "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FindPasswordPage()),
                    );
                  },
                  child: const Text(
                    '비밀번호 찾기',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                const Text(" | "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
