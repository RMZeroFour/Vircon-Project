from dataclasses import dataclass, field

@dataclass
class Axes:
    x: int = field(default=0)
    y: int = field(default=0)

@dataclass
class Snapshot:
    a: bool = field(default=False)
    b: bool = field(default=False)
    x: bool = field(default=False)
    y: bool = field(default=False)
    l1: bool = field(default=False)
    r1: bool = field(default=False)
    l2: bool = field(default=False)
    r2: bool = field(default=False)
    d_up: bool = field(default=False)
    d_down: bool = field(default=False)
    d_left: bool = field(default=False)
    d_right: bool = field(default=False)
    select: bool = field(default=False)
    start: bool = field(default=False)
    left_js: Axes = field(default_factory=Axes)
    right_js: Axes = field(default_factory=Axes)