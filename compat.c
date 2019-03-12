#include "compat.h"

#include <stdlib.h>
#include <string.h>

int pledge(char const *promises, char const *execpromises) {
	(void)promises;
	(void)execpromises;

	return 0;
}

void *recallocarray(void *ptr, size_t oldnmemb, size_t nmemb, size_t size) {
	void *new_ptr = calloc(nmemb, size);
	if (!new_ptr) {
		return NULL;
	}

	/* If ptr is NULL, oldnmemb is ignored and the call is equivalent to
	 * calloc() */
	if (!ptr) {
		return new_ptr;
	}

	memcpy(new_ptr, ptr, oldnmemb * size);
	memset(ptr, 0x0, oldnmemb * size);
	free(ptr);

	return new_ptr;
}

/* vim: set noet ts=8 sts=8 sw=8 : */
