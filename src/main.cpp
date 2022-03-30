#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include "a.hpp"

void resize_callback(GLFWwindow* window, int width, int height);

int main() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	#endif

    // glfw window creation
    GLFWwindow* window = glfwCreateWindow(640, 360, "OpenXR Test", NULL, NULL);
    if(window == nullptr) {
        std::cerr << "Couldn't create the GLFW window!" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, resize_callback);

    // load all OpenGL function pointers
    if(!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "Couldn't initialize GLAD!" << std::endl;
        return -1;
    }    

    // render loop
    while(!glfwWindowShouldClose(window)) {
        // input
		if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
			glfwSetWindowShouldClose(window, true);

        // render
        glClearColor(0.2f, 0.6f, 0.5f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // swap frame buffers
        glfwSwapBuffers(window);
		// poll IO events (keys pressed/released, mouse moved etc)
        glfwPollEvents();
    }

    // terminate, clearing all previously allocated GLFW resources
    glfwTerminate();
    return 0;
}

// whenever the window size changed (by OS or user resize) this callback function executes
void resize_callback(GLFWwindow* window, int width, int height) {
    // make sure the viewport matches the new window dimensions
    glViewport(0, 0, width, height);
}

