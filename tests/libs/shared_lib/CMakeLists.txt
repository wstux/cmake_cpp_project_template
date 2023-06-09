LibTarget(shared_lib SHARED
    HEADERS
        shared_lib.h
    SOURCES
        details/shared_lib.cpp
    INCLUDE_DIR libs
    COMPILE_DEFINITIONS
        TEST_COMPILE_DEFINITIONS="shared_lib"
)

