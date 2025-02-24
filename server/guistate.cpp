#include "guistate.hpp"

#include <array>
#include <format>
#include <limits>
#include <sstream>

namespace
{
ncplane* create_plane(ncplane* parent, unsigned int rows, unsigned int cols)
{
    ncplane_options opts
    {
        .rows = rows,
        .cols = cols
    };
    return ncplane_create(parent, &opts);
}

std::string get_compressed_address(const std::string& host, uint16_t port)
{
    std::array<uint8_t, 4> hostBytes{};
    int index{ 0 };
    
    std::istringstream hostParts{ host };
    std::string part{};
    while (std::getline(hostParts, part, '.'))
    {
        hostBytes[index++] = std::stoi(part);
    }

    return std::format("{:2X}{:2X}{:2X}{:2X}{:4X}", 
        hostBytes[0], hostBytes[1], hostBytes[2], hostBytes[3], port);
}

void draw_qrcode(ncplane* plane, int y, int x, const char* data)
{
    unsigned int qrWidth{ 64 }, qrHeight{ 64 };
    ncplane* qrPlane{ create_plane(plane, qrHeight, qrWidth ) };

    ncplane_qrcode(qrPlane, &qrHeight, &qrWidth, data, strlen(data));

    ncplane_move_yx(qrPlane, y, x);
    ncplane_mergedown_simple(qrPlane, plane);
    
    ncplane_destroy(qrPlane);
}

void draw_joystick(ncplane* plane, nccell* indicator, int y, int x, int16_t ver, int16_t hor)
{
    const unsigned int jsWidth{ 9 }, jsHeight{ 5 };
    ncplane* jsPlane{ create_plane(plane, jsHeight, jsWidth ) };

    const int16_t threshold{ std::numeric_limits<int16_t>::max() / 3 };
    int yoff = ver > threshold ? +1 : (ver < -threshold ? -1 : 0);
    int xoff = hor > threshold ? +1 : (hor < -threshold ? -1 : 0);

    ncplane_perimeter_rounded(jsPlane, 0, 0, 0);
    ncplane_putc_yx(jsPlane, 2 + yoff, 4 + xoff * 2, indicator);

    ncplane_move_yx(jsPlane, y, x);
    ncplane_mergedown_simple(jsPlane, plane);
    
    ncplane_destroy(jsPlane);
}

void draw_snapshot(ncplane* plane, int y, ncalign_e align, const Snapshot& ss)
{
    const unsigned int ssWidth{ 36 }, ssHeight{ 8 };
    ncplane* ssPlane{ create_plane(plane, ssHeight, ssWidth ) };
    
    nccell filled{}, empty{};
    nccell_load(ssPlane, &filled, "●");
    nccell_load(ssPlane, &empty, "○");
    
    // Left side of gamepad
    ncplane_putc_yx(ssPlane, 0, 2, ss.l1 ? &filled : &empty);
    ncplane_printf(ssPlane, " L1");
    ncplane_putc_yx(ssPlane, 0, 8, ss.l2 ? &filled : &empty);
    ncplane_printf(ssPlane, " L2");

    draw_joystick(ssPlane, &filled, 1, 2, ss.ly, ss.lx);

    ncplane_putc_yx(ssPlane, 6, 0, ss.up ? &filled : &empty);
    ncplane_printf(ssPlane, " Up");
    ncplane_putc_yx(ssPlane, 7, 0, ss.down ? &filled : &empty);
    ncplane_printf(ssPlane, " Down");
    ncplane_putc_yx(ssPlane, 6, 7, ss.left ? &filled : &empty);
    ncplane_printf(ssPlane, " Left");
    ncplane_putc_yx(ssPlane, 7, 7, ss.right ? &filled : &empty);
    ncplane_printf(ssPlane, " Right");
    
    // Center of gamepad
    ncplane_putc_yx(ssPlane, 2, 14, ss.select ? &filled : &empty);
    ncplane_printf(ssPlane, " Select");
    ncplane_putc_yx(ssPlane, 3, 14, ss.start ? &filled : &empty);
    ncplane_printf(ssPlane, " Start");

    // Right side of gamepad
    ncplane_putc_yx(ssPlane, 0, 24, ss.r1 ? &filled : &empty);
    ncplane_printf(ssPlane, " R1");
    ncplane_putc_yx(ssPlane, 0, 30, ss.r2 ? &filled : &empty);
    ncplane_printf(ssPlane, " R2");

    draw_joystick(ssPlane, &filled, 1, 24, ss.ry, ss.rx);

    ncplane_putc_yx(ssPlane, 6, 24, ss.a ? &filled : &empty);
    ncplane_printf(ssPlane, " A");
    ncplane_putc_yx(ssPlane, 7, 24, ss.b ? &filled : &empty);
    ncplane_printf(ssPlane, " B");
    ncplane_putc_yx(ssPlane, 6, 31, ss.x ? &filled : &empty);
    ncplane_printf(ssPlane, " X");
    ncplane_putc_yx(ssPlane, 7, 31, ss.y ? &filled : &empty);            
    ncplane_printf(ssPlane, " Y");

    nccell_release(ssPlane, &filled);
    nccell_release(ssPlane, &empty);

    ncplane_move_yx(ssPlane, y, ncplane_halign(plane, align, ssWidth));
    ncplane_mergedown_simple(ssPlane, plane);

    ncplane_destroy(ssPlane);
}
}

