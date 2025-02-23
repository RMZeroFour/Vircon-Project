import 'package:flutter/material.dart';

import 'package:vircon/common/widgets/widgets.dart';

class GamepadJoystick extends StatelessWidget {
  final Function(int, int) setter;

  const GamepadJoystick({
    super.key,
    required this.setter,
  });

  @override
  Widget build(BuildContext context) {
    return Joystick(
      base: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      thumb: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      thumbSize: const Size(50, 50),
      onUpdate: (offset) {
        setter((32768 * offset.dx).round(), (32768 * offset.dy).round());
      },
    );
  }
}

