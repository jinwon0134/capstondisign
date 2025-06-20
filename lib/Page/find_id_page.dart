import 'package:flutter/material.dart';

class FindIdPage extends StatelessWidget {
  const FindIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 첫번째 행: 휴대전화번호 입력 + 인증번호 전송 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '휴대전화번호 입력',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    // 인증번호 전송 기능 구현
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('인증번호 전송'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 두번째 행: 인증번호 입력 + 확인 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '인증번호 입력',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    // 인증번호 확인 기능 구현
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('확인'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 아이디 찾기 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 아이디 찾기 기능 구현
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '아이디 찾기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
