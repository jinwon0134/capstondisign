import 'dart:async';
import 'package:flutter/material.dart';
import 'package:capston/page/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> menuItems = const [
    {'image': 'assets/images/siren.png', 'label': '신고하기'},
    {'image': 'assets/images/map.png', 'label': '흡연장 찾기'},
    {'image': 'assets/images/clock.png', 'label': '금연 효과'},
    {'image': 'assets/images/person.png', 'label': '마이 페이지'},
  ];

  final List<String> adImages = [
    'assets/images/smoke1.png',
    'assets/images/smoke2.png',
    'assets/images/smoke3.png',
  ];

  int currentAdIndex = 0;
  late Timer _adTimer;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentAdIndex = (currentAdIndex + 1) % adImages.length;
      });
    });
  }

  @override
  void dispose() {
    _adTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 70),

          // ✅ 상단 금연 카드
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(children: [
                  const Text('프로필',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF))),
                  const SizedBox(),
                ]),
                TableRow(children: [
                  const Text('금연시간',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF))),
                  const Text('1일 10시간 31분 15초',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF))),
                ]),
                TableRow(
                  children: [
                    const Text(
                      '절약한 금액',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          '67,500.64원',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBFBFBF)),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          'assets/images/money.png',
                          width: 35,
                          height: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 70),

          // ✅ 아래 Grid 메뉴
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            color: const Color(0xFFEDEDED), width: 20.0),
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
                          Image.asset(
                            item['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['label'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ✅ 최하단 광고 배너
          AspectRatio(
            aspectRatio: 3 / 1, // 배너 비율
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                adImages[currentAdIndex],
                key: ValueKey(adImages[currentAdIndex]),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
