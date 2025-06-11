import 'package:echo_compliments_memories_198_a/as_scr/album.dart';
import 'package:echo_compliments_memories_198_a/as_scr/complimentsss.dart';
import 'package:echo_compliments_memories_198_a/as_scr/daily_mirror_page.dart';
import 'package:echo_compliments_memories_198_a/as_scr/sset.dart';
import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsBotomBar extends StatefulWidget {
  const AsBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<AsBotomBar> createState() => AsBotomBarState();
}

class AsBotomBarState extends State<AsBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 56.h,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8.h),
        decoration: BoxDecoration(
          color: ColorAs.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 9,
              spreadRadius: 5,
              offset: const Offset(-1, 0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: buildNavItem(
                    0, 'assets/icons/1.png', 'assets/icons/11.png')),
            Expanded(
                child: buildNavItem(
                    1, 'assets/icons/2.png', 'assets/icons/22.png')),
            Expanded(
                child: buildNavItem(
                    2, 'assets/icons/3.png', 'assets/icons/33.png')),
            Expanded(
                child: buildNavItem(
                    3, 'assets/icons/4.png', 'assets/icons/44.png')),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String t) {
    bool isActive = _currentIndex == index;
    return AsMotiBut(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: isActive
            ? Center(
                child: Image.asset(
                  iconPath,
                  width: 26.w,
                  height: 26.h,
                ),
              )
            : Center(
                child: Image.asset(
                  t,
                  width: 26.w,
                  height: 26.h,
                ),
              ),
      ),
    );
  }

  final _pages = <Widget>[
    const Complimentzzz(),
    const DailyMirrorPage(),
    const Album(),
    const Sset(),
  ];
}
