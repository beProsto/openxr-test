CC  = cc
CXX = c++

INCLUDE_FLAGS = -Iext/glad/include -Iext/glfw/include
LINK_FLAGS    = ext/glfw/build/src/libglfw3dll.a

BUILD_DIR  = build/
BUILD_BIN  = app
BUILD_ALL  = $(BUILD_DIR)$(BUILD_BIN)

SRC_DIR = src
OBJ_DIR = obj
SRC = \
	main.cpp \
	a.cpp \
	$(NULL)
OBJS = $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# runs the project
run: $(BUILD_ALL)
	cd $(BUILD_DIR) & $(BUILD_BIN)

# Links everything toghever
$(BUILD_ALL): $(OBJS) obj/glad.o
	$(CXX) $(OBJS) obj/glad.o \
	$(LINK_FLAGS) \
	-o $(BUILD_ALL)

# Creates the glad.o file
obj/glad.o: ext/glad/src/glad.c
	$(CC) $(CC_FLAGS) \
	ext/glad/src/glad.c \
	$(INCLUDE_FLAGS) \
	-c -o obj/glad.o

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CXX) $^ $(CXX_FLAGS) $(INCLUDE_FLAGS) -c -o $@