CC  = cc
CXX = c++

INCLUDE_FLAGS  = -Iext/glad/include -Iext/glfw/include
GLFW_BUILD_DIR = ext/glfw/build/src
GLFW_BUILD     = ext/glfw/build/src/libglfw3dll.a
GLFW_BUILD_DIR_WIN = $(subst /,\,$(GLFW_BUILD_DIR))

BUILD_DIR = build
BUILD_BIN = app
BUILD_ALL = $(BUILD_DIR)/$(BUILD_BIN)

SRC_DIR = src
SRC = \
	main.cpp \
	a.cpp \
	$(NULL)

OBJ_DIR = obj
OBJS = $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# Runs the project
run: $(BUILD_ALL)
	cd $(BUILD_DIR) & $(BUILD_BIN)

# Links everything toghever
$(BUILD_ALL): $(OBJS) obj/glad.o $(GLFW_BUILD)
	$(CXX) $(CXX_FLAGS) \
	$(OBJS) obj/glad.o \
	$(GLFW_BUILD) \
	-o $(BUILD_ALL)

# Creates the glad.o file
obj/glad.o: ext/glad/src/glad.c
	$(CC) $(CC_FLAGS) \
	ext/glad/src/glad.c \
	$(INCLUDE_FLAGS) \
	-c -o obj/glad.o

# When we need to build GLFW
$(GLFW_BUILD):
	cd ext/glfw & cmake -S . -B build -D BUILD_SHARED_LIBS=O & cd build & cmake --build .
	-cp   $(GLFW_BUILD_DIR)/glfw3.so  $(BUILD_DIR)
	-copy $(GLFW_BUILD_DIR_WIN)\glfw3.dll $(BUILD_DIR)

# Builds every needed source file
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $^ $(CXX_FLAGS) $(INCLUDE_FLAGS) -c -o $@