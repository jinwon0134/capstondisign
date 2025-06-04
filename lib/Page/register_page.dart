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
        leading: IconButton(
          // 왼쪽 상단 뒤로가기 버튼
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 로그인 페이지로 돌아가기
          },
        ),
        title: const Text('회원가입'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _inputBox('아이디'),
              _inputBox('비밀번호', obscure: true),
              _inputBox('비밀번호 확인', obscure: true),
              _inputBox('나이'),
              const SizedBox(height: 20),
              _buildCheckbox('개인정보 활용에 동의함', agreePrivacy, (val) {
                setState(() => agreePrivacy = val!);
              }),
              _buildCheckbox('이용약관에 동의함', agreeTerms, (val) {
                setState(() => agreeTerms = val!);
              }),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (agreePrivacy && agreeTerms) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  }
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBox(String hint, {bool obscure = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFDFFFE0),
      ),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?)? onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }
}
