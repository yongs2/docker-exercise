# Makefile for app

SHELL 		= /bin/sh
AR 			= ar
TARGET		= ${PRJ_HOME}/bin
CC			= gcc
CXX 		= g++

OBJECT_PREFIX 	= ${PRJ_HOME}/.objs
OBJECT_PATH 	= ${OBJECT_PREFIX}/app/test
EXEC			= ${OBJECT_PATH}/test

INCDIR		= -I. -I${PRJ_HOME}/src/inc -I${PRJ_HOME}/src/inc/lib

LDIR		= -L${PRJ_HOME}/lib

CFLAGS 		= ${G_PROJ_DEFINE} ${SYSTEM_DEFINE} ${SYSTEM_CFLAGS} -DDEBUG -Wall -D_REENTRANT -g

LFLAGS		= ${SYSTEM_LDFLAGS}	-lpthread -ltest

SRCS_C 		= main.c
				
OBJS_C 		= ${SRCS_C:%.c=${OBJECT_PATH}/%.o}
OBJS 		= ${OBJS_C}

# Implict rules
.SUFFIXES: .cc .cpp .c

.c.o :
	${CC} -c $< ${CFLAGS} ${INCDIR}
.cc.o :
	${CXX} -c $(CXXFLAGS} ${INCDIR} -o $@ $<
.cpp.o :
	${CXX} -c $(CXXFLAGS} ${INCDIR} -o $@ $<

all : dir ${EXEC}

dir:
	if [ ! -f ${OBJECT_PATH} ]; then mkdir -p ${OBJECT_PATH}; fi
	if [ ! -f ${TARGET} ]; then mkdir -p ${TARGET}; fi

${EXEC}: ${OBJS}
	${CC} -o ${EXEC} ${OBJS} ${LDIR} ${CFLAGS} ${LFLAGS}

${OBJECT_PATH}/%.o:%.c
	${CC} -c $< ${CFLAGS} ${INCDIR} -o $@

${OBJECT_PATH}/%.o:%.cpp
	${CXX} -c $< ${CXXFLAGS} ${INCDIR} -o $@

clean:
	rm -f ${OBJECT_PATH}/*.o ${EXEC} core ${RCF_SIM} ${MRF_SIM} ${VXF_SIM}

new:
	make clean
	make ${EXE}

install: ${EXEC}
	install ${EXEC} ${TARGET}
