import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/mirror_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'edit_review_page.dart';

class DailyMirrorPage extends StatefulWidget {
  const DailyMirrorPage({super.key});

  @override
  State<DailyMirrorPage> createState() => _DailyMirrorPageState();
}

class _DailyMirrorPageState extends State<DailyMirrorPage> {
  late Box<MirrorEntry> mirrorBox;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    mirrorBox = Hive.box<MirrorEntry>('mirror_entries');
    selectedDate = DateTime.now();
  }

  List<DateTime> getCurrentWeek() {
    final now = DateTime.now();
    final weekday = now.weekday % 7;
    final sunday = now.subtract(Duration(days: weekday));
    return List.generate(7, (i) => sunday.add(Duration(days: i)));
  }

  MirrorEntry? getEntryFor(DateTime date) {
    return mirrorBox.get(_key(date));
  }

  String _key(DateTime date) => '${date.year}-${date.month}-${date.day}';

  Widget _buildReviewTile(String title, String timeOfDay, MirrorEntry? entry) {
    String? success;
    String? fix;
    String? thanks;
    bool isSameDate(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    switch (timeOfDay) {
      case 'morning':
        success = entry?.morningSuccess;
        fix = entry?.morningFix;
        thanks = entry?.morningThanks;
        break;
      case 'afternoon':
        success = entry?.afternoonSuccess;
        fix = entry?.afternoonFix;
        thanks = entry?.afternoonThanks;
        break;
      case 'evening':
        success = entry?.eveningSuccess;
        fix = entry?.eveningFix;
        thanks = entry?.eveningThanks;
        break;
    }

    final hasContent =
        [success, fix, thanks].any((e) => (e != null && e.trim().isNotEmpty));
    final isEditable = isSameDate(selectedDate, DateTime.now());

    final blocks = <Widget>[];

    if ((success ?? '').trim().isNotEmpty) {
      blocks.add(_buildDisplayBlock(
        label: 'Success',
        value: success!,
        color: Colors.green,
        symbol: '✦',
      ));
    }
    if ((fix ?? '').trim().isNotEmpty) {
      blocks.add(_buildDisplayBlock(
        label: 'Room for Improvement',
        value: fix!,
        color: Colors.orange,
        icon: Icons.north_east,
      ));
    }
    if ((thanks ?? '').trim().isNotEmpty) {
      blocks.add(_buildDisplayBlock(
        label: 'Gratitude',
        value: thanks!,
        color: Colors.pink,
        icon: Icons.favorite,
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: GestureDetector(
        onTap: isEditable
            ? () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditReviewPage(
                      date: selectedDate,
                      partOfDay: timeOfDay,
                    ),
                  ),
                );
                setState(() {});
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
            color: ColorAs.background,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 0),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (isEditable)
                    SvgPicture.asset(
                      'assets/icons/edit.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter:
                          const ColorFilter.mode(ColorAs.blue, BlendMode.srcIn),
                    ),
                ],
              ),
              SizedBox(height: isEditable ? 16.h : 8.h),
              if (blocks.isNotEmpty)
                ...List.generate(blocks.length * 2 - 1, (i) {
                  if (i.isEven) return blocks[i ~/ 2];
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black.withOpacity(0.08),
                    ),
                  );
                }),
              if (!hasContent)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'No data available',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockedMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/lock_calendar.png',
            width: 90.w,
          ),
          SizedBox(height: 24.h),
          Text(
            'Unable to leave a review',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Come back another day',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final week = getCurrentWeek();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Daily Mirror',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: ColorAs.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 4.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 0.7,
              children: week.map((d) {
                final isSelected = _key(d) == _key(selectedDate);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = d;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? ColorAs.blue : ColorAs.background,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _shortWeekday(d),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                        Text(
                          d.day.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: selectedDate.isAfter(DateTime.now())
                  ? _buildLockedMessage()
                  : ListView(
                      children: [
                        _buildReviewTile('Morning Review', 'morning',
                            getEntryFor(selectedDate)),
                        _buildReviewTile('Afternoon Review', 'afternoon',
                            getEntryFor(selectedDate)),
                        _buildReviewTile('Evening Review', 'evening',
                            getEntryFor(selectedDate)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String _shortWeekday(DateTime date) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }

  Widget _buildDisplayBlock({
    required String label,
    required String value,
    required Color color,
    IconData? icon,
    String? symbol,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, size: 16.sp, color: color)
              else if (symbol != null)
                Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: color,
                  ),
                ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
