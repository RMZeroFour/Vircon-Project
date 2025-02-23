import 'package:vircon/features/controller/snapshot.dart';

class SnapshotBatcher {
  final Duration rate;
  final Snapshot _snapshot = Snapshot();

  SnapshotBatcher(this.rate);

  Stream<Snapshot> get stream => Stream.periodic(rate, (_) => _snapshot);

  set a(bool value) => _snapshot.a = value;
  set b(bool value) => _snapshot.b = value;
  set x(bool value) => _snapshot.x = value;
  set y(bool value) => _snapshot.y = value;
  set l1(bool value) => _snapshot.l1 = value;
  set r1(bool value) => _snapshot.r1 = value;
  set l2(bool value) => _snapshot.l2 = value;
  set r2(bool value) => _snapshot.r2 = value;
  set up(bool value) => _snapshot.up = value;
  set down(bool value) => _snapshot.down = value;
  set left(bool value) => _snapshot.left = value;
  set right(bool value) => _snapshot.right = value;
  set select(bool value) => _snapshot.select = value;
  set start(bool value) => _snapshot.start = value;
  set lx(int value) => _snapshot.lx = value;
  set ly(int value) => _snapshot.ly = value;
  set rx(int value) => _snapshot.rx = value;
  set ry(int value) => _snapshot.ry = value;
}