GuiState::GuiState(notcurses* nc, ServerState& server)
    : mServer{ server }
    , mStdPlane{ notcurses_stdplane(nc) }
    , mTitlePlane{ create_plane(mStdPlane, 1, 1) }
    , mMenuPlane{ create_plane(mStdPlane, 1, 1) }
    , mInfoPlane{ create_plane(mStdPlane, 1, 1) }
    , mMenuIndex{ 0 }
    , mSubmenuIndex{ 0 }
{ }

GuiState::~GuiState()
{
    ncplane_destroy(mTitlePlane);
    ncplane_destroy(mMenuPlane);
    ncplane_destroy(mInfoPlane);
}

void GuiState::size_and_place()
{
    const unsigned int titleHeight{ 3 };
    const unsigned int menuWidth{ 18 };
    
    unsigned int stdWidth{}, stdHeight{};
    ncplane_dim_yx(mStdPlane, &stdHeight, &stdWidth);

    ncplane_resize_simple(mTitlePlane, titleHeight, stdWidth - 2);
    ncplane_resize_simple(mMenuPlane, stdHeight - titleHeight - 3, menuWidth);
    ncplane_resize_simple(mInfoPlane, stdHeight - titleHeight - 3, stdWidth - menuWidth - 3);

    ncplane_move_yx(mTitlePlane, 1, 1);
    ncplane_move_yx(mMenuPlane, titleHeight + 2, 1);
    ncplane_move_yx(mInfoPlane, titleHeight + 2, menuWidth + 2);
}

void GuiState::handle_input(char32_t key, const ncinput* input)
{
    switch (key)
    {
    case NCKEY_UP:
        mMenuIndex = (mMenuIndex == 0) ? mServer.count() : mMenuIndex - 1;
        break;
    case NCKEY_DOWN:
        mMenuIndex = (mMenuIndex == mServer.count()) ? 0 : mMenuIndex + 1;
        break;
    
    case NCKEY_LEFT:
    case NCKEY_RIGHT:
        mSubmenuIndex = 1 - mSubmenuIndex;
        break;
    
    case NCKEY_ENTER:
        if (mMenuIndex == 0)
        {
            if (mSubmenuIndex == 0)
            {
                mServer.add_gamepad();
            }
            else if (mServer.count() > 0)
            {
                mServer.remove_gamepad();
            }
        }
        else
        {
            int gp_index{ mMenuIndex - 1 };
        
            if (mSubmenuIndex == 0)
            {
                mServer.toggle_locked(gp_index);
            }
        }
        break;
    }
}

void GuiState::render()
{
    render_background();
    render_title();
    render_menu();
    render_info();
}

void GuiState::render_background()
{
    ncplane_erase(mStdPlane);

    unsigned int stdWidth{}, stdHeight{};
    ncplane_dim_yx(mStdPlane, &stdHeight, &stdWidth);

    unsigned int titleHeight{ ncplane_dim_y(mTitlePlane) };
    unsigned int menuWidth{ ncplane_dim_x(mMenuPlane) };

    nccell ns{}, ew{};
    nccell_load(mStdPlane, &ns, "│");
    nccell_load(mStdPlane, &ew, "─");

    ncplane_perimeter_rounded(mStdPlane, 0, 0, 0);
    ncplane_cursor_move_yx(mStdPlane, titleHeight + 1, 0);
    ncplane_putstr(mStdPlane, "├");
    ncplane_hline(mStdPlane, &ew, stdWidth - 2);
    ncplane_putstr(mStdPlane, "┤");
    ncplane_cursor_move_yx(mStdPlane, titleHeight + 1, menuWidth + 1);
    ncplane_putstr(mStdPlane, "┬");
    ncplane_cursor_move_yx(mStdPlane, titleHeight + 2, menuWidth + 1);
    ncplane_vline(mStdPlane, &ns, stdHeight - 2);
    ncplane_putstr(mStdPlane, "┴");

    nccell_release(mStdPlane, &ns);
    nccell_release(mStdPlane, &ew);
}

