CASK_BIN ?= cask
EMACS_BIN ?= emacs
LEAN_BIN ?= lean
CWD   := $(shell pwd)
WATCHMAN_BIN ?= $(CWD)/watchman/bin/watchman
TMPDIR := $(shell mktemp -d /tmp/lean-tutorial.XXXX)

%.html: %.org .cask ../elisp/org-reveal-export.el
	$(CASK_BIN) emacs --no-site-file --no-site-lisp -q --batch -l ../elisp/org-reveal-export.el --visit $< -f org-reveal-export-to-html

.cask: Cask
	@EMACS=$(EMACS_BIN) $(CASK_BIN)
	@touch .cask

clean:
	rm -rf $(HTMLS)

watch-on:
	$(WATCHMAN_BIN) watch $(CWD)
	$(WATCHMAN_BIN) -- trigger $(CWD) org-files '*.org' -- make -C $(CWD) all EMACS_BIN=$(shell which $(EMACS_BIN)) LEAN_BIN=$(shell which $(LEAN_BIN))

watch-off:
	$(WATCHMAN_BIN) -- trigger-del $(CWD) org-files
	$(WATCHMAN_BIN) watch-del $(CWD)

install-cask:
	curl -fsSkL https://raw.github.com/cask/cask/master/go | python

install-watchman:
	git clone https://github.com/facebook/watchman.git
	cd watchman &&./autogen.sh && ./configure --prefix $(CWD)/watchman && make install

.PHONY: all clean install-cask install-watchman watch-on watch-off
