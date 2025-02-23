import 'package:flutter/material.dart';

class Joystick extends StatefulWidget {
  final Widget base;
  final Widget thumb;
  final Size thumbSize;
  final Function(Offset) onUpdate;

  const Joystick({
    super.key,
    required this.base,
    required this.thumb,
    required this.thumbSize,
    required this.onUpdate,
  });

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset? _thumbPosition;
  Size? _size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = constraints.biggest;
        _thumbPosition ??= _size!.center(Offset.zero);

        return Listener(
          onPointerDown: (event) => _moveThumb(event.localPosition),
          onPointerMove: (event) => _moveThumb(event.localPosition),
          onPointerUp: (event) => _resetThumb(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: widget.base),
              Positioned(
                left: _thumbPosition!.dx - (widget.thumbSize.width / 2),
                top: _thumbPosition!.dy - (widget.thumbSize.height / 2),
                child: SizedBox(
                  width: widget.thumbSize.width,
                  height: widget.thumbSize.height,
                  child: widget.thumb,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _moveThumb(Offset localPosition) {
    final Offset center = _size!.center(Offset.zero);
    final double maxDistance = _size!.width / 2;

    final Offset offsetVector = localPosition - center;
    final double offsetDistance = offsetVector.distance;

    final Offset clampedVector = offsetDistance > maxDistance
        ? offsetVector / offsetDistance * maxDistance
        : offsetVector;
    setState(() => _thumbPosition = center + clampedVector);

    final Offset normalizedOffset = clampedVector / maxDistance;
    widget.onUpdate(normalizedOffset);
  }

  void _resetThumb() {
    setState(() => _thumbPosition = _size!.center(Offset.zero));
    widget.onUpdate(Offset.zero);
  }
}
