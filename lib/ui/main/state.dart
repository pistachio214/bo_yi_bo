import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainState {
  late List<BottomNavigationBarItem> bottomTabs;
  late RxList<Widget> tabBodies;
  late RxInt currentIndex;

  MainState() {
    currentIndex = 0.obs;
    // 底部选项卡
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book_sharp),
        label: "双色球",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.photo_album_outlined),
        label: "历史记录",
      ),
    ];

    tabBodies = <Widget>[
      const Center(
        child: Text("双色球"),
      ),
      // tab 书库
      const Center(
        child: Text("历史记录"),
      ),
    ].obs;
  }
}
