#include "compat.h"

#include <string.h>

#ifndef HAVE_reallocarray
void *reallocarray(void *ptr, size_t nmemb, size_t size)
{
	/* Close enough */
	return recallocarray(ptr, 0, nmemb, size);
}
#endif

#ifndef HAVE_recallocarray
void *recallocarray(void *ptr, size_t oldnmemb, size_t nmemb, size_t size)
{
	void *newptr = calloc(nmemb, size);
	if (!newptr) {
		return NULL;
	}

	size_t bytes;
	if (__builtin_mul_overflow(oldnmemb, size, &bytes)) {
		free(newptr);
		return NULL;
	}

	memcpy(newptr, ptr, bytes);
	free(ptr);
	return newptr;
}
#endif
