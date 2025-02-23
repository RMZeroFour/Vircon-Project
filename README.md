# The Vircon Project v0.1.0

The Vircon Project transforms your smartphone into a virtual game controller for Linux and Wine games. The project currently includes two components:

- **Server**: Written in C++, uses `libevdev` to emulate virtual game controllers on Linux.
- **Mobile Client**: Written with Flutter, connects to the server over TCP and presents an intuitive gamepad interface.

## Building and Running

### Quick Guide

Refer to below sections for individual component dependencies and prerequisites. This section is a summary on building all components at once.

1. Set up a C++ development environment, CMake, libevdev, notcurses and POCO.
2. Set up Dart, Flutter and the Android SDK.
3. Configure and build with CMake into the `build/` directory.

```bash
cmake -S . -B build/ -D CMAKE_BUILD_TYPE=Release
cmake --build build/
```

4. Install the build artifacts into the `install/` directory

```bash
cmake --install build/ --prefix install/
```

5. The install directory tree will contain the following artifacts:

```bash
install/
├── bin
│   └── vircon-server
└── share
    └── vircon
        └── vircon-flutter-client.apk
```

### Server
The server is written in C++ and uses CMake. Ensure you have the following dependencies installed:

```bash
sudo apt install build-essential cmake libevdev-dev libnotcurses-core-dev libpoco-dev
```

Build the server with CMake:

```bash
cmake -S . -B build/ -D CMAKE_BUILD_TYPE=Release
cmake --build build/ --target vircon-server
```

Lastly, start the server:

```bash
./build/vircon-server
```

### Mobile Client
The mobile client is written in Dart with Flutter. It also requires the Android SDK to be present.
Refer to [targeting Android with Flutter](https://docs.flutter.dev/get-started/install/linux/android) to set up your machine to build the client. The project also integrate building the client into a CMake target, to use it, ensure you have CMake installed.

Build the client with CMake:

```bash
cmake -S . -B build/ -D CMAKE_BUILD_TYPE=Release
cmake --build build/ --target vircon-flutter-client
```

This produces an .apk file in the `build/` directory. Install it into an Android device or emulator instance and start it.

## License

This project is licensed under the [MIT License](LICENSE.md).