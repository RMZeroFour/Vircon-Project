import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vircon/features/controller/client_socket_bloc.dart';
import 'package:vircon/features/controller/gamepad_button.dart';
import 'package:vircon/features/controller/gamepad_joystick.dart';

class Gamepad extends StatelessWidget {
  const Gamepad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            children: <Widget>[
              GamepadButton(
                label: 'A',
                setter: (x) => context.read<ClientSocketBloc>().batcher.a = x,
              ),
              GamepadButton(
                label: 'B',
                setter: (x) => context.read<ClientSocketBloc>().batcher.b = x,
              ),
              GamepadButton(
                label: 'X',
                setter: (x) => context.read<ClientSocketBloc>().batcher.x = x,
              ),
              GamepadButton(
                label: 'Y',
                setter: (x) => context.read<ClientSocketBloc>().batcher.y = x,
              ),
              GamepadButton(
                label: 'Up',
                setter: (x) => context.read<ClientSocketBloc>().batcher.up = x,
              ),
              GamepadButton(
                label: 'Left',
                setter: (x) =>
                    context.read<ClientSocketBloc>().batcher.left = x,
              ),
              GamepadButton(
                label: 'Down',
                setter: (x) =>
                    context.read<ClientSocketBloc>().batcher.down = x,
              ),
              GamepadButton(
                label: 'Right',
                setter: (x) =>
                    context.read<ClientSocketBloc>().batcher.right = x,
              ),
              GamepadButton(
                label: 'L1',
                setter: (x) => context.read<ClientSocketBloc>().batcher.l1 = x,
              ),
              GamepadButton(
                label: 'L2',
                setter: (x) => context.read<ClientSocketBloc>().batcher.l2 = x,
              ),
              GamepadButton(
                label: 'R2',
                setter: (x) => context.read<ClientSocketBloc>().batcher.r1 = x,
              ),
              GamepadButton(
                label: 'R1',
                setter: (x) => context.read<ClientSocketBloc>().batcher.r2 = x,
              ),
              const SizedBox.shrink(),
              GamepadButton(
                label: 'Start',
                setter: (x) =>
                    context.read<ClientSocketBloc>().batcher.start = x,
              ),
              GamepadButton(
                label: 'Select',
                setter: (x) =>
                    context.read<ClientSocketBloc>().batcher.select = x,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: GamepadJoystick(
                  setter: (x, y) {
                    context.read<ClientSocketBloc>().batcher.lx = x;
                    context.read<ClientSocketBloc>().batcher.ly = y;
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: GamepadJoystick(
                  setter: (x, y) {
                    context.read<ClientSocketBloc>().batcher.rx = x;
                    context.read<ClientSocketBloc>().batcher.ry = y;
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
