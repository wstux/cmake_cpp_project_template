LibTarget(static_lib_2 STATIC
    HEADERS
        static_lib_2.h
    SOURCES
        details/static_lib_2.cpp
    INCLUDE_DIR src/libs
    DEPENDS
        ext1
)

