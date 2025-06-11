import 'package:echo_compliments_memories_198_a/as_scr/add_edit_kampliment.dart';
import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment_prov.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class KamplimentDialog extends StatelessWidget {
  final Kampliment kampliment;

  const KamplimentDialog({
    super.key,
    required this.kampliment,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
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
                                color: Colors.blue,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              kampliment.kampType.image,
                              height: 24.h,
                            ),
                          ],
                        ),
                        if (kampliment.kampType != KamplimentType.me) ...[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'to: ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: kampliment.toWho,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    kampliment.kampliment,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    _formatDate(kampliment.id),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: AsMotiBut(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditKampliment(
                                  kamplimnt: kampliment,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AsMotiBut(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text('Delete Compliment'),
                                content: const Text(
                                  'Confirm if you are sure you want to delete it.',
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      context
                                          .read<KamplimentProv>()
                                          .deleteKampliment(kampliment.id);
                                      Navigator.pop(
                                          context); // Close confirmation
                                      Navigator.pop(context); // Close dialog
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: AsMotiBut(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: ColorAs.blue,
                    size: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
