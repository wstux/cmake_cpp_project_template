#ExternalTarget(grpc
#    URL
#        https://github.com/grpc/grpc/archive/refs/tags/v1.75.1.tar.gz
#    #URL_MD5
#    #    fe33be48eeb6de4dc2fefe60a3834c1f
#    CONFIGURE_COMMAND
#        cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF
#            -DgRPC_BUILD_GRPC_CPP_PLUGIN=ON
#            -DgRPC_BUILD_GRPC_CSHARP_PLUGIN=OFF
#            -DgRPC_BUILD_GRPC_NODE_PLUGIN=OFF
#            -DgRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN=OFF
#            -DgRPC_BUILD_GRPC_PHP_PLUGIN=OFF
#            -DgRPC_BUILD_GRPC_PYTHON_PLUGIN=OFF
#            -DgRPC_BUILD_GRPC_RUBY_PLUGIN=OFF
#            -DgRPC_ABSL_PROVIDER="package" -Dabsl_DIR="${_absl_DIR}"
#            -Dutf8_range_DIR="${_utf8_range_DIR}"
#            #-DgRPC_RE2_PROVIDER="package" -Dre2_DIR="${_re2_DIR}"
#            -DgRPC_PROTOBUF_PROVIDER="package" -DProtobuf_DIR="${_protobuf_DIR}"
#            -DgRPC_ZLIB_PROVIDER="package" -DZLIB_ROOT="${_zlib_DIR}"
#            #-DgRPC_CARES_PROVIDER="package"
#            -DgRPC_SSL_PROVIDER="package" -DOPENSSL_ROOT_DIR="${grpc_openssl_DIR}"
#            #-DCMAKE_PREFIX_PATH="${_cares_DIR}"
#            -DCMAKE_CXX_STANDARD=17
#            -DCMAKE_INSTALL_PREFIX=${_grpc_install_dir} ./
#    BUILD_COMMAND
#        make -j8 && make install
#    INCLUDE_DIR
#        ${EXTERNALS_PREFIX}/grpc/install/include
#    INSTALL_DIR
#        ${EXTERNALS_PREFIX}/grpc/install
#    DEPENDS
#        absl
#        openssl
#        protobuf
#        zlib
#    LIBRARIES
#        <grpc_libs>
#)

add_compile_options(-Wno-pedantic)
add_compile_options(-Wno-unused-parameter)
add_compile_options(-Wno-cast-function-type)
add_compile_options(-Wno-sign-compare)
add_compile_options(-Wno-ignored-qualifiers)
add_compile_options(-Wno-type-limits)
add_compile_options(-Wno-trigraphs)
add_compile_options(-Wno-return-type)
add_compile_options(-Wno-attributes)
add_compile_options(-Wno-missing-field-initializers)
set(CMAKE_CXX_FLAGS "-Wno-redundant-move")

FetchTarget(grpc
    GIT_REPOSITORY  https://github.com/grpc/grpc.git
    GIT_TAG         v1.76.0
    CMAKE_OPTIONS
        gRPC_BUILD_TESTS=OFF
        gRPC_BUILD_GRPC_CPP_PLUGIN=ON
        gRPC_BUILD_GRPC_CSHARP_PLUGIN=OFF
        gRPC_BUILD_GRPC_NODE_PLUGIN=OFF
        gRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN=OFF
        gRPC_BUILD_GRPC_PHP_PLUGIN=OFF
        gRPC_BUILD_GRPC_PYTHON_PLUGIN=OFF
        gRPC_BUILD_GRPC_RUBY_PLUGIN=OFF
        # abseil flags
        ABSL_BUILD_TESTING=OFF
        ABSL_BUILD_TEST_HELPERS=OFF
        ABSL_USE_EXTERNAL_GOOGLETEST=OFF
        ABSL_FIND_GOOGLETEST=OFF
        ABSL_USE_GOOGLETEST_HEAD=OFF
        # re2 flags
        RE2_TEST=OFF
        RE2_BENCHMARK=OFF
        RE2_BUILD_TESTING=OFF
        # zlib flags
        ZLIB_BUILD_EXAMPLES=OFF
    CMAKE_VARIABLES
        # abseil variables
        ABSL_ENABLE_INSTALL=ON
        # c-ares variables
        HAVE_SOCKLEN_T=1
        HAVE_SSIZE_T=1
        HAVE_LONGLONG=1
        HAVE_STRUCT_ADDRINFO=1
        HAVE_STRUCT_IN6_ADDR=1
        HAVE_STRUCT_SOCKADDR_IN6=1
        HAVE_STRUCT_SOCKADDR_STORAGE=1
        HAVE_STRUCT_TIMEVAL=1
#    COMPILE_OPTIONS
#        -Wno-pedantic
#        -Wno-unused-parameter
#        -Wno-cast-function-type
#        -Wno-sign-compare
#        -Wno-ignored-qualifiers
#        -Wno-type-limits
#        -Wno-trigraphs
#        -Wno-return-type
#        -Wno-attributes
#        -Wno-missing-field-initializers
#    CXX_COMPILE_FLAGS
#        -Wno-redundant-move
    LIBRARIES
#        absl::check
#        absl::flags
#        absl::flags_parse
#        absl::log
#        absl::log_initialize
#        grpc++_reflection
        grpc++
        libprotobuf
        c-ares::cares
        re2::re2
)

include(grpc_schema_target.cmake)
