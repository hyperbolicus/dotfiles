#LUA_VERSION := 5.1
PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/share/lua/$(LUA_VERSION)
INSTALL ?= install

.PHONY: all test install

all: ;

install: all
	find . -type f
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/personalconfig
	$(INSTALL) ./*.lua $(DESTDIR)/$(LUA_LIB_DIR)/personalconfig
