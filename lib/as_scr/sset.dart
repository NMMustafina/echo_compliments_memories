import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/dok_as.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:echo_compliments_memories_198_a/m/pro_as.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sset extends StatelessWidget {
  const Sset({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: ColorAs.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            AsMotiBut(
              onPressed: () {
                lauchUrl(context, DokAs.priPoli);
              },
              child: Image.asset(
                'assets/icons/s1.png',
              ),
            ),
            const SizedBox(height: 16),
            AsMotiBut(
              onPressed: () {
                lauchUrl(context, DokAs.terOfUse);
              },
              child: Image.asset(
                'assets/icons/s2.png',
              ),
            ),
            const SizedBox(height: 16),
            AsMotiBut(
              onPressed: () {
                lauchUrl(context, DokAs.suprF);
              },
              child: Image.asset(
                'assets/icons/s3.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
