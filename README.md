# dwm_xcb

[![Build Status](https://travis-ci.org/nico2600/dwm_xcb.svg)](https://travis-ci.org/nico2600/dwm_xcb)

This is `dwm_xcb`, a port of the **Dynamic Window Manager (dwm)** from the traditional Xlib library to the more modern **XCB (X C Binding) library**.

**What is dwm?**
dwm is a highly minimalist, fast, and lightweight **tiling window manager** for the X Window System (X11). Tiling window managers arrange windows to fill the screen without overlapping by default, maximizing screen real estate. dwm is known for its simplicity, small codebase, and philosophy of configuration through direct modification of its C source code.

**Why XCB?**
The XCB library offers several advantages over the older Xlib:
*   **Smaller and Cleaner:** XCB has a more direct and less complex API.
*   **Improved Performance:** XCB can be faster due to its asynchronous nature and more efficient protocol handling.
*   **Modern Standard:** It is the more modern C binding for X11 development.

**Project Goals (this fork):**
This particular fork (`nico2600/dwm_xcb`) was started as a personal project with the primary goals of:
*   Learning the intricacies of the XCB library.
*   Hacking on the existing `julian-goldsmith/dwm-xcb` codebase.
*   Integrating patches and features from the official Suckless `dwm` repository (from version 5.8.2 onwards).

---

## Core Concepts of dwm

`dwm` operates on a few simple yet powerful concepts:

*   **Tiling Window Management:**
    By default, `dwm` tiles windows to fill the screen without overlapping. It typically divides the screen into a "master" area (which can hold one or more main windows) and a "stack" area for other windows. This behavior is customizable.

*   **Tags (Workspaces):**
    Instead of traditional virtual desktops, `dwm` uses "tags." You can assign one or more tags to each window. By selecting a tag or a combination of tags, you display only the windows associated with them. This allows for a flexible way to organize your workspace (e.g., tag "1" for web browsing, tag "2" for coding, etc.). The default tags are usually numbered "1" through "9".

*   **Layouts:**
    `dwm` can arrange windows in different ways using layouts. Common layouts include:
    *   **Tile:** The default, as described above.
    *   **Monocle (Fullscreen):** The currently focused window takes up the entire screen, with other windows on the same tag hidden behind it.
    *   **Floating:** Windows behave as in traditional window managers; they can be moved, resized, and overlap. This is often used for dialog boxes or specific applications that don't tile well.
    You can switch between layouts on the fly.

*   **Configuration via `config.h`:**
    `dwm` (and `dwm_xcb`) is configured by directly editing its C header file, `config.h`. There are no graphical settings panels or separate configuration files that are read at runtime. After modifying `config.h`, you must recompile `dwm_xcb` for the changes to take effect. This approach keeps the window manager small and efficient.

*   **Minimalism:**
    `dwm` is intentionally minimalist. It provides essential window management features without unnecessary bloat. Functionality is often added through patches if desired, rather than being included by default.

---

## Getting Started

### Dependencies
Before you can build `dwm_xcb`, you'll need the following dependencies:

*   **A C Compiler:** Such as `gcc` or `clang`.
*   **Make:** The build utility.
*   **XCB Libraries:** Essential for interacting with the X server. You'll typically need:
    *   `libxcb` (core XCB library)
    *   `xcb-util` (various utility libraries for XCB, including `xcb-aux` which is used here)
    *   `xcb-keysyms` (for handling keyboard symbols with XCB)
    *   `xcb-icccm` (for ICCCM client properties)
    *   `xcb-ewmh` (for Extended Window Manager Hints)
    *   `libxinerama` (if Xinerama support for multiple monitors is enabled and used).

**Example for Debian/Ubuntu-based systems:**
```bash
sudo apt-get install build-essential libxcb1-dev libxcb-util-dev libxcb-keysyms-dev libxcb-icccm4-dev libxcb-ewmh-dev libxinerama-dev
```

**Example for Arch Linux-based systems:**
```bash
sudo pacman -S base-devel xcb-util xcb-keysyms xcb-icccm xcb-ewmh libxinerama
```
*(Note: Package names might vary slightly. Consult your distribution's documentation if unsure.)*

### Building and Installing
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/nico2600/dwm_xcb.git
    cd dwm_xcb
    ```

2.  **Create your configuration:**
    `dwm_xcb` is configured by editing a C header file. Copy the default configuration template `config.def.h` to `config.h`.
    ```bash
    cp config.def.h config.h
    ```
    You will customize `config.h` later (see the "Configuration" section).

3.  **Compile and install:**
    Use `make` to build `dwm_xcb`.
    ```bash
    make
    ```
    To install it (typically to `/usr/local/bin/dwm_xcb`):
    ```bash
    sudo make install
    ```
    The `Makefile` and `config.mk` handle the build process. The `PREFIX` variable in `config.mk` (defaulting to `/usr/local`) determines the installation path.

*(Self-promotion from original author: you can also check my <a href="http://vps.michel.mn/archlinux-installer-nouveau-dwm/">Archlinux installer script with DWM</a> :))*

---

## Configuration

`dwm_xcb` inherits `dwm`'s philosophy: **configuration is done by editing the `config.h` C header file and then recompiling the source code.** This approach results in a highly efficient and customized window manager, as your settings are baked directly into the executable.

After copying `config.def.h` to `config.h` during the initial setup, you can open `config.h` in a text editor to make your changes. Here are the primary areas you'll want to customize:

*   **Appearance:**
    *   `font[]`: The font used for the status bar and window titles.
    *   `normbordercolor[]`, `normbgcolor[]`, `normfgcolor[]`: Colors for normal (unfocused) windows and the bar.
    *   `selbordercolor[]`, `selbgcolor[]`, `selfgcolor[]`: Colors for the selected (focused) window and selected items in the bar.
    *   `borderpx`: The width of window borders in pixels.
    *   `snap`: The distance (in pixels) at which windows "snap" to screen edges or other windows.
    *   `showbar`: Set to `true` to display the status bar, `false` to hide it.
    *   `topbar`: If `showbar` is `true`, `topbar = true` places the bar at the top of the screen, while `false` places it at the bottom.

*   **Tags:**
    *   `tags[]`: An array of strings defining the names for your tags (workspaces). For example: `static const char *tags[] = { "1", "2", "3", "", "", "", "", "", "" };` (using icons).

*   **Keybindings (`keys[]` array):**
    This array maps keyboard shortcuts to `dwm` actions.
    *   `MODKEY`: Defines your primary modifier key (e.g., `Mod1Mask` for Alt, `Mod4Mask` for Super/Windows key).
    *   Each entry in the `keys[]` array typically consists of: `{ modifier, key, function, {argument} }`.
        *   Example: `{ MODKEY, XK_p, spawn, {.v = dmenucmd } }` launches `dmenu` when `MODKEY + p` is pressed.
    *   You can define shortcuts for launching applications, focusing windows, changing layouts, moving windows between tags, killing clients, and much more.

*   **Mouse Actions (`buttons[]` array):**
    Defines actions for mouse clicks on different elements like window title bars, the status bar, or tags.
    *   Each entry specifies the click location, event mask (modifiers), button, function to call, and arguments.

*   **Layouts:**
    *   `mfact`: The default factor of the master area size (e.g., `0.55` means 55% of the screen for the master area).
    *   `nmaster`: The default number of clients in the master area.
    *   `resizehints`: Whether to respect size hints from windows when tiling.
    *   `layouts[]`: An array defining the available layouts, their symbols (shown in the bar), and the C function that implements them (e.g., `tile`, `monocle`, `NULL` for floating).

*   **Application Rules (`rules[]` array):**
    Define specific behaviors for windows based on their properties (class, instance, or title).
    *   Example: `{ "Gimp", NULL, NULL, 0, true, -1 }` makes Gimp windows float by default.
    *   You can assign applications to specific tags, make them floating, or open them on a particular monitor.

**Important: Recompile!**
After every change to your `config.h` file, you **must** recompile `dwm_xcb` for the changes to take effect:
```bash
make
sudo make install
```
(The `sudo make install` step is only needed if you want to update the installed version in your system path. You can often test changes by running `dwm_xcb` directly from the build directory if your X session is set up appropriately).

---

## Running dwm_xcb

Once `dwm_xcb` is compiled and installed, you need to configure your X session to use it. The most common way is by using the `.xinitrc` file in your home directory.

**Using `.xinitrc`:**

1.  Create or edit the `.xinitrc` file in your home directory (`~/.xinitrc`).
2.  Add the following line to execute `dwm_xcb` when you start your X session:

    ```sh
    exec dwm_xcb
    ```

    *   **Important:** Ensure this is the *last* command in your `.xinitrc` that starts a window manager or session. `exec` replaces the current process (your shell script) with `dwm_xcb`.
    *   Any programs you want to run at startup *before* `dwm_xcb` starts (like setting a wallpaper with `feh`, starting a compositor like `picom`, or running status bar scripts) should be placed *before* the `exec dwm_xcb` line, and usually backgrounded with an ampersand (`&`).

    **Example `.xinitrc`:**
    ```sh
    #!/bin/sh

    # Start a compositor (optional)
    # picom &

    # Set wallpaper (optional)
    # feh --bg-scale ~/.wallpaper.png &

    # Start a status bar script (optional, many dwm users have custom scripts)
    # my_statusbar_script.sh &

    # Execute dwm_xcb as the window manager
    exec dwm_xcb
    ```

3.  **Start X:**
    If you typically log in to a TTY (text console), you would then run:
    ```bash
    startx
    ```
    This command tells the X server to start and execute the commands in your `.xinitrc`.

**Using a Display Manager (e.g., LightDM, GDM, SDDM):**

If you use a display manager, it might automatically pick up `dwm` if a `.desktop` file for it exists in `/usr/share/xsessions/`. The `sudo make install` step might already place such a file.

If not, you might need to:
*   Ensure a `dwm.desktop` (or `dwm_xcb.desktop`) file exists in `/usr/share/xsessions/`. It would look something like this:
    ```desktop
    [Desktop Entry]
    Encoding=UTF-8
    Name=DWM_XCB
    Comment=Dynamic Window Manager (XCB)
    Exec=dwm_xcb
    Icon=
    Type=XSession
    ```
*   Select "DWM_XCB" (or similar) from your display manager's session menu at login.

Consult your display manager's documentation for more details on managing X sessions.

---

## Contributing & Original Project Goals

This version of `dwm_xcb` (`nico2600/dwm_xcb`) is primarily a personal project focused on:
*   Learning XCB.
*   Experimenting with the `julian-goldsmith/dwm-xcb` codebase.
*   Integrating patches from the main Suckless `dwm` repository (targeting versions from 5.8.2 onwards).

While it's a personal endeavor, if you find issues specific to this port or have suggestions related to its stated goals, feel free to open an issue on the GitHub repository.

For general `dwm` patches or discussions, the [Suckless mailing lists](https://suckless.org/community/) are the primary forum. If you are looking to contribute to the broader `dwm` or `dwm-xcb` community, please refer to their respective contribution guidelines.

---
*The benchmark information from the original README comparing XCB and Xlib performance can be found by reviewing the commit history if desired, as it was part of earlier versions of this document.*
