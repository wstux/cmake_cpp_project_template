add_subdirectory(drivers/hello_module)

add_subdirectory(libs/interface_lib)
add_subdirectory(libs/shared_lib)
add_subdirectory(libs/shared_lib_2)
add_subdirectory(libs/shared_lib_3)
add_subdirectory(libs/static_lib)
add_subdirectory(libs/static_lib_2)
add_subdirectory(libs/static_lib_3)
add_subdirectory(libs/static_lib_boost)

add_subdirectory(executable)
add_subdirectory(executable_boost)

if (BUILD_TESTS)
    add_subdirectory(tests)
endif()

