[![Build Status](https://travis-ci.org/nico2600/dwm_xcb.svg)](https://travis-ci.org/nico2600/dwm_xcb)

<h1>dwm_xcb alpha</h1>

=======
<img src="http://vps.michel.mn/build.png">
<p>
Personal project only for fun and profit<br>
The main goal is to learn XCB by hacking the source code of github.com/julian-goldsmith/dwm-xcb.<br>
For now, I try to integrate as much patches as i can from suckless repo (from tag 5.8.2 until now)
</p>
----------------------------------------
<p>
DWM is a lightweight Window manager for Linux.<br>
Originally, it's based on X11 library which contain many unused code (old or esoteric hard/conf supported) but is about to be deprecated (Hello Wayland!).<br>
So, I wanted to try it with XCB :-)<br>
XCB lib is more clear/smaller than X11 and faster because it uses more "low-level" stuff
</p>
<p>
here is a small benchmark<i>(source: Arnaud Fontaine/Porting a Window Manager from Xlib to XCB:)</i><br>

for 50 000 messages :
<ul>
<li> XCB wrong usage(synchronous)<br>
Duration : 0.662640 s

<li> XCB bad usage (asynchronous)<br>
Duration : 0.020377 s<br>
Ratio: 32.52

<li> Xlib traditional usage<br>
Duration: 0.778176 s<br>
Ratio: 38.19
</ul>
On average, asynchronous version of XCB message handling is 25 times faster than X11 one  \o/
</p>
