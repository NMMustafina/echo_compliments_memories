import 'package:echo_compliments_memories_198_a/m/botbar_as.dart';
import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AsOnBoDi extends StatefulWidget {
  const AsOnBoDi({super.key});

  @override
  State<AsOnBoDi> createState() => _AsOnBoDiState();
}

class _AsOnBoDiState extends State<AsOnBoDi> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAs.background,
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [
              OnWid(
                image: '1',
              ),
              OnWid(
                image: '2',
              ),
              OnWid(
                image: '3',
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const SlideEffect(
                      dotColor: ColorAs.blue2,
                      activeDotColor: Colors.indigo,
                      dotWidth: 80,
                      dotHeight: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 700.h),
            child: AsMotiBut(
              onPressed: () {
                if (introIndex != 2) {
                  _controller.animateToPage(
                    introIndex + 1,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.ease,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AsBotomBar(),
                    ),
                    (protected) => false,
                  );
                }
              },
              child: Container(
                height: 56.h,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: ColorAs.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      introIndex != 2 ? 'Continue' : 'Start',
                      style: TextStyle(
                        color: ColorAs.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        height: 1.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnWid extends StatelessWidget {
  const OnWid({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Image.asset(
        'assets/images/on$image.png',
        height: 755.h,
        width: 305.w,
        fit: BoxFit.cover,
        // alignment: Alignment.bottomCenter,
      ),
    );
  }
}
