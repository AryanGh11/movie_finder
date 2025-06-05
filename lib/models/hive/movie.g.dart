// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String?,
      voteAverage: fields[4] as double?,
      adult: fields[5] as bool?,
      originalLanguage: fields[6] as String?,
      popularity: fields[7] as double?,
      releaseDate: fields[8] as String?,
      voteCount: fields[9] as int?,
      originCountries: (fields[10] as List?)?.cast<String>(),
      budget: fields[11] as int?,
      genres: (fields[12] as List?)?.cast<Map<dynamic, dynamic>>(),
      productionCompanies: (fields[13] as List?)?.cast<Map<dynamic, dynamic>>(),
      productionCountries: (fields[14] as List?)?.cast<Map<dynamic, dynamic>>(),
      homepage: fields[15] as String?,
      revenue: fields[16] as int?,
      duration: fields[17] as int?,
      spokenLanguages: (fields[18] as List?)?.cast<Map<dynamic, dynamic>>(),
      status: fields[19] as String?,
      tagline: fields[20] as String?,
      imdbId: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._title)
      ..writeByte(2)
      ..write(obj._overview)
      ..writeByte(3)
      ..write(obj._posterPath)
      ..writeByte(4)
      ..write(obj._voteAverage)
      ..writeByte(5)
      ..write(obj._adult)
      ..writeByte(6)
      ..write(obj._originalLanguage)
      ..writeByte(7)
      ..write(obj._popularity)
      ..writeByte(8)
      ..write(obj._releaseDate)
      ..writeByte(9)
      ..write(obj._voteCount)
      ..writeByte(10)
      ..write(obj._originCountries)
      ..writeByte(11)
      ..write(obj._budget)
      ..writeByte(12)
      ..write(obj._genres)
      ..writeByte(13)
      ..write(obj._productionCompanies)
      ..writeByte(14)
      ..write(obj._productionCountries)
      ..writeByte(15)
      ..write(obj._homepage)
      ..writeByte(16)
      ..write(obj._revenue)
      ..writeByte(17)
      ..write(obj._duration)
      ..writeByte(18)
      ..write(obj._spokenLanguages)
      ..writeByte(19)
      ..write(obj._status)
      ..writeByte(20)
      ..write(obj._tagline)
      ..writeByte(21)
      ..write(obj._imdbId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
