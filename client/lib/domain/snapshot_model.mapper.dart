// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'snapshot_model.dart';

class AxesMapper extends ClassMapperBase<Axes> {
  AxesMapper._();

  static AxesMapper? _instance;
  static AxesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AxesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Axes';

  static int _$x(Axes v) => v.x;
  static const Field<Axes, int> _f$x = Field('x', _$x, opt: true, def: 0);
  static int _$y(Axes v) => v.y;
  static const Field<Axes, int> _f$y = Field('y', _$y, opt: true, def: 0);

  @override
  final MappableFields<Axes> fields = const {#x: _f$x, #y: _f$y};

  static Axes _instantiate(DecodingData data) {
    return Axes(x: data.dec(_f$x), y: data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static Axes fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Axes>(map);
  }

  static Axes fromJson(String json) {
    return ensureInitialized().decodeJson<Axes>(json);
  }
}

mixin AxesMappable {
  String toJson() {
    return AxesMapper.ensureInitialized().encodeJson<Axes>(this as Axes);
  }

  Map<String, dynamic> toMap() {
    return AxesMapper.ensureInitialized().encodeMap<Axes>(this as Axes);
  }

  AxesCopyWith<Axes, Axes, Axes> get copyWith =>
      _AxesCopyWithImpl<Axes, Axes>(this as Axes, $identity, $identity);
  @override
  String toString() {
    return AxesMapper.ensureInitialized().stringifyValue(this as Axes);
  }

  @override
  bool operator ==(Object other) {
    return AxesMapper.ensureInitialized().equalsValue(this as Axes, other);
  }

  @override
  int get hashCode {
    return AxesMapper.ensureInitialized().hashValue(this as Axes);
  }
}

extension AxesValueCopy<$R, $Out> on ObjectCopyWith<$R, Axes, $Out> {
  AxesCopyWith<$R, Axes, $Out> get $asAxes =>
      $base.as((v, t, t2) => _AxesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AxesCopyWith<$R, $In extends Axes, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y});
  AxesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AxesCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Axes, $Out>
    implements AxesCopyWith<$R, Axes, $Out> {
  _AxesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Axes> $mapper = AxesMapper.ensureInitialized();
  @override
  $R call({int? x, int? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  Axes $make(CopyWithData data) => Axes(
    x: data.get(#x, or: $value.x),
    y: data.get(#y, or: $value.y),
  );

  @override
  AxesCopyWith<$R2, Axes, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AxesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SnapshotMapper extends ClassMapperBase<Snapshot> {
  SnapshotMapper._();

  static SnapshotMapper? _instance;
  static SnapshotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SnapshotMapper._());
      AxesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Snapshot';

  static bool _$a(Snapshot v) => v.a;
  static const Field<Snapshot, bool> _f$a = Field(
    'a',
    _$a,
    opt: true,
    def: false,
  );
  static bool _$b(Snapshot v) => v.b;
  static const Field<Snapshot, bool> _f$b = Field(
    'b',
    _$b,
    opt: true,
    def: false,
  );
  static bool _$x(Snapshot v) => v.x;
  static const Field<Snapshot, bool> _f$x = Field(
    'x',
    _$x,
    opt: true,
    def: false,
  );
  static bool _$y(Snapshot v) => v.y;
  static const Field<Snapshot, bool> _f$y = Field(
    'y',
    _$y,
    opt: true,
    def: false,
  );
  static bool _$l1(Snapshot v) => v.l1;
  static const Field<Snapshot, bool> _f$l1 = Field(
    'l1',
    _$l1,
    opt: true,
    def: false,
  );
  static bool _$r1(Snapshot v) => v.r1;
  static const Field<Snapshot, bool> _f$r1 = Field(
    'r1',
    _$r1,
    opt: true,
    def: false,
  );
  static bool _$l2(Snapshot v) => v.l2;
  static const Field<Snapshot, bool> _f$l2 = Field(
    'l2',
    _$l2,
    opt: true,
    def: false,
  );
  static bool _$r2(Snapshot v) => v.r2;
  static const Field<Snapshot, bool> _f$r2 = Field(
    'r2',
    _$r2,
    opt: true,
    def: false,
  );
  static bool _$dUp(Snapshot v) => v.dUp;
  static const Field<Snapshot, bool> _f$dUp = Field(
    'dUp',
    _$dUp,
    opt: true,
    def: false,
  );
  static bool _$dDown(Snapshot v) => v.dDown;
  static const Field<Snapshot, bool> _f$dDown = Field(
    'dDown',
    _$dDown,
    opt: true,
    def: false,
  );
  static bool _$dLeft(Snapshot v) => v.dLeft;
  static const Field<Snapshot, bool> _f$dLeft = Field(
    'dLeft',
    _$dLeft,
    opt: true,
    def: false,
  );
  static bool _$dRight(Snapshot v) => v.dRight;
  static const Field<Snapshot, bool> _f$dRight = Field(
    'dRight',
    _$dRight,
    opt: true,
    def: false,
  );
  static bool _$select(Snapshot v) => v.select;
  static const Field<Snapshot, bool> _f$select = Field(
    'select',
    _$select,
    opt: true,
    def: false,
  );
  static bool _$start(Snapshot v) => v.start;
  static const Field<Snapshot, bool> _f$start = Field(
    'start',
    _$start,
    opt: true,
    def: false,
  );
  static Axes _$leftJs(Snapshot v) => v.leftJs;
  static const Field<Snapshot, Axes> _f$leftJs = Field(
    'leftJs',
    _$leftJs,
    opt: true,
    def: const Axes(),
  );
  static Axes _$rightJs(Snapshot v) => v.rightJs;
  static const Field<Snapshot, Axes> _f$rightJs = Field(
    'rightJs',
    _$rightJs,
    opt: true,
    def: const Axes(),
  );

  @override
  final MappableFields<Snapshot> fields = const {
    #a: _f$a,
    #b: _f$b,
    #x: _f$x,
    #y: _f$y,
    #l1: _f$l1,
    #r1: _f$r1,
    #l2: _f$l2,
    #r2: _f$r2,
    #dUp: _f$dUp,
    #dDown: _f$dDown,
    #dLeft: _f$dLeft,
    #dRight: _f$dRight,
    #select: _f$select,
    #start: _f$start,
    #leftJs: _f$leftJs,
    #rightJs: _f$rightJs,
  };

  static Snapshot _instantiate(DecodingData data) {
    return Snapshot(
      a: data.dec(_f$a),
      b: data.dec(_f$b),
      x: data.dec(_f$x),
      y: data.dec(_f$y),
      l1: data.dec(_f$l1),
      r1: data.dec(_f$r1),
      l2: data.dec(_f$l2),
      r2: data.dec(_f$r2),
      dUp: data.dec(_f$dUp),
      dDown: data.dec(_f$dDown),
      dLeft: data.dec(_f$dLeft),
      dRight: data.dec(_f$dRight),
      select: data.dec(_f$select),
      start: data.dec(_f$start),
      leftJs: data.dec(_f$leftJs),
      rightJs: data.dec(_f$rightJs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Snapshot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Snapshot>(map);
  }

  static Snapshot fromJson(String json) {
    return ensureInitialized().decodeJson<Snapshot>(json);
  }
}

mixin SnapshotMappable {
  String toJson() {
    return SnapshotMapper.ensureInitialized().encodeJson<Snapshot>(
      this as Snapshot,
    );
  }

  Map<String, dynamic> toMap() {
    return SnapshotMapper.ensureInitialized().encodeMap<Snapshot>(
      this as Snapshot,
    );
  }

  SnapshotCopyWith<Snapshot, Snapshot, Snapshot> get copyWith =>
      _SnapshotCopyWithImpl<Snapshot, Snapshot>(
        this as Snapshot,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SnapshotMapper.ensureInitialized().stringifyValue(this as Snapshot);
  }

  @override
  bool operator ==(Object other) {
    return SnapshotMapper.ensureInitialized().equalsValue(
      this as Snapshot,
      other,
    );
  }

  @override
  int get hashCode {
    return SnapshotMapper.ensureInitialized().hashValue(this as Snapshot);
  }
}

extension SnapshotValueCopy<$R, $Out> on ObjectCopyWith<$R, Snapshot, $Out> {
  SnapshotCopyWith<$R, Snapshot, $Out> get $asSnapshot =>
      $base.as((v, t, t2) => _SnapshotCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SnapshotCopyWith<$R, $In extends Snapshot, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AxesCopyWith<$R, Axes, Axes> get leftJs;
  AxesCopyWith<$R, Axes, Axes> get rightJs;
  $R call({
    bool? a,
    bool? b,
    bool? x,
    bool? y,
    bool? l1,
    bool? r1,
    bool? l2,
    bool? r2,
    bool? dUp,
    bool? dDown,
    bool? dLeft,
    bool? dRight,
    bool? select,
    bool? start,
    Axes? leftJs,
    Axes? rightJs,
  });
  SnapshotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SnapshotCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Snapshot, $Out>
    implements SnapshotCopyWith<$R, Snapshot, $Out> {
  _SnapshotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Snapshot> $mapper =
      SnapshotMapper.ensureInitialized();
  @override
  AxesCopyWith<$R, Axes, Axes> get leftJs =>
      $value.leftJs.copyWith.$chain((v) => call(leftJs: v));
  @override
  AxesCopyWith<$R, Axes, Axes> get rightJs =>
      $value.rightJs.copyWith.$chain((v) => call(rightJs: v));
  @override
  $R call({
    bool? a,
    bool? b,
    bool? x,
    bool? y,
    bool? l1,
    bool? r1,
    bool? l2,
    bool? r2,
    bool? dUp,
    bool? dDown,
    bool? dLeft,
    bool? dRight,
    bool? select,
    bool? start,
    Axes? leftJs,
    Axes? rightJs,
  }) => $apply(
    FieldCopyWithData({
      if (a != null) #a: a,
      if (b != null) #b: b,
      if (x != null) #x: x,
      if (y != null) #y: y,
      if (l1 != null) #l1: l1,
      if (r1 != null) #r1: r1,
      if (l2 != null) #l2: l2,
      if (r2 != null) #r2: r2,
      if (dUp != null) #dUp: dUp,
      if (dDown != null) #dDown: dDown,
      if (dLeft != null) #dLeft: dLeft,
      if (dRight != null) #dRight: dRight,
      if (select != null) #select: select,
      if (start != null) #start: start,
      if (leftJs != null) #leftJs: leftJs,
      if (rightJs != null) #rightJs: rightJs,
    }),
  );
  @override
  Snapshot $make(CopyWithData data) => Snapshot(
    a: data.get(#a, or: $value.a),
    b: data.get(#b, or: $value.b),
    x: data.get(#x, or: $value.x),
    y: data.get(#y, or: $value.y),
    l1: data.get(#l1, or: $value.l1),
    r1: data.get(#r1, or: $value.r1),
    l2: data.get(#l2, or: $value.l2),
    r2: data.get(#r2, or: $value.r2),
    dUp: data.get(#dUp, or: $value.dUp),
    dDown: data.get(#dDown, or: $value.dDown),
    dLeft: data.get(#dLeft, or: $value.dLeft),
    dRight: data.get(#dRight, or: $value.dRight),
    select: data.get(#select, or: $value.select),
    start: data.get(#start, or: $value.start),
    leftJs: data.get(#leftJs, or: $value.leftJs),
    rightJs: data.get(#rightJs, or: $value.rightJs),
  );

  @override
  SnapshotCopyWith<$R2, Snapshot, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SnapshotCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

