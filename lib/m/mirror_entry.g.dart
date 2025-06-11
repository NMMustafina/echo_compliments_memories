// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirror_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MirrorEntryAdapter extends TypeAdapter<MirrorEntry> {
  @override
  final int typeId = 1;

  @override
  MirrorEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MirrorEntry(
      date: fields[0] as DateTime,
      morningSuccess: fields[1] as String?,
      morningFix: fields[2] as String?,
      morningThanks: fields[3] as String?,
      afternoonSuccess: fields[4] as String?,
      afternoonFix: fields[5] as String?,
      afternoonThanks: fields[6] as String?,
      eveningSuccess: fields[7] as String?,
      eveningFix: fields[8] as String?,
      eveningThanks: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MirrorEntry obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.morningSuccess)
      ..writeByte(2)
      ..write(obj.morningFix)
      ..writeByte(3)
      ..write(obj.morningThanks)
      ..writeByte(4)
      ..write(obj.afternoonSuccess)
      ..writeByte(5)
      ..write(obj.afternoonFix)
      ..writeByte(6)
      ..write(obj.afternoonThanks)
      ..writeByte(7)
      ..write(obj.eveningSuccess)
      ..writeByte(8)
      ..write(obj.eveningFix)
      ..writeByte(9)
      ..write(obj.eveningThanks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MirrorEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
