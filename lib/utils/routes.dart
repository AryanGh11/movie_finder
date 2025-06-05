import 'package:flutter/material.dart';
import 'package:movie_finder/screens/sign_in.dart';
import 'package:movie_finder/screens/sign_up.dart';
import 'package:movie_finder/screens/intro/intro.dart';
import 'package:movie_finder/screens/single_movie/single_movie.dart';

const homeRoute = "/";
const introRoute = "/intro";
const signInRoute = "/signIn";
const signUpRoute = "/signUp";
const singleMovieRoute = "/singleMovie";

final Map<String, Widget Function(BuildContext)> routes = {
  introRoute: (_) => IntroScreen(),
  signInRoute: (_) => SignInScreen(),
  signUpRoute: (_) => SignUpScreen(),
  singleMovieRoute: (_) => SingleMovieScreen(),
};
