import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment_prov.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddEditKampliment extends StatefulWidget {
  final Kampliment? kamplimnt;

  const AddEditKampliment({super.key, this.kamplimnt});

  @override
  State<AddEditKampliment> createState() => _AddEditKamplimentState();
}

class _AddEditKamplimentState extends State<AddEditKampliment> {
  late final TextEditingController _toWhoContrlr;
  late final TextEditingController _complimntContrlr;
  late KamplimentType _selectedTyp;
  late final PageController _pagContrlr;
  int _selectedCrdIndx = 0;

  @override
  void initState() {
    super.initState();
    _toWhoContrlr = TextEditingController(
      text: widget.kamplimnt?.toWho ?? '',
    );
    _complimntContrlr = TextEditingController(
      text: widget.kamplimnt?.kampliment ?? '',
    );
    _selectedTyp = widget.kamplimnt?.kampType ?? KamplimentType.me;
    _selectedCrdIndx = widget.kamplimnt?.cardIndex ?? 0;
    _pagContrlr = PageController(initialPage: _selectedCrdIndx);
  }

  @override
  void dispose() {
    _toWhoContrlr.dispose();
    _complimntContrlr.dispose();
    _pagContrlr.dispose();
    super.dispose();
  }

  void _sav() {
    if (_toWhoContrlr.text.isEmpty || _complimntContrlr.text.isEmpty) {
      return;
    }

    final kamplimnt = Kampliment(
      id: widget.kamplimnt?.id ?? DateTime.now().millisecondsSinceEpoch,
      kampType: _selectedTyp,
      kampliment: _complimntContrlr.text,
      toWho: _toWhoContrlr.text,
      cardIndex: _selectedCrdIndx,
    );

    final kamplimntProv = context.read<KamplimentProv>();
    if (widget.kamplimnt == null) {
      kamplimntProv.addKampliment(kamplimnt);
    } else {
      kamplimntProv.updateKampliment(kamplimnt);
    }

    Navigator.of(context).pop();
  }

  void _genratComplimnt() {
    final complmnts = KamplimentData.getComplimentsForType(_selectedTyp);
    if (complmnts.isNotEmpty) {
      final rndmIndx = DateTime.now().millisecondsSinceEpoch % complmnts.length;
      setState(() {
        _complimntContrlr.text = complmnts[rndmIndx];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.kamplimnt == null ? 'Create compliment' : 'Edit compliment',
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
                padding: EdgeInsets.all(20.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: KamplimentType.values.map((typ) {
                          return Expanded(
                            child: AsMotiBut(
                              onPressed: () {
                                setState(() {
                                  _selectedTyp = typ;
                                  if (typ == KamplimentType.me) {
                                    _toWhoContrlr.text = 'Me';
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                decoration: BoxDecoration(
                                  color: _selectedTyp == typ
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      typ.name,
                                      style: TextStyle(
                                        color: _selectedTyp == typ
                                            ? Colors.white
                                            : Colors.black,
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
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'To',
                      style: TextStyle(
                        color: ColorAs.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _toWhoContrlr,
                      maxLength: 28,
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Required',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Compliment',
                      style: TextStyle(
                        color: ColorAs.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _complimntContrlr,
                      maxLines: 3,
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Required',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: AsMotiBut(
                            onPressed: _genratComplimnt,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 17.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF353637).withOpacity(0.18),
                                    spreadRadius: 0,
                                    blurRadius: 48.5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'GENERATE A COMPLIMENT',
                                    style: TextStyle(
                                      color: ColorAs.blue,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  SvgPicture.asset(
                                    'assets/images/gener.svg',
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        AsMotiBut(
                          onPressed: () {
                            if (_complimntContrlr.text.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: _complimntContrlr.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Copied to clipboard',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height /
                                        2.5,
                                    left: 20,
                                    right: 20,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(17.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF353637).withOpacity(0.18),
                                  spreadRadius: 0,
                                  blurRadius: 48.5,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/cop.svg',
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200.h,
                child: PageView.builder(
                  controller: _pagContrlr,
                  itemCount: containerImages.length,
                  onPageChanged: (indx) {
                    setState(() {
                      _selectedCrdIndx = indx;
                    });
                  },
                  itemBuilder: (context, indx) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF353637).withOpacity(0.18),
                            spreadRadius: 0,
                            blurRadius: 12.5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(22.r),
                        image: DecorationImage(
                          image: AssetImage(containerImages[indx]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16.w),
        child: AsMotiBut(
          onPressed: _sav,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: BoxDecoration(
              color:
                  _toWhoContrlr.text.isEmpty || _complimntContrlr.text.isEmpty
                      ? ColorAs.blue.withOpacity(0.6)
                      : ColorAs.blue,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.kamplimnt == null ? 'Create' : 'Edit',
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
    );
  }
}
