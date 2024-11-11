.PHONY: install uninstall

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

VERSION := 0.0.0
INSTALL_CMD := ln -sf

ifdef DEVELOPMENT
VERSION := $(git describe --always)
INSTALL_CMD := cp -r
endif


install:
	@echo " => installing 'paperlet'"
	@mkdir -p ~/.local/share/fonts/
	@mkdir -p ~/.local/share/typst/packages/local/paperlet/$(VERSION)/

	@$(INSTALL_CMD) $(ROOT_DIR)/paperlet.typ  ~/.local/share/typst/packages/local/paperlet/$(VERSION)/
	@$(INSTALL_CMD) $(ROOT_DIR)/typst.toml  ~/.local/share/typst/packages/local/paperlet/$(VERSION)/

	@cp $(ROOT_DIR)/font/* ~/.local/share/fonts/

	@fc-cache -f

uninstall:
	@echo " => uninstalling 'paperlet'"
	@rm -r ~/.local/share/typst/packages/local/paperlet/
