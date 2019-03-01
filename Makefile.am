AM_CFLAGS = \
	-Wall \
	-Werror \
	-Wextra \
	-Wmissing-declarations \
	-Wmissing-prototypes \
	-Wpointer-arith \
	-Wshadow \
	-Wsign-compare \
	-Wstrict-prototypes \
	-Wunused \
	-flto \
	@OPENSSL_INCLUDES@
AM_LDFLAGS = \
	-flto \
	@OPENSSL_LDFLAGS@ @OPENSSL_LIBS@


bin_PROGRAMS = acme-client

acme_client_SOURCES = \
	acctproc.c \
	base64.c \
	certproc.c \
	chngproc.c \
	dbg.c \
	dnsproc.c \
	fileproc.c \
	http.c \
	jsmn.c \
	json.c \
	keyproc.c \
	main.c \
	netproc.c \
	parse.y \
	revokeproc.c \
	rsa.c \
	util.c

dist_man_MANS = \
	acme-client.1 \
	acme-client.conf.5

# vim: noet ts=8 sts=8 sw=8:
