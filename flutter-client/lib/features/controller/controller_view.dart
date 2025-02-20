import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vircon/features/connect/connect.dart';

class ControllerView extends StatelessWidget {
  const ControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller'),
      ),
      body: Column(
        children: [
          BlocBuilder<ConnectionInfoCubit, ConnectionInfo?>(
            builder: (context, state) => Text('${state?.host}:${state?.port}'),
          ),
          ElevatedButton(
            onPressed: context.read<ConnectionInfoCubit>().clear,
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}
