@REM If you need to recompile glad for some odd reason: (make it a comment if you don't need to)
clang   -Wall -Wextra -Wpedantic -Iext/include ext/src/glad.c -c -o ext/lib/glad.o

@REM Compile the main source file:
clang++ -Wall -Iext/include ext/lib/libglfw3dll.a ext/lib/glad.o main.cpp -o build/app.exe 

@REM Run the build, from it's folder (so that it's starting directory ("./") is the same as when the user will run it)
cd build
app