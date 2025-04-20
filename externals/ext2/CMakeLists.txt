cmake_minimum_required (VERSION 3.10)

################################################################################
# Project definition
################################################################################

project(ext2
        VERSION 0.0.1
        LANGUAGES CXX)

message(STATUS "[INFO ] Build for '${CMAKE_SYSTEM_NAME}' platform")
message(STATUS "[INFO ] CMAKE_BINARY_DIR: '${CMAKE_BINARY_DIR}'")

if(CMAKE_BUILD_TYPE STREQUAL "debug" OR CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -g3")
elseif(CMAKE_BUILD_TYPE STREQUAL "release" OR CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG")
elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -DNDEBUG -g3")
elseif(CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Os -DNDEBUG")
endif()

if (CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -rdynamic")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -rdynamic")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ggdb3")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffunction-sections")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fstrict-aliasing")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pedantic")

set(TARGET_NAME "ext2")

add_library(${TARGET_NAME} INTERFACE)
target_include_directories(
    ${TARGET_NAME} INTERFACE
        "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libs>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

