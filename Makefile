

nsls2-archive_KEYS:=$(wildcard archive/*.pub)
nsls2-archive_IDS:=$(nsls2-archive_KEYS:archive/%.pub=%)

all: nsls2-archive-keyring.gpg

install:
	install -m755 -d ${DESTDIR}/usr/share/keyrings
	install -m644 nsls2-archive-keyring.gpg  ${DESTDIR}/usr/share/keyrings/

%-keyring.gpg:
	rm -rf "$*-home"
	install -m 700 -d "$*-home"
	GNUPGHOME="$$PWD/$*-home" gpg --import $($*_KEYS)
	GNUPGHOME="$$PWD/$*-home" gpg --armor --output $@ --export $($*_IDS)

clean:
	rm -rf nsls2-archive-home
	rm -f nsls2-archive-keyring.gpg
