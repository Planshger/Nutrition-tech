// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fruits_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FruitsModelAdapter extends TypeAdapter<FruitsModel> {
  @override
  final typeId = 0;

  @override
  FruitsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FruitsModel(
      name: fields[0] as String,
      family: fields[1] as String,
      id: (fields[2] as num).toInt(),
      order: fields[3] as String,
      genus: fields[4] as String,
      calories: (fields[5] as num).toInt(),
      fat: (fields[6] as num).toDouble(),
      sugar: (fields[7] as num).toDouble(),
      carbohydrates: (fields[8] as num).toDouble(),
      protein: (fields[9] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, FruitsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.genus)
      ..writeByte(5)
      ..write(obj.calories)
      ..writeByte(6)
      ..write(obj.fat)
      ..writeByte(7)
      ..write(obj.sugar)
      ..writeByte(8)
      ..write(obj.carbohydrates)
      ..writeByte(9)
      ..write(obj.protein);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FruitsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
