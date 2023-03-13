
DESTDIR :=
PREFIX := /usr
BINDIR := ${PREFIX}/bin
SHAREDIR := ${PREFIX}/share
DATADIR := ${SHAREDIR}/laala

main:
	@echo "LAALA does not require compiling and is ready to install."
	@echo "Use 'make install' to actually do the installation, \033[38;5;206mkashikoma\033[00m!"

install:
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${DATADIR}
	sed "/^DATA_DIR *=/{s|=.*|= \"${DATADIR}\"|}" < laala.py > ${DESTDIR}${BINDIR}/laala
	chmod 0755 ${DESTDIR}${BINDIR}/laala
	install -m0644 boring_mode.txt ${DESTDIR}${DATADIR}/boring_mode.txt
	install -m0644 laala_prompt.txt ${DESTDIR}${DATADIR}/laala_prompt.txt
	install -m0644 big_text.txt ${DESTDIR}${DATADIR}/big_text.txt

