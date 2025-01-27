#
# SPDX-License-Identifier: GPL-3.0-or-later

PREFIX ?= /usr/local
_PROJECT=data-blockchain
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)

DOC_FILES=$(wildcard *.rst)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

all:

check: shellcheck

shellcheck:
	shellcheck -s bash $(SCRIPT_FILES)

install: install-configs install-scripts install-doc

install-configs:

	install \
	  -vDm644 \
	  "configs/genesis.json" \
	  "$(LIB_DIR)/genesis.json"

install-scripts:

	install \
	  -vDm755 \
	  "$(_PROJECT)/data-blockchain-init" \
	  "$(BIN_DIR)/data-blockchain-init"
	install \
	  -vDm755 \
	  "$(_PROJECT)/data-blockchain-bootnode" \
	  "$(BIN_DIR)/data-blockchain-bootnode"

install-doc:

	install \
	  -vDm644 \
	  $(DOC_FILES) \
	  -t \
	  $(DOC_DIR)

.PHONY: check install install-doc install-scripts shellcheck
