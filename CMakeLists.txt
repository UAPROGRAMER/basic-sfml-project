cmake_minimum_required(VERSION 3.10)

project(basic-sfml-project)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES src/main.cpp)

add_library(object OBJECT ${SOURCES})

add_executable(exec $<TARGET_OBJECTS:object>)

find_package(SFML 2.5.1 COMPONENTS graphics window system REQUIRED)
target_link_libraries(exec sfml-graphics sfml-window sfml-system)
