ExecTarget(executable
    SOURCES
        main.cpp
    LIBRARIES
        interface_lib
        shared_lib
        shared_lib_2
        static_lib
        static_lib_2
    DEPENDS
        ext1
)

