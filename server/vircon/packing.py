from .snapshot import Axes, Snapshot

import struct

def pack_snapshot_to_bytes(snapshot: Snapshot) -> bytes:
    buttons = (
        snapshot.a, snapshot.b, snapshot.x, snapshot.y,
        snapshot.l1, snapshot.r1, snapshot.l2, snapshot.r2,
        snapshot.d_up, snapshot.d_down, snapshot.d_left, snapshot.d_right,
        snapshot.select, snapshot.start
    )
    buttons_and_padding = sum((int(b) << i) for i, b in enumerate(buttons))

    return struct.pack(
        '!Hhhhh', buttons_and_padding,
        snapshot.left_js.x, snapshot.left_js.y,
        snapshot.right_js.x, snapshot.right_js.y
    )

def unpack_snapshot_from_bytes(data: bytes) -> Snapshot:
    buttons_and_padding, left_x, left_y, right_x, right_y = struct.unpack_from('!Hhhhh', data)
    a, b, x, y, l1, r1, l2, r2, d_up, d_down, d_left, d_right, select, start = \
        (bool((buttons_and_padding >> i) & 1) for i in range(14))

    return Snapshot(
        a, b, x, y, l1, r1, l2, r2,
        d_up, d_down, d_left, d_right, select, start,
        Axes(left_x, left_y),
        Axes(right_x, right_y)
    )