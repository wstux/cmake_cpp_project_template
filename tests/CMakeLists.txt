cmake_minimum_required (VERSION 3.10)

################################################################################
# Project definition
################################################################################

project(test
        VERSION 0.0.1
        LANGUAGES CXX)

################################################################################
# Init cmake modules path
################################################################################

set(COMMON_CMAKE_DIR "..")
set(COMMON_MAIN_CMAKE ${COMMON_CMAKE_DIR}/main.cmake)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/${COMMON_CMAKE_DIR} ${CMAKE_MODULE_PATH})

include(${COMMON_MAIN_CMAKE} PUBLIC)

################################################################################
# Include source code
################################################################################

add_subdirectory(libs/interface_lib)
add_subdirectory(libs/shared_lib)
add_subdirectory(libs/static_lib)
add_subdirectory(src)
add_subdirectory(tests)

