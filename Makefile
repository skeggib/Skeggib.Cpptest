CC=g++
CFLAGS=-w -std=gnu++11 -MMD
LFLAGS=

# Windows
ifeq ($(OS),Windows_NT)

	LIB=libSkeggibCpptest.a

	LFLAGS+= -static-libgcc -static-libstdc++ -lmingw32

# Linux
else

	LIB=libSkeggibCpptest.a

endif

# Objects ---------------------------------------------------------------------

O_LIB=\
	src/collectoroutput.o\
	src/compileroutput.o\
	src/htmloutput.o\
	src/missing.o\
	src/source.o\
	src/suite.o\
	src/textoutput.o\
	src/time.o\
	src/utils.o\

O_ALL=\
	$(O_LIB)\

# Compilation -----------------------------------------------------------------

%.o: %.cpp
	$(CC) -o $@ -c $< $(CFLAGS)

%.o: %.cpp %.h
	$(CC) -o $@ -c $< $(CFLAGS)

%.o: %.cpp %.hpp
	$(CC) -o $@ -c $< $(CFLAGS)

# Library ---------------------------------------------------------------------

all: $(LIB)

$(LIB): $(O_LIB)
	ar rvs $@ $^

# Dependencies ----------------------------------------------------------------

D_ALL=$(O_ALL:%.o=%.d)
-include $(D_ALL)

# Cleaning --------------------------------------------------------------------

.PHONY: clean mrproper

clean:
	@rm -rf $(O_ALL)
	@rm -rf $(D_ALL)

mrproper: clean
	@rm -rf $(LIB)
	@rm -rf $(TEST)