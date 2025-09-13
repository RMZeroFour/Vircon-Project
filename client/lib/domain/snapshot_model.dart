import 'package:dart_mappable/dart_mappable.dart';

part 'snapshot_model.mapper.dart';

@MappableClass()
class Axes with AxesMappable {
  final int x;
  final int y;

  const Axes({this.x = 0, this.y = 0});
}

@MappableClass()
class Snapshot with SnapshotMappable {
  final bool a;
  final bool b;
  final bool x;
  final bool y;
  final bool l1;
  final bool r1;
  final bool l2;
  final bool r2;
  final bool dUp;
  final bool dDown;
  final bool dLeft;
  final bool dRight;
  final bool select;
  final bool start;

  final Axes leftJs;
  final Axes rightJs;

  const Snapshot({
    this.a = false,
    this.b = false,
    this.x = false,
    this.y = false,
    this.l1 = false,
    this.r1 = false,
    this.l2 = false,
    this.r2 = false,
    this.dUp = false,
    this.dDown = false,
    this.dLeft = false,
    this.dRight = false,
    this.select = false,
    this.start = false,
    this.leftJs = const Axes(),
    this.rightJs = const Axes(),
  });
}
