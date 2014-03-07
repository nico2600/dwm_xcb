# dwm version
VERSION = 5.8.2
DEBUG = 1		# is this a debug build?

# Customize below to fit your system

# compiler and linker
CC = gcc

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man
PKG_CONFIG_PATH = /usr/lib/x86_64-linux-gnu/
PKGLIST = xcb-aux xcb-ewmh xcb-icccm xcb-keysyms xcb
#Xinerama  TODO
#PKGLIST += xcb-xinerama

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" 
CFLAGS = -std=c99 -fdump-rtl-expand `pkg-config --cflags ${PKGLIST}` ${CPPFLAGS}
#LDFLAGS = `pkg-config --libs ${PKGLIST}`
LDFLAGS =  `pkg-config --cflags --libs xcb xcb-aux xcb-ewmh xcb-icccm xcb-keysyms`


ifeq ($(strip $(DEBUG)),1)				# FIXME: why do we have to strip this?
  CFLAGS += -g3 -pedantic -Wall -O0 -DDEBUG
  LDFLAGS += -g 
else
  CFLAGS += -O3
endif

