import 'package:vircon_client/presentation/connection_cubit.dart';
import 'package:vircon_client/widgets/controller_layout.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart' hide ConnectionState;

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<ConnectionCubit>().disconnect();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ConnectionCubit, ConnectionState>(
            builder: (context, state) {
              if (state is Connected) {
                return ControllerLayout(
                  snapshot: state.snapshot,
                  onExit: () => Navigator.of(context).pop(),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
