import 'package:flutter/material.dart';

class FindPasswordPage extends StatelessWidget {
  const FindPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 330,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFBFBFBF)))),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // 기본 테두리 제거
                      hintText: "휴대전화번호 입력",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFBFBFBF)))),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // 기본 테두리 제거
                      hintText: "인증번호 입력",
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
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
