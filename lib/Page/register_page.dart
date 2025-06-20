import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool agreePrivacy = false;
  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
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
                        hintText: "아이디 입력",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBFBFBF)),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none, // 기본 테두리 제거
                        hintText: "비밀번호 입력",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBFBFBF)),
                        borderRadius: BorderRadius.circular(8)),
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
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBFBFBF)),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none, // 기본 테두리 제거
                        hintText: "나이 입력",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 첫 번째 체크박스와 텍스트 (개인정보 동의)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: agreePrivacy,
                        onChanged: (bool? value) {
                          setState(() {
                            agreePrivacy = value ?? false;
                          });
                        },
                        visualDensity: VisualDensity.compact, // 👈 세로/가로 간격 줄임
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 👈 터치 영역 최소화
                      ),
                      Text("개인정보 수집에 동의합니다."),
                    ],
                  ),

// 두 번째 체크박스
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            agreeTerms = value ?? false;
                          });
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Text("이용약관에 동의합니다."),
                    ],
                  ),

                  const SizedBox(height: 40),

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
                      child: Text('회원가입 완료'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
