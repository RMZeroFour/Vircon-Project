#pragma once

#include "gamepad.hpp"

#include <Poco/Net/ServerSocket.h>
#include <Poco/Net/TCPServer.h>

#include <atomic>
#include <mutex>
#include <shared_mutex>
#include <string>
#include <vector>

class ServerState
{
public:
    ServerState();

public:
    int count() const;
    bool is_running() const;
    
    bool is_connected(int index) const;
    bool is_locked(int index) const;
    std::string client_name(int index) const;
    const Snapshot& latest_snapshot(int index) const;

    void add_gamepad();
    void remove_gamepad();

    void toggle_locked(int index);

    void connect_gamepad(int index, const std::string& clientName);
    void disconnect_gamepad(int index);
    bool update_gamepad(int index, const Snapshot& ss);

    int next_free_gamepad();

    std::string server_host() const;
    uint16_t server_port() const;

    void start_server_async();
    void stop_server();

private:
    struct GamepadState
    {
        Gamepad gamepad;
        bool isConnected;
        bool isLocked;
        std::string clientName = "Samsoong Noot Nein";
        Snapshot latestSnapshot;
    };

private:
    std::atomic<bool> mRunning;
    std::shared_mutex mMutex;
    std::vector<GamepadState> mGamepadStates;
    Poco::Net::ServerSocket mSocket;
    Poco::Net::TCPServer mServer;
};