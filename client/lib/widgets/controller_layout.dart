import 'package:flutter/material.dart';
import 'package:vircon_client/domain/snapshot_model.dart';
import 'package:vircon_client/widgets/controller_button.dart';

class ControllerLayout extends StatelessWidget {
  final Snapshot snapshot;
  final Function() onExit;

  const ControllerLayout({
    super.key,
    required this.snapshot,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Stack(
        children: [
          Positioned(
            left: 60,
            bottom: 160,
            child: TapRegion(
              onTapInside: (event) => snapshot.dUp = true,
              onTapUpInside: (event) => snapshot.dUp = false,
              child: ControllerButton(child: Center(child: const Text('Up'))),
            ),
          ),
          Positioned(
            left: 100,
            bottom: 120,
            child: TapRegion(
              onTapInside: (event) => snapshot.dRight = true,
              onTapUpInside: (event) => snapshot.dRight = false,
              child: ControllerButton(
                child: Center(child: const Text('Right')),
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 80,
            child: TapRegion(
              onTapInside: (event) => snapshot.dDown = true,
              onTapUpInside: (event) => snapshot.dDown = false,
              child: ControllerButton(child: Center(child: const Text('Down'))),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 120,
            child: TapRegion(
              onTapInside: (event) => snapshot.dLeft = true,
              onTapUpInside: (event) => snapshot.dLeft = false,
              child: ControllerButton(child: Center(child: const Text('Left'))),
            ),
          ),

          Positioned(
            right: 60,
            bottom: 160,
            child: TapRegion(
              onTapInside: (event) => snapshot.y = true,
              onTapUpInside: (event) => snapshot.y = false,
              child: ControllerButton(child: Center(child: const Text('Y'))),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 120,
            child: TapRegion(
              onTapInside: (event) => snapshot.x = true,
              onTapUpInside: (event) => snapshot.x = false,
              child: ControllerButton(child: Center(child: const Text('X'))),
            ),
          ),
          Positioned(
            right: 60,
            bottom: 80,
            child: TapRegion(
              onTapInside: (event) => snapshot.a = true,
              onTapUpInside: (event) => snapshot.a = false,
              child: ControllerButton(child: Center(child: const Text('A'))),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 120,
            child: TapRegion(
              onTapInside: (event) => snapshot.b = true,
              onTapUpInside: (event) => snapshot.b = false,
              child: ControllerButton(child: Center(child: const Text('B'))),
            ),
          ),

          Positioned(
            left: 20,
            top: 20,
            child: TapRegion(
              onTapInside: (event) => snapshot.l1 = true,
              onTapUpInside: (event) => snapshot.l1 = false,
              child: ControllerButton(child: Center(child: const Text('L1'))),
            ),
          ),
          Positioned(
            left: 20,
            top: 80,
            child: TapRegion(
              onTapInside: (event) => snapshot.l2 = true,
              onTapUpInside: (event) => snapshot.l2 = false,
              child: ControllerButton(child: Center(child: const Text('L2'))),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: TapRegion(
              onTapInside: (event) => snapshot.r1 = true,
              onTapUpInside: (event) => snapshot.r1 = false,
              child: ControllerButton(child: Center(child: const Text('R1'))),
            ),
          ),
          Positioned(
            right: 20,
            top: 80,
            child: TapRegion(
              onTapInside: (event) => snapshot.r2 = true,
              onTapUpInside: (event) => snapshot.r2 = false,
              child: ControllerButton(child: Center(child: const Text('R2'))),
            ),
          ),

          Positioned(
            left: 200,
            bottom: 10,
            child: TapRegion(
              onTapInside: (event) => snapshot.select = true,
              onTapUpInside: (event) => snapshot.select = false,
              child: ControllerButton(
                child: Center(child: const Text('Select')),
              ),
            ),
          ),
          Positioned(
            left: 300,
            bottom: 10,
            child: TapRegion(
              onTapInside: (event) => snapshot.start = true,
              onTapUpInside: (event) => snapshot.start = false,
              child: ControllerButton(
                child: Center(child: const Text('Start')),
              ),
            ),
          ),
          Positioned(
            left: 400,
            bottom: 10,
            child: TapRegion(
              onTapInside: (event) => onExit(),
              child: ControllerButton(child: Center(child: const Text('Back'))),
            ),
          ),
        ],
      ),
    );
  }
}
