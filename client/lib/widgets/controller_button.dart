import 'package:flutter/material.dart';

class ControllerButton extends StatelessWidget {
  final Widget child;

  const ControllerButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.black, width: 2),
      ),
      child: child,
    );
  }
}
