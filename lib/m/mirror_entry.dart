import 'package:hive/hive.dart';

part 'mirror_entry.g.dart';

@HiveType(typeId: 1)
class MirrorEntry extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  String? morningSuccess;
  @HiveField(2)
  String? morningFix;
  @HiveField(3)
  String? morningThanks;

  @HiveField(4)
  String? afternoonSuccess;
  @HiveField(5)
  String? afternoonFix;
  @HiveField(6)
  String? afternoonThanks;

  @HiveField(7)
  String? eveningSuccess;
  @HiveField(8)
  String? eveningFix;
  @HiveField(9)
  String? eveningThanks;

  MirrorEntry({
    required this.date,
    this.morningSuccess,
    this.morningFix,
    this.morningThanks,
    this.afternoonSuccess,
    this.afternoonFix,
    this.afternoonThanks,
    this.eveningSuccess,
    this.eveningFix,
    this.eveningThanks,
  });
}
