all:
	@repo sync
	ln -sf config/top_config.in Config.in
	ln -sf build/top_main.mk Makefile
	ln -sf build/rules.mk rules.mk
