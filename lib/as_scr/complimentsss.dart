import 'package:echo_compliments_memories_198_a/as_scr/add_edit_kampliment.dart';
import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment_prov.dart';
import 'package:echo_compliments_memories_198_a/w/kampliment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Complimentzzz extends StatefulWidget {
  const Complimentzzz({super.key});

  @override
  State<Complimentzzz> createState() => _ComplimentzzzState();
}

class _ComplimentzzzState extends State<Complimentzzz> {
  KamplimentType _selectedTyp = KamplimentType.me;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Compliments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Consumer<KamplimentProv>(builder: (ctx, prov, chld) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: KamplimentType.values.map((typ) {
                      final hasKompliments =
                          prov.getKamplimentsByType(typ).isNotEmpty;
                      if (!hasKompliments)
                        return Expanded(child: const SizedBox());

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTyp = typ;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: _selectedTyp == typ
                                ? ColorAs.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                typ.name,
                                style: TextStyle(
                                  color: _selectedTyp == typ
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Image.asset(
                                typ.image,
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
              SizedBox(height: 16.h),
              Consumer<KamplimentProv>(
                builder: (ctx, prov, chld) {
                  final kompliments = prov.getKamplimentsByType(_selectedTyp);

                  if (kompliments.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100.h),
                          Image.asset(
                            'assets/images/empp.png',
                            width: 200.w,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No kompliments yet',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: kompliments.length,
                    itemBuilder: (ctx, indx) {
                      return KamplimentCard(
                        kampliment: kompliments[indx],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 150.h),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.0.w),
        child: FloatingActionButton(
          backgroundColor: ColorAs.blue,
          onPressed: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (ctx) => const AddEditKampliment(),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white, size: 32.r),
        ),
      ),
    );
  }
}
