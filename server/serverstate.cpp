#include "serverstate.h"

#include "connection.h"

#include <Poco/Net/IPAddress.h>
#include <Poco/Net/NetworkInterface.h>
#include <Poco/Net/TCPServerConnectionFactory.h>
#include <Poco/Net/TCPServerParams.h>

#include <array>

using namespace Poco::Net;

namespace
{
class GamepadConnectionFactory
    : public TCPServerConnectionFactory
{
public:
    GamepadConnectionFactory(ServerState& serverState)
        : mServerState{ serverState }
    { }

public:
	TCPServerConnection* createConnection(const StreamSocket& socket)
	{
		return new GamepadConnection(socket, mServerState);
	}

private:
    ServerState& mServerState;
};

SocketAddress get_socket_endpoint()
{
    IPAddress address{};
    for (const NetworkInterface& iface : NetworkInterface::list())
    {
        if (iface.isRunning() && !iface.isLoopback())
        {
            iface.firstAddress(address);
            break;
        }
    }
    return { address, 0 };
}

TCPServer create_server(const ServerSocket& socket, ServerState& serverState)
{
    return
    {
        new GamepadConnectionFactory{ serverState },
        socket,
        new TCPServerParams{}
    };
}
}

ServerState::ServerState()
    : mRunning{}
    , mMutex{}
    , mGamepadStates{}
    , mSocket{ get_socket_endpoint() }
    , mServer{ create_server(mSocket, *this) }
{}

int ServerState::count() const
{
    return mGamepadStates.size();
}

bool ServerState::is_running() const
{
    return mRunning.load();
}

bool ServerState::is_connected(int index) const
{
    return mGamepadStates.at(index).isConnected;
}

bool ServerState::is_locked(int index) const
{
    return mGamepadStates.at(index).isLocked;
}

std::string ServerState::client_name(int index) const
{
    return mGamepadStates.at(index).clientName;
}

const Snapshot& ServerState::latest_snapshot(int index) const
{
    return mGamepadStates.at(index).latestSnapshot;
}

void ServerState::add_gamepad()
{
    std::unique_lock ul{ mMutex }; 
    mGamepadStates.emplace_back();
}

void ServerState::remove_gamepad()
{
    std::unique_lock ul{ mMutex }; 
    mGamepadStates.pop_back();
}

void ServerState::toggle_locked(int index)
{
    std::shared_lock sl{ mMutex };
    mGamepadStates[index].isLocked = !mGamepadStates[index].isLocked;
}

void ServerState::connect_gamepad(int index, const std::string& clientName)
{
    std::shared_lock sl{ mMutex }; 
    mGamepadStates[index].isConnected = true;
    mGamepadStates[index].clientName = clientName;
}

void ServerState::disconnect_gamepad(int index)
{
    std::shared_lock sl{ mMutex };
    mGamepadStates[index].isConnected = false;
    mGamepadStates[index].clientName = "";
}

bool ServerState::update_gamepad(int index, const Snapshot& ss)
{
    std::shared_lock sl{ mMutex };

    if (index >= mGamepadStates.size())
    {
        return false;
    }

    GamepadState& gps{ mGamepadStates[index] };
    if (!gps.isLocked)
    {
        gps.latestSnapshot = ss;
        gps.gamepad.send_input(ss);
    }

    return true;
}

int ServerState::next_free_gamepad()
{
    std::unique_lock ul{ mMutex };

    for (int i = 0; i < mGamepadStates.size(); ++i)
    {
        if (!mGamepadStates[i].isConnected)
        {
            return i;
        }
    }

    return -1;
}

std::string ServerState::server_host() const
{
    return mSocket.address().host().toString();
}

uint16_t ServerState::server_port() const
{
    return mSocket.address().port();
}

void ServerState::start_server_async()
{
    mRunning.store(true);
    mServer.start();
}

void ServerState::stop_server()
{
    mServer.stop();
    mRunning.store(false);
}
