import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/mirror_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditReviewPage extends StatefulWidget {
  final DateTime date;
  final String partOfDay;

  const EditReviewPage({
    super.key,
    required this.date,
    required this.partOfDay,
  });

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late final TextEditingController _successCtrl;
  late final TextEditingController _fixCtrl;
  late final TextEditingController _thanksCtrl;
  late Box<MirrorEntry> mirrorBox;

  late String _initialSuccess;
  late String _initialFix;
  late String _initialThanks;

  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    mirrorBox = Hive.box<MirrorEntry>('mirror_entries');
    final entry = mirrorBox.get(_key(widget.date));

    _successCtrl = TextEditingController(text: _getField(entry, 'success'));
    _fixCtrl = TextEditingController(text: _getField(entry, 'fix'));
    _thanksCtrl = TextEditingController(text: _getField(entry, 'thanks'));

    _initialSuccess = _successCtrl.text;
    _initialFix = _fixCtrl.text;
    _initialThanks = _thanksCtrl.text;

    _successCtrl.addListener(_checkChanges);
    _fixCtrl.addListener(_checkChanges);
    _thanksCtrl.addListener(_checkChanges);
  }

  void _checkChanges() {
    final currentSuccess = _successCtrl.text.trim();
    final currentFix = _fixCtrl.text.trim();
    final currentThanks = _thanksCtrl.text.trim();

    final anyChanged = currentSuccess != _initialSuccess ||
        currentFix != _initialFix ||
        currentThanks != _initialThanks;

    final anyNotEmpty = currentSuccess.isNotEmpty ||
        currentFix.isNotEmpty ||
        currentThanks.isNotEmpty;

    setState(() {
      _hasChanged = anyChanged && anyNotEmpty;
    });
  }

  String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';

  String? _getField(MirrorEntry? entry, String field) {
    if (entry == null) return null;
    switch ('${widget.partOfDay}_$field') {
      case 'morning_success':
        return entry.morningSuccess;
      case 'morning_fix':
        return entry.morningFix;
      case 'morning_thanks':
        return entry.morningThanks;
      case 'afternoon_success':
        return entry.afternoonSuccess;
      case 'afternoon_fix':
        return entry.afternoonFix;
      case 'afternoon_thanks':
        return entry.afternoonThanks;
      case 'evening_success':
        return entry.eveningSuccess;
      case 'evening_fix':
        return entry.eveningFix;
      case 'evening_thanks':
        return entry.eveningThanks;
    }
    return null;
  }

  void _save() {
    final key = _key(widget.date);
    final old = mirrorBox.get(key);
    final newEntry = old ?? MirrorEntry(date: widget.date);

    switch (widget.partOfDay) {
      case 'morning':
        newEntry.morningSuccess = _successCtrl.text.trim();
        newEntry.morningFix = _fixCtrl.text.trim();
        newEntry.morningThanks = _thanksCtrl.text.trim();
        break;
      case 'afternoon':
        newEntry.afternoonSuccess = _successCtrl.text.trim();
        newEntry.afternoonFix = _fixCtrl.text.trim();
        newEntry.afternoonThanks = _thanksCtrl.text.trim();
        break;
      case 'evening':
        newEntry.eveningSuccess = _successCtrl.text.trim();
        newEntry.eveningFix = _fixCtrl.text.trim();
        newEntry.eveningThanks = _thanksCtrl.text.trim();
        break;
    }

    mirrorBox.put(key, newEntry);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _successCtrl.removeListener(_checkChanges);
    _fixCtrl.removeListener(_checkChanges);
    _thanksCtrl.removeListener(_checkChanges);
    _successCtrl.dispose();
    _fixCtrl.dispose();
    _thanksCtrl.dispose();
    super.dispose();
  }

  Widget _buildInput(
    String label,
    TextEditingController controller,
    Color color, {
    IconData? icon,
    String? symbol,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (symbol != null)
                Text(symbol, style: TextStyle(fontSize: 18.sp, color: color))
              else if (icon != null)
                Icon(icon, size: 18.sp, color: color),
              SizedBox(width: 4.w),
              Text(label, style: TextStyle(color: color, fontSize: 16.sp)),
            ],
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Required',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Edit ${widget.partOfDay[0].toUpperCase()}${widget.partOfDay.substring(1)} Review',
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorAs.blue,
            size: 20.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInput('Success', _successCtrl, Colors.green,
                      symbol: '✦'),
                  _buildInput('Room for Improvement', _fixCtrl, Colors.orange,
                      icon: Icons.north_east),
                  _buildInput('Gratitude', _thanksCtrl, Colors.pink,
                      icon: Icons.favorite),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _hasChanged ? _save : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _hasChanged ? Colors.blue : const Color(0xFF8DBEF3),
                  disabledBackgroundColor: const Color(0xFF8DBEF3),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
