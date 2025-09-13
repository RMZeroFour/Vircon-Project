# The Vircon Server

The **Vircon Server** runs on Linux systems, and receives input events from connected Vircon clients with a compatible **Vircon Protocol** version. These inputs are then injected into the host system using `libevdev`, allowing the client to act as a virtual gamepad or input device.


### Requirements

- A Python 3.12+ interpreter
- The [`python-libevdev`](https://pypi.org/project/libevdev/) package, either from PyPI, or your system package manager.
- The [`libevdev`](https://www.freedesktop.org/wiki/Software/libevdev/) library from your system package manager.
- The [`pygame`](https://pypi.org/project/pygame/) package, either from PyPI, or your system package manager, for the interactive test client.

### Build Steps

```bash
pip3 install -r requirements.txt
python3 main.py
```

### Test Steps

For the random input CLI client:
```bash
pip3 install -r requirements.txt
python3 random_client.py
```

For the GUI client:
```bash
pip3 install -r requirements-test.txt
python3 gui_client.py
```
