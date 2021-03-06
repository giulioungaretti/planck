
#path
KEYBOARD=planck
KEYMAP=giulio
SRC=~/src
QMK_DIR=$(SRC)/qmk_firmware
BASEPATH=$(QMK_DIR)/keyboards/$(KEYBOARD)/keymaps
MYPATH=$(BASEPATH)/$(KEYMAP)

init:
	./kybd.sh $(QMK_DIR) $(MYPATH)

#But to run make with root privilege is not good idea. Use former method if possible.
flash:
	cd $(QMK_DIR);\
	make $(KEYBOARD):$(KEYMAP):dfu

update:
	cd $(QMK_DIR);\
	git pull --ff-only

edit:
	cd $(MYPATH); vim keymap.c

PHONY: init udpate clean flash edit
