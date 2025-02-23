import 'package:flutter/material.dart';

class GamepadButton extends StatelessWidget {
  final String label;
  final Function(bool) setter;

  const GamepadButton({
    super.key,
    required this.label,
    required this.setter,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => setter(true),
      onPointerUp: (event) => setter(false),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(label),
      ),
    );
  }
}
