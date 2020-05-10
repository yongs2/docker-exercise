# Makefile for app subdirectory

BASEDIR=${PRJ_HOME}/src
SUBDIRS=	\
		test

all:
	@for SUBDIR in ${SUBDIRS}; \
	do \
		echo ">>> cd $${SUBDIR}; make -f Makefile all"; \
		cd $$SUBDIR;  \
		make -f Makefile all; \
		cd ${BASEDIR}; \
		echo "            "; \
	done

dep:
	@for SUBDIR in ${SUBDIRS}; \
	do \
		echo ">>> cd $${SUBDIR}; make -f Makefile dep"; \
		cd $$SUBDIR;  \
		make -f Makefile dep; \
		cd ${BASEDIR}; \
		echo "            "; \
	done

clean:
	@for SUBDIR in ${SUBDIRS}; \
	do \
		echo ">>> cd $${SUBDIR}; make -f Makefile clean"; \
		cd $$SUBDIR;  \
		make -f Makefile clean; \
		cd ${BASEDIR}; \
		echo "            "; \
	done

install:
	@for SUBDIR in ${SUBDIRS}; \
	do \
		echo ">>> cd $${SUBDIR}; make -f Makefile install"; \
		cd $$SUBDIR;  \
		make -f Makefile install; \
		cd ${BASEDIR}; \
		echo "            "; \
	done
