import 'dart:typed_data';

import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/moti_as.dart';
import 'package:echo_compliments_memories_198_a/three_screen/hive/memory_model.dart';
import 'package:echo_compliments_memories_198_a/three_screen/wid/app_unfocuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Uint8List? _imageBytes;
  final _complimentController = TextEditingController();
  String _selectedMood = 'Happiness';
  final _imagePicker = ImagePicker();

  final Map<String, String> _moodImages = {
    'Happiness': 'assets/icons/a1.png',
    'Inspiration': 'assets/icons/a2.png',
    'Nostalgia': 'assets/icons/a3.png',
    'Tranquility': 'assets/icons/a4.png',
  };

  bool get _isFormValid =>
      _imageBytes != null && _complimentController.text.trim().isNotEmpty;

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _saveMemory() async {
    if (!_isFormValid) return;

    final memory = MemoryModel(
      image: _imageBytes!,
      compliment: _complimentController.text.trim(),
      mood: _selectedMood,
      moodImage: _moodImages[_selectedMood]!,
    );

    final box = Hive.box<MemoryModel>('memories');
    await box.add(memory);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Create Memory',
            style: TextStyle(
              color: ColorAs.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Compliment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.sp),
                TextField(
                  controller: _complimentController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Required',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(135, 39, 39, 43),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 24.sp),
                Wrap(
                  spacing: 16.sp,
                  runSpacing: 12.sp,
                  children: _moodImages.entries
                      .map((entry) => _buildMoodChip(entry.key, entry.value))
                      .toList(),
                ),
                SizedBox(height: 24.sp),
                Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.sp),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: _imageBytes == null
                        ? Image.asset(
                            'assets/icons/null_phot.png',
                            fit: BoxFit.cover,
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Image.memory(
                                  _imageBytes!,
                                  fit: BoxFit.cover,
                                  width: 180,
                                  height: 180,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: AsMotiBut(
                                  onPressed: () {
                                    setState(() {
                                      _imageBytes = null;
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icons/x.png',
                                    fit: BoxFit.cover,
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 100.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isFormValid ? _saveMemory : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? const Color(0xFF007AFF)
                          : const Color(0xFF8DBEF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.sp),
                      ),
                    ),
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: _isFormValid
                            ? Colors.white
                            : Colors.white.withOpacity(0.9),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodChip(String mood, String imagePath) {
    final isSelected = _selectedMood == mood;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mood,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? Colors.white : Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 4.sp),
            Image.asset(
              imagePath,
              width: 18.sp,
              height: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _complimentController.dispose();
    super.dispose();
  }
}
