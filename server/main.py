from vircon import Gamepad, Snapshot

import pygame

def draw_joystick_state(screen: pygame.Surface, font: pygame.font.Font, joystick: pygame.joystick.Joystick, mode: int) -> None:
    pygame.draw.rect(screen, (40, 40, 40), (100, 30, 440, 280), border_radius=15)

    screen.blit(font.render(f"Mode: {mode}", True, (255, 255, 255)), (10, 10))

    # Analog sticks
    pygame.draw.circle(screen, (100, 100, 255), (160, 140), 20, 2)
    pygame.draw.circle(screen, (100, 100, 255), (160 + int(joystick.get_axis(0) * 40), 140 + int(joystick.get_axis(1) * 40)), 8)

    pygame.draw.circle(screen, (255, 100, 100), (480, 140), 20, 2)
    pygame.draw.circle(screen, (255, 100, 100), (480 + int(joystick.get_axis(2) * 40), 140 + int(joystick.get_axis(3) * 40)), 8)

    # Buttons
    buttons = {
        'A': (0, 480, 290),
        'B': (1, 510, 260),
        'X': (2, 450, 260),
        'Y': (3, 480, 230),
        'L1': (4, 140, 70),
        'R1': (5, 460, 70),
        'L2': (6, 180, 70),
        'R2': (7, 500, 70),
        'Select': (8, 280, 200),
        'Start': (9, 360, 200),
        'Up': (10, 160, 230),
        'Down': (11, 160, 290),
        'Left': (12, 130, 260),
        'Right': (13, 190, 260)
    }

    for name, (index, x, y) in buttons.items():
        color = (0, 255, 0) if joystick.get_button(index) else (100, 100, 100)
        pygame.draw.circle(screen, color, (x, y), 12)
        label = font.render(name, True, (255, 255, 255))
        screen.blit(label, (x - label.get_width() // 2, y - 25))

def main() -> None:
    gamepad = Gamepad()
    mode = 0

    pygame.init()
    pygame.display.set_caption('Vircon Test Client')

    clock = pygame.time.Clock()
    screen = pygame.display.set_mode((640, 360))
    font = pygame.font.Font(pygame.font.get_default_font(), 10)

    joystick = pygame.joystick.Joystick(0)

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
        gamepad.set_state(snapshot)

        screen.fill((0, 0, 0))

        draw_joystick_state(screen, font, joystick, mode)

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()


if __name__ == '__main__':
    main()
