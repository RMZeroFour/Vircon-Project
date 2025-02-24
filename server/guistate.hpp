#pragma once

#include "serverstate.hpp"

#include <notcurses/notcurses.h>

class GuiState
{
public:
    GuiState(notcurses* nc, ServerState& server);
    ~GuiState();

public:
    void size_and_place();
    void handle_input(char32_t key, const ncinput* input);
    void render();

private:
    void render_background();
    void render_title();
    void render_menu();
    void render_info();

private:
    ServerState& mServer;

    ncplane* mStdPlane;
    ncplane* mTitlePlane;
    ncplane* mMenuPlane;
    ncplane* mInfoPlane;

    int mMenuIndex;
    int mSubmenuIndex;
};