ifndef DEST
	DEST=${HOME}
endif

ifndef CMD
	CMD=cp
endif

ifndef ARGS
	ARGS=-r -n
endif

ifndef CPCMD
	CPCMD=$(CMD) $(ARGS)
endif

all: screen zsh vim terminal git xmonad

screen:
	@echo Copying screen config
	$(CPCMD) $(PWD)/screenrc $(DEST)/.screenrc

zsh:
	@echo Copying zsh config
	$(CPCMD) $(PWD)/zshrc $(DEST)/.zshrc

vim:
	@echo Copying vim config
	$(CPCMD) $(PWD)/vimrc $(DEST)/.vimrc

terminal:
	@echo Copying gnome-terminal config
	$(CPCMD) $(PWD)/gnome-terminal $(DEST)/.gconf/apps/

git:
	@echo Copying gitignore config
	$(CPCMD) $(PWD)/gitignore $(DEST)/.gitignore

xmonad:
	@echo Copying xmonad config
	$(CPCMD) $(PWD)/xmonad $(DEST)/.xmonad
