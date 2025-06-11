import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'memory_model.g.dart';

@HiveType(typeId: 0)
class MemoryModel extends HiveObject {
  @HiveField(0)
  final Uint8List image;

  @HiveField(1)
  final String compliment;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final String moodImage;

  MemoryModel({
    required this.image,
    required this.compliment,
    required this.mood,
    required this.moodImage,
  });
}
