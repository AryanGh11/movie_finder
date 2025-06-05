import 'movie.dart';
import 'package:hive/hive.dart';

part 'local_user.g.dart';

@HiveType(typeId: 1)
class LocalUser extends HiveObject {
  @HiveField(0)
  List<Movie> favorites;

  @HiveField(1)
  List<Movie> watchLater;

  LocalUser({required this.favorites, required this.watchLater});
}