void GuiState::render_title()
{
    ncplane_erase(mTitlePlane);
    
    ncplane_putstr_aligned(mTitlePlane, 0, NCALIGN_CENTER, "┬  ┬┬┬─┐┌─┐┌─┐┌┐┌");
    ncplane_putstr_aligned(mTitlePlane, 1, NCALIGN_CENTER, "└┐┌┘│├┬┘│  │ ││││");
    ncplane_putstr_aligned(mTitlePlane, 2, NCALIGN_CENTER, " └┘ ┴┴└─└─┘└─┘┘└┘");
}

void GuiState::render_menu()
{
    ncplane_erase(mMenuPlane);
    
    for (int i{ 0 }; i <= mServer.count(); ++i)
    {
        ncplane_printf_aligned(mMenuPlane, i * 2 + 1, NCALIGN_LEFT, 
            " %c ", mMenuIndex == i ? '>' : ' ');

        if (i == 0)
        {
            ncplane_putstr(mMenuPlane, "Server Info");
        }
        else
        {
            ncplane_printf(mMenuPlane, "Controller #%d", i);
        }
    }
}

void GuiState::render_info()
{
    ncplane_erase(mInfoPlane);

    if (mMenuIndex == 0)
    {
        const std::string& host{ mServer.server_host() };
        uint16_t port{ mServer.server_port() };

        ncplane_printf_aligned(mInfoPlane, 1, NCALIGN_LEFT, "    Host: %s", host.c_str());
        ncplane_printf_aligned(mInfoPlane, 2, NCALIGN_LEFT, "    Port: %d", port);
        
        ncplane_printf_aligned(mInfoPlane, 4, NCALIGN_LEFT, "    Enabled: %d", mServer.count());
        ncplane_printf_aligned(mInfoPlane, 5, NCALIGN_LEFT, "    Connected: %d", mServer.count());
        ncplane_printf_aligned(mInfoPlane, 6, NCALIGN_LEFT, "    Unlocked: %d", mServer.count());
        
        draw_qrcode(mInfoPlane, 1, ncplane_dim_x(mInfoPlane) - 29, get_compressed_address(host, port).c_str());

        ncplane_printf_aligned(mInfoPlane, ncplane_dim_y(mInfoPlane) - 2, NCALIGN_LEFT,
            "    %c Add Controller", mSubmenuIndex == 0 ? '>' : ' ');
        ncplane_printf_aligned(mInfoPlane, ncplane_dim_y(mInfoPlane) - 2, NCALIGN_RIGHT,
            "%c Remove Controller    ", mSubmenuIndex == 1 ? '>' : ' ');
    }
    else
    {
        int gp_index{ mMenuIndex - 1 };

        if (mServer.is_connected(gp_index))
        {
            ncplane_putstr_aligned(mInfoPlane, 1, NCALIGN_CENTER, 
                mServer.client_name(gp_index).c_str());
            ncplane_putstr_aligned(mInfoPlane, 2, NCALIGN_CENTER, 
                mServer.is_locked(gp_index) ? "Locked" : "Unlocked");

            draw_snapshot(mInfoPlane, 5, NCALIGN_CENTER, mServer.latest_snapshot(gp_index));
        }
        else
        {
            ncplane_putstr_aligned(mInfoPlane, 1, NCALIGN_CENTER, "Not Connected");
        }

        ncplane_printf_aligned(mInfoPlane, ncplane_dim_y(mInfoPlane) - 2, NCALIGN_LEFT,
            "    %c %s Controller", mSubmenuIndex == 0 ? '>' : ' ', mServer.is_locked(gp_index) ? "Unlock" : "Lock");
        ncplane_printf_aligned(mInfoPlane, ncplane_dim_y(mInfoPlane) - 2, NCALIGN_RIGHT,
            "%c Disconnect Controller    ", mSubmenuIndex == 1 ? '>' : ' ');
    }
}