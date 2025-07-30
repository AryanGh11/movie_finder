import 'package:flutter/material.dart';
import 'package:movie_finder/screens/index.dart';

const homeRoute = "/";
const introRoute = "/intro";
const signInRoute = "/signIn";
const signUpRoute = "/signUp";
const singleMovieRoute = "/singleMovie";
const singleCastRoute = "/singleCast";

final Map<String, Widget Function(BuildContext)> routes = {
  homeRoute: (_) => HomeScreen(),
  introRoute: (_) => IntroScreen(),
  signInRoute: (_) => SignInScreen(),
  signUpRoute: (_) => SignUpScreen(),
  singleMovieRoute: (_) => SingleMovieScreen(),
  singleCastRoute: (_) => SingleCastScreen(),
};
