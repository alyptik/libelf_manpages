#
# libelf_man - libelf manpages
#
# AUTHOR: Joey Pabalinas <alyptik@protonmail.com>
# See LICENSE.md file for copyright and license details.
# Copyright 2017 Joey Pabalinas <alyptik@protonmail.com>

DESTDIR ?=
PREFIX ?= /usr/local

TARGET := libelf_man
SECT1 := $(wildcard man1/*.1)
SECT3 := $(wildcard man3/*.3)

all $(TARGET): dist

install:
	@printf "%s\n" "installing"
	@mkdir -pv $(DESTDIR)$(PREFIX)/share/man/man1
	@mkdir -pv $(DESTDIR)$(PREFIX)/share/man/man3
	install -c $(SECT1) $(DESTDIR)$(PREFIX)/share/man/man1
	install -c $(SECT3) $(DESTDIR)$(PREFIX)/share/man/man3

uninstall:
	@printf "%s\n" "uninstalling"
	rm -f $(addprefix $(DESTDIR)$(PREFIX)/share/man/, $(SECT1))
	rm -f $(addprefix $(DESTDIR)$(PREFIX)/share/man/, $(SECT3))

dist: clean
	@printf "%s\n" "creating dist tarball"
	@mkdir -pv $(TARGET)/
	cp -R LICENSE.md Makefile README.md $(SECT1) $(SECT3) $(TARGET)/
	tar -czf $(TARGET).tar.gz $(TARGET)/
	rm -rf $(TARGET)/

clean:
	@printf "%s\n" "cleaning"
	rm -f $(TARGET).tar.gz

.PHONY: all clean install uninstall dist
