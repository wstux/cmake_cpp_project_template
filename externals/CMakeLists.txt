ExternalTarget(boost
    URL
        https://github.com/boostorg/boost/releases/download/boost-1.88.0/boost-1.88.0-cmake.tar.gz
    #URL_MD5
    #    fe33be48eeb6de4dc2fefe60a3834c1f
    CONFIGURE_COMMAND
        ./bootstrap.sh --prefix=${EXTERNALS_PREFIX}/boost/install --with-toolset=gcc --with-libraries=date_time,filesystem,log,program_options,system,thread
    INSTALL_COMMAND
        ./b2 linkflags=\"${CMAKE_EXE_LINKER_FLAGS}\" cflags=\"${CMAKE_C_FLAGS}\" cxxflags=\"${CMAKE_CXX_FLAGS}\" architecture=x86 address-model=64 link=shared,static --debug-configuration -q --prefix=${EXTERNALS_PREFIX}/boost/install --layout=tagged -j8 threading=multi runtime-link=shared define=BOOST_LOG_USE_NATIVE_SYSLOG variant=release install
    INCLUDE_DIR
        ${EXTERNALS_PREFIX}/boost/install/include
    INSTALL_DIR
        ${EXTERNALS_PREFIX}/boost/install
    LIBRARIES
        libboost_atomic-mt-x64.so
        libboost_date_time-mt-x64.so
        libboost_filesystem-mt-x64.a
        libboost_filesystem-mt-x64.so
        libboost_log-mt-x64.so
        libboost_log_setup-mt-x64.so
        libboost_program_options-mt-x64.so
        libboost_system-mt-x64.so
        libboost_thread-mt-x64.so
)

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

ExternalTarget(testing
    URL
        https://github.com/wstux/testing_template/archive/refs/heads/master.zip
    #URL_MD5
    #    fe33be48eeb6de4dc2fefe60a3834c1f
    CONFIGURE_COMMAND
        cmake --install-prefix ${EXTERNALS_PREFIX}/testing/install  ./
    BUILD_COMMAND
        cmake --build ./
    INSTALL_COMMAND
        cmake --install ./
    INCLUDE_DIR
        ${EXTERNALS_PREFIX}/testing/install/include
    INSTALL_DIR
        ${EXTERNALS_PREFIX}/testing/install
)

