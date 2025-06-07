import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/auth_service/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSigning = false;
  bool _isSubmitDisabled = false;

  @override
  void initState() {
    super.initState();

    _updateSubmitState();
    _displayNameController.addListener(_updateSubmitState);
    _emailController.addListener(_updateSubmitState);
    _passwordController.addListener(_updateSubmitState);
  }

  void _updateSubmitState() {
    final shouldDisable =
        _displayNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty;

    if (_isSubmitDisabled != shouldDisable) {
      setState(() {
        _isSubmitDisabled = shouldDisable;
      });
    }
  }

  Future<void> onCreateAccountPressed() async {
    setState(() {
      _isSigning = true;
    });

    try {
      await AuthService.createWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _displayNameController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, homeRoute);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      setState(() {
        _isSigning = false;
      });
    }
  }

  void onSignInPressed() {
    Navigator.pushNamed(context, signInRoute);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign-Up")),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 30,
          right: 30,
          bottom: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  "Welcome back",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Please enter your email and password to continue.",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Column(
              spacing: 80,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  spacing: 20,
                  children: [
                    CustomTextField(
                      controller: _displayNameController,
                      label: const Text("Name"),
                      hintText: "John Doe",
                      prefixIcon: Icon(FontAwesomeIcons.user),
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: const Text("Email"),
                      hintText: "address@example.com",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      label: const Text("Password"),
                      prefixIcon: Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                  ],
                ),
                Column(
                  spacing: 20,
                  children: [
                    CustomElevatedButton(
                      text: "Sign-Up",
                      onPressed: _isSubmitDisabled
                          ? null
                          : onCreateAccountPressed,
                      loading: _isSigning,
                    ),
                    CustomElevatedButton(
                      variant: CustomElevatedButtonVariants.text,
                      text: "Already have an account?",
                      onPressed: onSignInPressed,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
