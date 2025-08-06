import 'dart:async';

import 'package:capston/Page/effect_page.dart';
import 'package:capston/Page/map_page.dart';
import 'package:capston/Page/mypage_page.dart';
import 'package:capston/Page/report_page.dart';
import 'package:flutter/material.dart';
import 'package:capston/page/login_page.dart';
import 'package:capston/Widget/showbanner_widget.dart';

int currentAdIndex = 0;
final List<String> adImages = [
  'assets/images/smoke1.png',
  'assets/images/smoke2.png',
  'assets/images/smoke3.png',
];
bool _showBanner = true;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('메인페이지'),
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
          SizedBox(height: screenHeight * 0.07),

          // 상단 카드
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            padding: EdgeInsets.all(screenWidth * 0.04),
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
                  Text('프로필',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF))),
                  SizedBox(
                    height: 30,
                  ),
                ]),
                TableRow(children: [
                  Text('금연시간',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBFBFBF))),
                  Text('1일 10시간 31분 15초',
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
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.075),

          // ✅ 그리드 메뉴
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.08,
                mainAxisSpacing: screenHeight * 0.04,
                children: menuItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      final label = item['label'];

                      if (label == '흡연장 찾기') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MapPage()),
                        );
                      } else if (label == '신고하기') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Reportpage()),
                        );
                      } else if (label == '마이 페이지') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Mypagepage()),
                        );
                      } else if (label == '금연 효과') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Effectpage()));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xFFEDEDED),
                            width: screenWidth * 0.03),
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
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            item['label'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
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

          // ✅ 하단 배너

          if (_showBanner)
            ShowBannerWidget(
              imagePath: adImages[currentAdIndex],
              onClose: () {
                setState(() {
                  _showBanner = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
