LibTarget(static_lib_boost STATIC
    HEADERS
        static_lib_boost.h
    SOURCES
        details/static_lib_boost.cpp
    INCLUDE_DIR src/libs
    DEPENDS
        boost
)

