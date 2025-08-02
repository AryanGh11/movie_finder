import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.somethingWrong));
  }
}
