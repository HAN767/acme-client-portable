#ifndef COMPAT_H_fjawo4tjae45y
#define COMPAT_H_fjawo4tjae45y

#include <stddef.h>

#include <openssl/evp.h>

/* TODO: Replace with seccomp */
int pledge(char const *promises, char const *execpromises);

void *recallocarray(void *ptr, size_t oldnmemb, size_t nmemb, size_t size);

#if OPENSSL_VERSION_NUMBER < 0x10100000L
# define BIO_number_written(bio) ((bio)->num_write)
#endif

#endif /* COMPAT_H_fjawo4tjae45y */

/* vim: set noet ts=8 sts=8 sw=8 : */
