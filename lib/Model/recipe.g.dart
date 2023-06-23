// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealsAdapter extends TypeAdapter<Meals> {
  @override
  final int typeId = 0;

  @override
  Meals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meals(
      idIngredient: fields[0] as String?,
      strIngredient: fields[1] as String?,
      strDescription: fields[2] as String?,
      strType: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Meals obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idIngredient)
      ..writeByte(1)
      ..write(obj.strIngredient)
      ..writeByte(2)
      ..write(obj.strDescription)
      ..writeByte(3)
      ..write(obj.strType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
