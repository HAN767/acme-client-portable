#include "compat.h"

int pledge(char const *promises, char const *execpromises) {
	(void)promises;
	(void)execpromises;

	return 0;
}
