from vircon import Gamepad, unpack_snapshot_from_bytes

import asyncio

PROTOCOL_VERSION = (0, 1)

players = {}
lock = asyncio.Lock()

async def handshake(reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
    version = await reader.readexactly(2)
    if version[0] == PROTOCOL_VERSION[0] and version[1] == PROTOCOL_VERSION[1]:
        writer.write(bytes([0x01]))
        await writer.drain()

        name_len = (await reader.readexactly(1))[0]
        name = (await reader.readexactly(name_len)).decode()

        async with lock:
            player_id = len(players) + 1
            players[player_id] = name

        writer.write(bytes([player_id]))
        await writer.drain()

        return True
    else:
        writer.write(bytes([0x00]))
        await writer.drain()
        return True

async def callback(reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
    handshake_success = await handshake(reader, writer)
    if handshake_success:
        with Gamepad() as gp:
            terminate = False
            while not terminate:
                data = await reader.readexactly(10)
                if all(byte == 0xFF for byte in data):
                    terminate = True
                else:
                    snapshot = unpack_snapshot_from_bytes(data)
                    gp.set_state(snapshot)
            
            writer.write(bytes([0x01]))
            await writer.drain()
            writer.close()
            await writer.wait_closed()

async def main() -> None:
    print('listening on 0.0.0.0:8080')

    server = await asyncio.start_server(callback, '0.0.0.0', 8080)
    async with server:
        await server.serve_forever()

if __name__ == '__main__':
    asyncio.run(main())
