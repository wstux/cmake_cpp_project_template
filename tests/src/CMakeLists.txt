ExecTarget(executable
    SOURCES
        main.cpp
    COMPILE_DEFINITIONS
#        CHECK_FIND_PACKAGE_BOOST
    LIBRARIES
        interface_lib
        shared_lib
        shared_lib_2
        static_lib
        static_lib_2
    DEPENDS
#        boost
        ext1
        ext2
)

