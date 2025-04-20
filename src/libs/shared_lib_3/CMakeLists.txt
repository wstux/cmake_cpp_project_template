LibTarget(shared_lib_3 SHARED
    HEADERS
        shared_lib_3.h
    SOURCES
        details/shared_lib_3.cpp
    INCLUDE_DIR src/libs
    LIBRARIES
        interface_lib
)

