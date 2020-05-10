# Makefile for lib

#ENV
SHELL			=/bin/sh
CC				=gcc
AR				=ar
TARGET			=${PRJ_HOME}/lib

#OBJECT
OBJECT_PREFIX	=${PRJ_HOME}/.objs
OBJECT_PATH		=${OBJECT_PREFIX}/lib/test
EXEC			=${OBJECT_PATH}/libtest.a
SRCS			=testlib.c
OBJS			=${SRCS:%.c=${OBJECT_PATH}/%.o}

#OPTION
INCDIR	= -I${PRJ_HOME}/src/inc -I${PRJ_HOME}/src/inc/lib
CFLAGS	= ${PRJ_DEFINE} ${SYSTEM_DEFINE} ${SYSTEM_CFLAGS} -g -Wall -D_REENTRANT -O3 -DHOME_PATH=\"${PRJ_HOME}\"
LFLAGS	= -lnsl -lsocket

#DEPENDENCY
all: dir ${EXEC}

${EXEC}: ${OBJS}
	$(AR)  $(ARFLAGS) $@ $?

$(OBJECT_PATH)/%.o: %.c
	${CC} -c -o $@ ${CFLAGS} ${INCDIR} $<

clean:
	\rm -rf ${OBJS}
	\rm -rf ${EXEC}

install: all
	chmod 755 ${EXEC}; cp ${EXEC} ${TARGET};
	\rm -rf ${EXEC}

dir:
	if [ ! -f ${OBJECT_PATH} ]; then mkdir -p ${OBJECT_PATH}; fi
	if [ ! -f ${TARGET} ]; then mkdir -p ${TARGET}; fi
