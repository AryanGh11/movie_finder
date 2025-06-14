import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/services/index.dart';
import 'package:movie_finder/constants/index.dart';

class TMDBService {
  static const String _apiKey = tmdbApiKey;
  static const String _baseUrl = "https://api.themoviedb.org/3";

  static Future<List<Movie>> searchMovies(String query) async {
    final Uri url = Uri.parse(
      '$_baseUrl/search/movie?api_key=$_apiKey&query=$query',
    );

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<List<Movie>> getDiscoverMovies() async {
    final Uri url = Uri.parse('$_baseUrl/discover/movie?api_key=$_apiKey');

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<List<Movie>> getPopularMovies() async {
    final Uri url = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey');

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<List<Movie>> getNowPlayingMovies() async {
    final Uri url = Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey');

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<List<Movie>> getTopRatedMovies() async {
    final Uri url = Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey');

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<List<Movie>> getUpcomingMovies() async {
    final Uri url = Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey');

    final List<dynamic> response = (await HTTPService.get(url))["results"];

    final List<Movie> results = response
        .map((json) => Movie.fromSummary(json))
        .toList();

    return results;
  }

  static Future<void> rateMovie(int movieId) async {
    final Uri url = Uri.parse(
      '$_baseUrl/movie/$movieId/rating?api_key=$_apiKey',
    );

    await HTTPService.post(url, null);
  }

  static Future<Movie> getDetailedMovie(int movieId) async {
    final Uri url = Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey');

    final dynamic response = await HTTPService.get(url);

    final Movie result = Movie.fromDetailed(response);

    return result;
  }

  static Future<MovieImage> getMovieImages(int movieId) async {
    final Uri url = Uri.parse(
      '$_baseUrl/movie/$movieId/images?api_key=$_apiKey',
    );
    final dynamic response = await HTTPService.get(url);

    final MovieImage result = MovieImage.fromJson(response);

    return result;
  }
}
