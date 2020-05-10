#include "testlib.h"
#include <sys/types.h>

int Sleep_m(long msec)
{
	struct timeval	timeout;
	
	timeout.tv_sec  = msec / 1000L;
	timeout.tv_usec = (msec % 1000L) * 1000L;

	return select( 0, 0, 0, 0,(struct timeval *)&timeout);
}
