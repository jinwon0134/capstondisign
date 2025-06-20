import 'package:capston/Page/find_password_page.dart';
import 'package:capston/page/find_id_page.dart';
import 'package:flutter/material.dart';

class FindIdPasswordPage extends StatelessWidget {
  final int initialTabIndex;

  const FindIdPasswordPage({super.key, this.initialTabIndex = 0});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: initialTabIndex,
        child: Scaffold(
          appBar: AppBar(
            title: Text('아이디 / 비밀번호 찾기'),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                tabs: [
                  Tab(
                    text: '아이디 찾기',
                  ),
                  Tab(
                    text: '비밀번호 찾기',
                  ),
                ]),
          ),
          body: const TabBarView(children: [FindIdPage(), FindPasswordPage()]),
        ));
  }
}
