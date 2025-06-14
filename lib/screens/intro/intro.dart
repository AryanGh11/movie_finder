import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/index.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  List<Intro> _intros = [];
  bool _isLoading = false;
  bool _isSigningWithGoogle = false;

  @override
  void initState() {
    super.initState();
    getIntros();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> getIntros() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/intro_configuration.json',
      );

      final List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        _intros = jsonList.map((json) => Intro.fromJson(json)).toList();
      });
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> onSignInWithGooglePressed() async {
    setState(() {
      _isSigningWithGoogle = true;
    });

    try {
      final res = await AuthService.signInWithGoogle();
      if (res != null) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, homeRoute);
      }
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      setState(() {
        _isSigningWithGoogle = false;
      });
    }
  }

  void onSignInWithEmailPressed() {
    Navigator.of(context).pushNamed(signInRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CustomCircularProgressIndicator())
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _intros.length,
                  itemBuilder: (context, index) {
                    final Intro intro = _intros[index];
                    final bool isLastIntro = _intros.length == (index + 1);

                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomCachedImage(
                          imageUrl: intro.posterPath,
                          fit: BoxFit.cover,
                          fullScreenOnTap: false,
                        ),
                        Container(color: Colors.black26),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              spacing: 40,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                isLastIntro
                                    ? Column(
                                        spacing: 20,
                                        children: [
                                          CustomElevatedButton(
                                            onPressed:
                                                onSignInWithGooglePressed,
                                            text: "Sign-In with Google",
                                            prefixIcon: FontAwesomeIcons.google,
                                            loading: _isSigningWithGoogle,
                                          ),
                                          CustomElevatedButton(
                                            variant:
                                                CustomElevatedButtonVariants
                                                    .text,
                                            onPressed: onSignInWithEmailPressed,
                                            text: "Sign-In with E-Mail",
                                            prefixIcon: Icons.email,
                                          ),
                                        ],
                                      )
                                    : const Text(""),
                                Text(
                                  intro.text.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: Center(
                    child: _intros.isNotEmpty
                        ? SmoothPageIndicator(
                            count: _intros.length,
                            controller: _pageController,
                            onDotClicked: (index) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white38,
                              dotHeight: 10,
                              dotWidth: 10,
                              expansionFactor: 3,
                            ),
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
