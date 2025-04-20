#ExternalTarget(ext1
#    BUILDSYS
#        cmake
#    SOURCE_DIR
#        ext1
#    INSTALL_DIR
#        ${CMAKE_BINARY_DIR}/externals/ext1/ext1-install
#    INCLUDE_DIR
#        ${CMAKE_SOURCE_DIR}/externals/ext1/libs
#    LIBRARIES
#        ${CMAKE_BINARY_DIR}/externals/ext1/ext1-install/libs/libext_shared_lib.so
#)

WrapperTarget(ext1
    BUILDSYS    cmake
    SOURCE_DIR
        ext1
    INCLUDE_DIR
        ${CMAKE_SOURCE_DIR}/externals/ext1/libs
    LIBRARIES
        ${CMAKE_BINARY_DIR}/externals/ext1/libs/ext_shared_lib/libext_shared_lib.so
)

WrapperTarget(ext2
    BUILDSYS
        cmake
    SOURCE_DIR
        ext2
    INCLUDE_DIR
        ${CMAKE_SOURCE_DIR}/externals/ext2/libs
)

