CC  = gcc
CXX = g++

INCLUDE_FLAGS = -Iext/include
LIB_FLAGS     = -Lext/lib
LINK_FLAGS    = ext/lib/libglfw3dll.a

build/app.exe: obj/main.o obj/glad.o
	$(CXX)  obj/main.o obj/glad.o \
	$(LIB_FLAGS) $(LINK_FLAGS) \
	-o build/app.exe
obj/glad.o: ext/src/glad.c
	$(CC)  ext/src/glad.c \
	$(INCLUDE_FLAGS) \
	-c -o obj/glad.o
obj/main.o: src/main.cpp
	$(CXX) src/main.cpp \
	$(INCLUDE_FLAGS) \
	-c -o obj/main.o