import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment.dart';
import 'package:echo_compliments_memories_198_a/w/kampliment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KamplimentCard extends StatelessWidget {
  final Kampliment kampliment;

  const KamplimentCard({
    super.key,
    required this.kampliment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => KamplimentDialog(kampliment: kampliment),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(containerImages[kampliment.cardIndex]),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.10),
                    width: 1.w,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kampliment.kampType.name,
                        style: TextStyle(
                          color: ColorAs.blue,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Image.asset(
                        kampliment.kampType.image,
                        height: 24.h,
                      ),
                    ],
                  ),
                  if (kampliment.kampType != KamplimentType.me)
                    SizedBox(height: 8.h),
                  if (kampliment.kampType != KamplimentType.me)
                    Text(
                      'to: ${kampliment.toWho}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14.sp,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              kampliment.kampliment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Text(
                  _formatDate(kampliment.id),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.60),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: ColorAs.blue,
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
