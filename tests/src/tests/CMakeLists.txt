TestTarget(ut_test_target
    SOURCES
        ut_test_target.cpp
    LIBRARIES
        interface_lib
        shared_lib
        static_lib
)

CustomTestTarget(ut_custom_test_target
    SOURCE
        ut_custom_test_target.sh
    INTERPRETER
        /bin/bash
#    VERBATIM
)

CustomTestTarget(ut_custom_test_target_with_args
    SOURCE
        ut_custom_test_target_with_args.sh
    INTERPRETER
        /bin/bash
    ARGUMENTS
        ${CMAKE_BINARY_DIR}
#    VERBATIM
)

