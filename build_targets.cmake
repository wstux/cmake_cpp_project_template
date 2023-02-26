include(build_utils)

################################################################################
# Keywords
################################################################################

set(_COMMON_TARGET_KW   HEADERS     # headers list
                        SOURCES     # sources list
                        COMMENT     # message before build target
                        LIBRARIES
                        DEPENDS
)

set(_CUSTOM_TARGET_KW   COMMAND
                        DEPENDS
)

set(_EXEC_TARGET_KW     ${_COMMON_TARGET_KW}
)

set(_LIB_TARGET_KW      ${_COMMON_TARGET_KW}
                        MODULE      # Dinamic module library type
                        SHARED      # Dinamic library type
                        STATIC      # Static library type
                        INTERFACE
                        INCLUDE_DIR
)

set(_LIST_VALUES_KW     HEADERS
                        SOURCES
                        LIBRARIES
                        COMMAND
                        DEPENDS
                        INCLUDE_DIR
)

set(_FLAG_KW            MODULE
                        SHARED
                        STATIC
                        INTERFACE
)

################################################################################
# Targets
################################################################################

macro(CustomTarget TARGET_NAME)
    _parse_target_args(${TARGET_NAME} _CUSTOM_TARGET_KW ${ARGN})

    foreach(key IN LISTS _CUSTOM_TARGET_KW)
        foreach(dep IN LISTS ${TARGET_NAME}_${key})
            list(APPEND ${TARGET_NAME}_BUILD_ARGS ${key} ${dep})
        endforeach()
    endforeach()

    add_custom_target(${TARGET_NAME} ${${TARGET_NAME}_BUILD_ARGS})
endmacro()

macro(LibTarget TARGET_NAME)
    _parse_target_args(${TARGET_NAME} _LIB_TARGET_KW ${ARGN})
    _validate_args(${TARGET_NAME} _LIB_TARGET_KW _FLAG_KW _LIST_VALUES_KW)

    if(${TARGET_NAME}_INTERFACE)
#        message(INFO " Configure INTERFACE LIB target '${TARGET_NAME}'")
        add_library(${TARGET_NAME} INTERFACE)
        target_include_directories(
            ${TARGET_NAME} INTERFACE
                "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/${${TARGET_NAME}_INCLUDE_DIR}>"
                "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
        )
    elseif(${TARGET_NAME}_SHARED OR ${TARGET_NAME}_STATIC)
        set(LIB_TYPE SHARED)
        if (${TARGET_NAME}_STATIC)
            set(LIB_TYPE STATIC)
        endif()

#        message(INFO " Configure ${LIB_TYPE} LIB target '${TARGET_NAME}'")
        add_library(${TARGET_NAME} ${LIB_TYPE}
                                   ${${TARGET_NAME}_HEADERS}
                                   ${${TARGET_NAME}_SOURCES}
        )

        target_include_directories(${TARGET_NAME} PRIVATE ${${TARGET_NAME}_INCLUDE_DIR})

        set_target_properties(${TARGET_NAME}
                              PROPERTIES
                                  INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/${${TARGET_NAME}_INCLUDE_DIR}
        )
    else()
        message(ERROR "[ERROR] Unsupported library type")
    endif()

    foreach(deps IN LISTS ${TARGET_NAME}_DEPENDS)
        add_dependencies(${TARGET_NAME} ${deps})

        get_target_property(DEP_LIBRARIES ${deps} LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${DEP_LIBRARIES})

        get_target_property(DEP_INCLUDE_DIR ${deps} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${DEP_INCLUDE_DIR})
    endforeach()
    foreach(lib IN LISTS ${TARGET_NAME}_LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${lib})

        get_target_property(target_type ${lib} TYPE)
        if(target_type STREQUAL "INTERFACE_LIBRARY")
            continue()
        endif()

        get_target_property(LIB_INCLUDE_DIR ${lib} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${LIB_INCLUDE_DIR})
    endforeach()

    install(TARGETS ${TARGET_NAME} LIBRARY DESTINATION libs)
endmacro()

macro(ExecTarget TARGET_NAME)
    _parse_target_args(${TARGET_NAME} _EXEC_TARGET_KW ${ARGN})
    _validate_args(${TARGET_NAME} _EXEC_TARGET_KW _FLAG_KW _LIST_VALUES_KW)

#    message(INFO " Configure EXEC target '${TARGET_NAME}'")
    add_executable(${TARGET_NAME} ${${TARGET_NAME}_HEADERS}
                                  ${${TARGET_NAME}_SOURCES}
    )

    foreach(deps IN LISTS ${TARGET_NAME}_DEPENDS)
        add_dependencies(${TARGET_NAME} ${deps})

        get_target_property(DEP_LIBRARIES ${deps} LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${DEP_LIBRARIES})

        get_target_property(DEP_INCLUDE_DIR ${deps} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${DEP_INCLUDE_DIR})
    endforeach()
    foreach(lib IN LISTS ${TARGET_NAME}_LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${lib})

        get_target_property(target_type ${lib} TYPE)
        if(target_type STREQUAL "INTERFACE_LIBRARY")
            continue()
        endif()

        get_target_property(LIB_INCLUDE_DIR ${lib} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${LIB_INCLUDE_DIR})
    endforeach()

    install(TARGETS ${TARGET_NAME} RUNTIME DESTINATION bin)
endmacro()

macro(TestTarget TARGET_NAME)
    _parse_target_args(${TARGET_NAME} _EXEC_TARGET_KW ${ARGN})
    _validate_args(${TARGET_NAME} _EXEC_TARGET_KW _FLAG_KW _LIST_VALUES_KW)

#    message(INFO " Configure TEST target '${TARGET_NAME}'")
    add_executable(${TARGET_NAME} ${${TARGET_NAME}_HEADERS}
                                  ${${TARGET_NAME}_SOURCES}
    )
    add_test(${TARGET_NAME} ${TARGET_NAME})

    foreach(deps IN LISTS ${TARGET_NAME}_DEPENDS)
        add_dependencies(${TARGET_NAME} ${deps})

        get_target_property(DEP_LIBRARIES ${deps} LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${DEP_LIBRARIES})

        get_target_property(DEP_INCLUDE_DIR ${deps} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${DEP_INCLUDE_DIR})
    endforeach()
    foreach(lib IN LISTS ${TARGET_NAME}_LIBRARIES)
        target_link_libraries(${TARGET_NAME} ${lib})

        get_target_property(target_type ${lib} TYPE)
        if(target_type STREQUAL "INTERFACE_LIBRARY")
            continue()
        endif()

        get_target_property(LIB_INCLUDE_DIR ${lib} INCLUDE_DIRECTORIES)
        target_include_directories(${TARGET_NAME} PRIVATE ${LIB_INCLUDE_DIR})
    endforeach()
    enable_testing()

    install(TARGETS ${TARGET_NAME} RUNTIME DESTINATION tests)
endmacro()

