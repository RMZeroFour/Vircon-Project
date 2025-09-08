from vircon import Axes, Snapshot, pack_snapshot_to_bytes

import asyncio
import random
import sys

CLIENT_NAME = 'Vircon Random Client'
CLIENT_VERSION = (0, 1)

async def callback(host: str, port: str):
    reader, writer = await asyncio.open_connection(host, port)
    
    writer.write(bytes(CLIENT_VERSION))
    await writer.drain()

    accepted = (await reader.readexactly(1))[0]
    if accepted:

        writer.write(bytes([len(CLIENT_NAME)]))
        writer.write(CLIENT_NAME.encode())
        await writer.drain()

        player_num = (await reader.readexactly(1))[0]

        try:
            while True:
                await asyncio.sleep(0.1)
                buttons = (random.randint(0, 1) for _ in range(14))
                left_js = Axes(random.randint(-32768, 32767), random.randint(-32768, 32767))
                right_js = Axes(random.randint(-32768, 32767), random.randint(-32768, 32767))
                ss = Snapshot(*buttons, left_js, right_js)
                data = pack_snapshot_to_bytes(ss)
                writer.write(data)

        except KeyboardInterrupt:
            writer.write(bytes([0xFF] * 10))
            await writer.drain()

    writer.close()
    await writer.wait_closed()

if __name__ == '__main__':
    host = sys.argv[1] if len(sys.argv) > 1 else 'localhost'
    port = sys.argv[2] if len(sys.argv) > 2 else '8080'

    asyncio.run(callback(host, port))