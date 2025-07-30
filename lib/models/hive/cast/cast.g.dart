// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastAdapter extends TypeAdapter<Cast> {
  @override
  final int typeId = 0;

  @override
  Cast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cast(
      id: fields[0] as int,
      name: fields[1] as String,
      gender: fields[2] as int,
      profilePath: fields[3] as String?,
      popularity: fields[4] as double?,
      adult: fields[5] as bool?,
      character: fields[6] as String?,
      order: fields[7] as int?,
      biography: fields[8] as String?,
      birthday: fields[9] as String?,
      deathday: fields[10] as String?,
      imdbId: fields[11] as String?,
      placeOfBirth: fields[12] as String?,
      movies: (fields[13] as List?)?.cast<Movie>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cast obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._gender)
      ..writeByte(3)
      ..write(obj._profilePath)
      ..writeByte(4)
      ..write(obj._popularity)
      ..writeByte(5)
      ..write(obj._adult)
      ..writeByte(6)
      ..write(obj._character)
      ..writeByte(7)
      ..write(obj._order)
      ..writeByte(8)
      ..write(obj._biography)
      ..writeByte(9)
      ..write(obj._birthday)
      ..writeByte(10)
      ..write(obj._deathday)
      ..writeByte(11)
      ..write(obj._imdbId)
      ..writeByte(12)
      ..write(obj._placeOfBirth)
      ..writeByte(13)
      ..write(obj._movies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
