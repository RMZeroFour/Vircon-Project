#pragma once

#include "serverstate.hpp"

#include <Poco/Net/StreamSocket.h>
#include <Poco/Net/TCPServerConnection.h>

class GamepadConnection
    : public Poco::Net::TCPServerConnection 
{
public:
    GamepadConnection(const Poco::Net::StreamSocket& socket, ServerState& serverState);

public:
    void run() override;

private:
    void perform_handshake(Poco::BinaryReader& reader, Poco::BinaryWriter& writer);
    void handle_version_1(Poco::BinaryReader& reader, Poco::BinaryWriter& writer);

private:
    ServerState& mServerState;
};