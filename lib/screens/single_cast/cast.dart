import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/screens/single_cast/bloc/index.dart';
import 'package:movie_finder/screens/single_cast/widgets/index.dart';

class SingleCastScreen extends StatefulWidget {
  const SingleCastScreen({super.key});

  @override
  State<SingleCastScreen> createState() => _SingleCastScreenState();
}

class _SingleCastScreenState extends State<SingleCastScreen> {
  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);
    final castId = ModalRoute.of(context)?.settings.arguments as int?;

    return BlocProvider(
      create: (_) => CastBloc()..add(FetchCast(castId ?? -1)),
      child: BlocBuilder<CastBloc, CastState>(
        builder: (context, state) {
          if (state is CastLoading) {
            return Scaffold(
              body: Center(child: CustomCircularProgressIndicator()),
            );
          }

          if (state is CastLoaded) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SingleCastScreenAppBar(
                    cast: state.cast!,
                    localUser: localUser,
                  ),
                  SingleCastScreenContent(cast: state.cast!),
                ],
              ),
              bottomNavigationBar: state.cast != null
                  ? SingleCastScreenBottomNavigationBar(cast: state.cast!)
                  : null,
            );
          }

          return Scaffold(body: ErrorView());
        },
      ),
    );
  }
}
