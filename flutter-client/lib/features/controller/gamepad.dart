import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vircon/features/controller/client_socket_bloc.dart';

class Gamepad extends StatelessWidget {
  const Gamepad({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        createButton(context, 'A',
            (x) => context.read<ClientSocketBloc>().batcher.a = x),
        createButton(context, 'B',
            (x) => context.read<ClientSocketBloc>().batcher.b = x),
        createButton(context, 'X',
            (x) => context.read<ClientSocketBloc>().batcher.x = x),
        createButton(context, 'Y',
            (x) => context.read<ClientSocketBloc>().batcher.y = x),
        createButton(context, 'Up',
            (x) => context.read<ClientSocketBloc>().batcher.up = x),
        createButton(context, 'Left',
            (x) => context.read<ClientSocketBloc>().batcher.left = x),
        createButton(context, 'Down',
            (x) => context.read<ClientSocketBloc>().batcher.down = x),
        createButton(context, 'Right',
            (x) => context.read<ClientSocketBloc>().batcher.right = x),
        createButton(context, 'L1',
            (x) => context.read<ClientSocketBloc>().batcher.l1 = x),
        createButton(context, 'L2',
            (x) => context.read<ClientSocketBloc>().batcher.l2 = x),
        createButton(context, 'R2',
            (x) => context.read<ClientSocketBloc>().batcher.r1 = x),
        createButton(context, 'R1',
            (x) => context.read<ClientSocketBloc>().batcher.r2 = x),
        createButton(context, 'Start',
            (x) => context.read<ClientSocketBloc>().batcher.start = x),
        createButton(context, 'Select',
            (x) => context.read<ClientSocketBloc>().batcher.select = x),
      ],
    );
  }

  Widget createButton(
      BuildContext context, String text, Function(bool) setter) {
    return Listener(
      onPointerDown: (event) => setter(true),
      onPointerUp: (event) => setter(false),
      child: Container(
        width: 25,
        height: 25,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
