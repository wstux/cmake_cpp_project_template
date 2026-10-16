if (BUILD_BOOST)
    set(CMAKE_CXX_FLAGS "-Wno-uninitialized;-Wno-deprecated-copy")

    ExternalTarget(boost
        URL     https://github.com/boostorg/boost/releases/download/boost-1.88.0/boost-1.88.0-cmake.tar.gz
        URL_MD5 "fe33be48eeb6de4dc2fefe60a3834c1f"
        CONFIGURE_COMMAND
            ./bootstrap.sh --prefix=${EXTERNALS_PREFIX}/boost/install
                           --with-toolset=gcc
                           --with-libraries=date_time,filesystem,log,program_options,system,thread
        BUILD_COMMAND
            CXXFLAGS='${CMAKE_CXX_FLAGS};-Wno-uninitialized'
            ./b2 linkflags=\"${CMAKE_EXE_LINKER_FLAGS}\" cflags=\"${CMAKE_C_FLAGS}\" cxxflags=\"${CMAKE_CXX_FLAGS}\"
                 architecture=x86
                 address-model=64
                 link=static
                 --debug-configuration -q
                 --prefix=${EXTERNALS_PREFIX}/boost/install
                 --layout=tagged -j8 threading=multi
                 runtime-link=static
                 define=BOOST_LOG_USE_NATIVE_SYSLOG
                 variant=release install
        INCLUDE_DIR
            ${EXTERNALS_PREFIX}/boost/install/include
        INSTALL_DIR
            ${EXTERNALS_PREFIX}/boost/install
        LIBRARIES
            libboost_atomic-mt-s-x64.a
            libboost_date_time-mt-s-x64.a
            libboost_filesystem-mt-s-x64.a
            libboost_log-mt-s-x64.a
            libboost_log_setup-mt-s-x64.a
            libboost_program_options-mt-s-x64.a
            libboost_system-mt-s-x64.a
            libboost_thread-mt-s-x64.a
    )
endif()
