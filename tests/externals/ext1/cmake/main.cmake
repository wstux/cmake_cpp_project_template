cmake_minimum_required (VERSION 3.10)

################################################################################
# Build check
################################################################################

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "[INFO ] Build for '${CMAKE_SYSTEM_NAME}' platform")
else()
    message(FATAL_ERROR "[FATAL] Unsupported '${CMAKE_SYSTEM_NAME}' platform")
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
        "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE)
    message(STATUS "[INFO ] Use default build type: '${CMAKE_BUILD_TYPE}'")
else()
    message(STATUS "[INFO ] Build type: '${CMAKE_BUILD_TYPE}'")
endif()

################################################################################
# Definitions
################################################################################

message(STATUS "[INFO ] CMAKE_BINARY_DIR: '${CMAKE_BINARY_DIR}'")
# Common options
# To write if need.

# Build options
option(USE_ADDR_SANITIZER   "Try to use the address sanitizer" OFF)
option(USE_COVERAGE         "Try to use coverage flag" OFF)
option(USE_FAST_MATH        "Tell the compiler to use fast math" OFF)
option(USE_LTO              "Use link-time optimization for release builds" ON)
option(USE_PEDANTIC         "Tell the compiler to be pedantic" ON)
option(USE_PTHREAD          "Use pthread library" OFF)
option(USE_WERROR           "Tell the compiler to make the build fail when warnings are present" ON)

################################################################################
# Configuration options
################################################################################

include(CMakeDependentOption)

include(build_flags)

if(CMAKE_C_COMPILER)
    message(STATUS "[INFO ] C compiler flags: '${CMAKE_C_FLAGS}'")
    if(CMAKE_BUILD_TYPE STREQUAL "debug" OR CMAKE_BUILD_TYPE STREQUAL "Debug")
        message(STATUS "[INFO ] C debug compiler flags: '${CMAKE_C_FLAGS_DEBUG}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "release" OR CMAKE_BUILD_TYPE STREQUAL "Release")
        message(STATUS "[INFO ] C release compiler flags: '${CMAKE_C_FLAGS_RELEASE}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        message(STATUS "[INFO ] C rel_with_deb_info compiler flags: '${CMAKE_C_FLAGS_RELWITHDEBINFO}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
        message(STATUS "[INFO ] C min_size_rel compiler flags: '${CMAKE_C_FLAGS_MINSIZEREL}'")
    endif()
    message(STATUS "[INFO ] C link executable: ${CMAKE_C_LINK_EXECUTABLE}")
endif()
if(CMAKE_CXX_COMPILER)
    message(STATUS "[INFO ] C++ compiler flags: '${CMAKE_CXX_FLAGS}'")
    if(CMAKE_BUILD_TYPE STREQUAL "debug" OR CMAKE_BUILD_TYPE STREQUAL "Debug")
        message(STATUS "[INFO ] C++ debug compiler flags: '${CMAKE_CXX_FLAGS_DEBUG}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "release" OR CMAKE_BUILD_TYPE STREQUAL "Release")
        message(STATUS "[INFO ] C++ release compiler flags: '${CMAKE_CXX_FLAGS_RELEASE}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        message(STATUS "[INFO ] C++ rel_with_deb_info compiler flags: '${CMAKE_CXX_FLAGS_RELWITHDEBINFO}'")
    elseif(CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
        message(STATUS "[INFO ] C++ min_size_rel compiler flags: '${CMAKE_CXX_FLAGS_MINSIZEREL}'")
    endif()
    message(STATUS "[INFO ] C++ link executable: ${CMAKE_CXX_LINK_EXECUTABLE}")
endif()

message(STATUS "[INFO ] Exe linker flags: ${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "[INFO ] Module linker flags: ${CMAKE_MODULE_LINKER_FLAGS}")
message(STATUS "[INFO ] Shared linker flags: ${CMAKE_SHARED_LINKER_FLAGS}")

################################################################################
# Include targets functions
################################################################################

include(build_targets)
include(externals_targets)

