import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:echo_compliments_memories_198_a/three_screen/add_screen.dart';
import 'package:echo_compliments_memories_198_a/three_screen/hive/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Album extends StatelessWidget {
  const Album({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Album of Memories',
          style: TextStyle(
            color: ColorAs.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
          child: ValueListenableBuilder<Box<MemoryModel>>(
            valueListenable: Hive.box<MemoryModel>('memories').listenable(),
            builder: (context, box, _) {
              return Column(
                children: [
                  AsMotiBut(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF007AFF),
                        borderRadius: BorderRadius.circular(18.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Memory',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 8.sp),
                          Image.asset(
                            'assets/icons/camera.png',
                            width: 24.sp,
                            height: 24.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (box.isNotEmpty)
                    ListView.builder(
                      itemCount: box.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final memory = box.getAt(index);
                        return WidAs(
                          memory: memory!,
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class WidAs extends StatelessWidget {
  const WidAs({
    super.key,
    required this.memory,
  });

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.sp),
                child: Image.memory(
                  memory.image,
                  width: double.infinity,
                  height: 200.sp,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memory.compliment,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorAs.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  Divider(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 16.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Mood: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        Image.asset(
                          memory.moodImage,
                          width: 18.sp,
                          height: 18.sp,
                        ),
                        SizedBox(width: 4.sp),
                        Text(
                          memory.mood,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: ColorAs.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
