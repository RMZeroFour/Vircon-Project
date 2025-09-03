from .snapshot import Snapshot

import libevdev

class Gamepad:
    DEVICE_NAME = 'Vircon Virtual Controller'

    def __init__(self) -> None:
        device = libevdev.Device()
        device.name = Gamepad.DEVICE_NAME

        device.enable(libevdev.EV_KEY.BTN_SOUTH)
        device.enable(libevdev.EV_KEY.BTN_EAST)
        device.enable(libevdev.EV_KEY.BTN_NORTH)
        device.enable(libevdev.EV_KEY.BTN_WEST)
        device.enable(libevdev.EV_KEY.BTN_TL)
        device.enable(libevdev.EV_KEY.BTN_TR)
        device.enable(libevdev.EV_KEY.BTN_TL2)
        device.enable(libevdev.EV_KEY.BTN_TR2)
        device.enable(libevdev.EV_KEY.BTN_DPAD_UP)
        device.enable(libevdev.EV_KEY.BTN_DPAD_DOWN)
        device.enable(libevdev.EV_KEY.BTN_DPAD_LEFT)
        device.enable(libevdev.EV_KEY.BTN_DPAD_RIGHT)
        device.enable(libevdev.EV_KEY.BTN_SELECT)
        device.enable(libevdev.EV_KEY.BTN_START)

        absinfo = libevdev.InputAbsInfo(minimum=-32768, maximum=32767)
        device.enable(libevdev.EV_ABS.ABS_X, absinfo)
        device.enable(libevdev.EV_ABS.ABS_Y, absinfo)
        device.enable(libevdev.EV_ABS.ABS_RX, absinfo)
        device.enable(libevdev.EV_ABS.ABS_RY, absinfo)

        self.__uinput = device.create_uinput_device()
        self.__latest = None

        self.set_state(Snapshot())

    def get_state(self) -> Snapshot:
        return self.__latest

    def set_state(self, snapshot: Snapshot) -> None:
        self.__latest = snapshot
        self.__uinput.send_events([
            libevdev.InputEvent(libevdev.EV_KEY.BTN_SOUTH, snapshot.a),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_EAST, snapshot.b),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_NORTH, snapshot.x),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_WEST, snapshot.y),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_TL, snapshot.l1),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_TR, snapshot.r1),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_TL2, snapshot.l2),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_TR2, snapshot.r2),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_DPAD_UP, snapshot.d_up),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_DPAD_DOWN, snapshot.d_down),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_DPAD_LEFT, snapshot.d_left),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_DPAD_RIGHT, snapshot.d_right),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_SELECT, snapshot.select),
            libevdev.InputEvent(libevdev.EV_KEY.BTN_START, snapshot.start),
            libevdev.InputEvent(libevdev.EV_ABS.ABS_X, snapshot.left_js.x),
            libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, snapshot.left_js.y),
            libevdev.InputEvent(libevdev.EV_ABS.ABS_RX, snapshot.right_js.x),
            libevdev.InputEvent(libevdev.EV_ABS.ABS_RY, snapshot.right_js.y),
            libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT, 0)
        ])
