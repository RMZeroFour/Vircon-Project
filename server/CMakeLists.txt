list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(libevdev REQUIRED)
find_package(NotcursesCore REQUIRED)
find_package(Poco REQUIRED COMPONENTS Net)

include(CreateNotcursesCoreTarget)
CreateNotcursesCoreTarget()

add_executable(vircon-server)
target_compile_features(vircon-server PRIVATE cxx_std_20)
target_sources(vircon-server PRIVATE connection.cpp gamepad.cpp guistate.cpp main.cpp serverstate.cpp)
target_include_directories(vircon-server PRIVATE .)
target_link_libraries(vircon-server PRIVATE libevdev::libevdev Notcurses::NotcursesCore Poco::Net)

install(TARGETS vircon-server)