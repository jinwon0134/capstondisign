import 'package:capston/Page/find_idpassword_page.dart';
import 'package:flutter/material.dart';
import 'package:capston/Page/main_page.dart';
import 'package:capston/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              width: 330,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBFBFBF)),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none, // 기본 테두리 제거
                        hintText: "아이디",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBFBFBF)),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none, // 기본 테두리 제거
                        hintText: "비밀번호",
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // ✅ 테두리 추가
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MainPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0, // 그림자 제거 (선택)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('로그인'),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      MaterialPageRoute(
                          builder: (_) => const FindIdPasswordPage()),
                    );
                  },
                  child: const Text(
                    '아이디 찾기',
                    style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                  ),
                ),
                Text(
                  " | ",
                  style: const TextStyle(color: Color(0xFF636161)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FindIdPasswordPage()),
                    );
                  },
                  child: const Text(
                    '비밀번호 찾기',
                    style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
                  ),
                ),
                Text(
                  " | ",
                  style: const TextStyle(color: Color(0xFF636161)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 14, color: Color(0xFF7A7A7A)),
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
