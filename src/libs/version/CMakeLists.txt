ConfigureFile(version_file version.h
    CMAKE_TEST_PROJECT_VERSION=101
)

LibTarget(version_lib INTERFACE
    HEADERS     version.h
    INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS     version_file
)

