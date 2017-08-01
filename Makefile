#
# libelf_man - libelf manpages
#
# AUTHOR: Joey Pabalinas <alyptik@protonmail.com>
# See LICENSE.md file for copyright and license details.
# Copyright 2017 Joey Pabalinas <alyptik@protonmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
