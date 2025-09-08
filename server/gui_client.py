from vircon import Snapshot, pack_snapshot_to_bytes

import pygame

import asyncio
import sys
import threading
from typing import Awaitable

CLIENT_NAME = 'Vircon GUI Client'
CLIENT_VERSION = (0, 1)

def draw_snapshot(screen: pygame.Surface, font: pygame.font.Font, ss: Snapshot, mode: int) -> None:
    pygame.draw.rect(screen, (40, 40, 40), (100, 30, 440, 280), border_radius=15)

    screen.blit(font.render(f"Mode: {mode}", True, (255, 255, 255)), (10, 10))

    # Analog sticks
    pygame.draw.circle(screen, (100, 100, 255), (160, 140), 20, 2)
    pygame.draw.circle(screen, (100, 100, 255), (160 + int(ss.left_js.x / 32768 * 40), 140 + int(ss.left_js.y / 32768 * 40)), 8)

    pygame.draw.circle(screen, (255, 100, 100), (480, 140), 20, 2)
    pygame.draw.circle(screen, (255, 100, 100), (480 + int(ss.right_js.x / 32768 * 40), 140 + int(ss.right_js.y / 32768 * 40)), 8)

    # Buttons
    buttons = {
        'A': (ss.a, 480, 290),
        'B': (ss.b, 510, 260),
        'X': (ss.x, 450, 260),
        'Y': (ss.y, 480, 230),
        'L1': (ss.l1, 140, 70),
        'R1': (ss.r1, 460, 70),
        'L2': (ss.l2, 180, 70),
        'R2': (ss.r2, 500, 70),
        'Select': (ss.select, 280, 200),
        'Start': (ss.start, 360, 200),
        'Up': (ss.d_up, 160, 230),
        'Down': (ss.d_down, 160, 290),
        'Left': (ss.d_left, 130, 260),
        'Right': (ss.d_right, 190, 260)
    }

    for name, (value, x, y) in buttons.items():
        color = (0, 255, 0) if value else (100, 100, 100)
        pygame.draw.circle(screen, color, (x, y), 12)
        label = font.render(name, True, (255, 255, 255))
        screen.blit(label, (x - label.get_width() // 2, y - 25))

def main(loop: asyncio.AbstractEventLoop, queue: asyncio.Queue) -> None:
    mode = 0

    pygame.init()
    pygame.display.set_caption(CLIENT_NAME)

    clock = pygame.time.Clock()
    screen = pygame.display.set_mode((640, 360))
    font = pygame.font.Font(pygame.font.get_default_font(), 10)

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
                mode = (mode + 1) % 4

        keys = pygame.key.get_pressed()
        snapshot = Snapshot()
        match mode:
            case 0:
                snapshot.d_up = keys[pygame.K_w]
                snapshot.d_left = keys[pygame.K_a]
                snapshot.d_down = keys[pygame.K_s]
                snapshot.d_right = keys[pygame.K_d]

                snapshot.y = keys[pygame.K_i]
                snapshot.x = keys[pygame.K_j]
                snapshot.a = keys[pygame.K_k]
                snapshot.b = keys[pygame.K_l]
            case 1:
                snapshot.d_up = keys[pygame.K_w]
                snapshot.d_left = keys[pygame.K_a]
                snapshot.d_down = keys[pygame.K_s]
                snapshot.d_right = keys[pygame.K_d]

                snapshot.right_js.y = 32767 if keys[pygame.K_k] else -32768 if keys[pygame.K_i] else 0
                snapshot.right_js.x = 32767 if keys[pygame.K_l] else -32768 if keys[pygame.K_j] else 0
            case 2:
                snapshot.left_js.y = 32767 if keys[pygame.K_s] else -32768 if keys[pygame.K_w] else 0
                snapshot.left_js.x = 32767 if keys[pygame.K_d] else -32768 if keys[pygame.K_a] else 0

                snapshot.y = keys[pygame.K_i]
                snapshot.x = keys[pygame.K_j]
                snapshot.a = keys[pygame.K_k]
                snapshot.b = keys[pygame.K_l]
            case 3:
                snapshot.left_js.y = 32767 if keys[pygame.K_s] else -32768 if keys[pygame.K_w] else 0
                snapshot.left_js.x = 32767 if keys[pygame.K_d] else -32768 if keys[pygame.K_a] else 0

                snapshot.right_js.y = 32767 if keys[pygame.K_k] else -32768 if keys[pygame.K_i] else 0
                snapshot.right_js.x = 32767 if keys[pygame.K_l] else -32768 if keys[pygame.K_j] else 0
        snapshot.l1 = keys[pygame.K_q]
        snapshot.l2 = keys[pygame.K_e]
        snapshot.r1 = keys[pygame.K_u]
        snapshot.r2 = keys[pygame.K_o]
        snapshot.select = keys[pygame.K_LEFTBRACKET]
        snapshot.start = keys[pygame.K_RIGHTBRACKET]

        screen.fill((0, 0, 0))
        draw_snapshot(screen, font, snapshot, mode)
        pygame.display.flip()

        if keys[pygame.K_v]:
            asyncio.run_coroutine_threadsafe(queue.put(None), loop)
        else:
            asyncio.run_coroutine_threadsafe(queue.put(snapshot), loop)

        clock.tick(60)

    pygame.quit()

async def run_client(host: str, port: str, queue: asyncio.Queue) -> None:
    reader, writer = await asyncio.open_connection(host, port)
    
    writer.write(bytes(CLIENT_VERSION))
    await writer.drain()

    accepted = (await reader.readexactly(1))[0]
    if accepted:

        writer.write(bytes([len(CLIENT_NAME)]))
        writer.write(CLIENT_NAME.encode())
        await writer.drain()

        player_num = (await reader.readexactly(1))[0]

        ss = Snapshot()
        while ss:
            data = pack_snapshot_to_bytes(ss)
            writer.write(data)
            ss = await queue.get()

        writer.write(bytes([0xFF] * 10))
        await writer.drain()

    writer.close()
    await writer.wait_closed()

def start_background_loop(loop: asyncio.AbstractEventLoop, fn: Awaitable[None], *args) -> None:
    asyncio.set_event_loop(loop)
    loop.run_until_complete(fn(*args))

if __name__ == '__main__':
    host = sys.argv[1] if len(sys.argv) > 1 else 'localhost'
    port = sys.argv[2] if len(sys.argv) > 2 else '8080'

    loop = asyncio.new_event_loop()
    queue = asyncio.Queue()

    args = (loop, run_client, host, port, queue)
    threading.Thread(target=start_background_loop, args=args, daemon=True).start()

    main(loop, queue)
