dwm_xcb
=======
----------------------------------------
Personal project only for fun and profit
The main goal is to learn XCB by hacking the source code of github.com/julian-goldsmith/dwm-xcb.
For now, I try to integrate as much patches as i can from suckless repo (from tag 5.8.2 until now)

----------------------------------------

----------------------------------------
DWM is a lightweight Window manager for Linux.
Originally, it's based on X11 library which contain many unused code (old or esoteric hard/conf supported) but is about to be deprecated (Hello Wayland!).
So, I wanted to try it with XCB :-)
XCB lib is more clear/smaller than X11 and faster because it uses more "low-level" stuff

here is a small benchmark(source: Arnaud Fontaine/Porting a Window Manager from Xlib to XCB:)

Pour 50 000 messages traités :
=> XCB wrong usage(synchronous)
Duration : 0.662640 s

=> XCB bad usage (asynchronous)
Duration : 0.020377 s
Ratio: 32.52

=> Xlib traditional usage
Duration: 0.778176 s
Ratio: 38.19

Asynchronous version of XCB message handling is 25 times faster than X11 one  \o/
