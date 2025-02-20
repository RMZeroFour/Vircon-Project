import 'package:flutter/material.dart';

import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vircon/app/routes.dart';
import 'package:vircon/features/connect/connect.dart';

class VirconApp extends StatelessWidget {
  final BeamerDelegate _delegate = BeamerDelegate(
    locationBuilder: (routeInformation, _) => AppLocations(routeInformation),
    guards: [
      BeamGuard(
        pathPatterns: [ControllerRoute.route],
        check: (context, location) =>
            context.read<ConnectionInfoCubit>().state != null,
        beamToNamed: (origin, target) => ConnectRoute.route,
      ),
      BeamGuard(
        pathPatterns: [ConnectRoute.route],
        check: (context, location) =>
            context.read<ConnectionInfoCubit>().state == null,
        beamToNamed: (origin, target) => ControllerRoute.route,
      )
    ],
  );

  VirconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectionInfoCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<ConnectionInfoCubit, ConnectionInfo?>(
            listener: (context, state) => _delegate.update(),
            child: MaterialApp.router(
              routeInformationParser: BeamerParser(),
              routerDelegate: _delegate,
              backButtonDispatcher:
                  BeamerBackButtonDispatcher(delegate: _delegate),
            ),
          );
        },
      ),
    );
  }
}
