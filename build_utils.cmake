################################################################################
# Functions
################################################################################

function(_add_lib_depends TARGET_NAME)
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
endfunction()

function(_is_kw CHECK_STR KW_LIST RESULT)
    set(${RESULT} 0 PARENT_SCOPE)
    list(FIND ${KW_LIST} "${CHECK_STR}" IS_FIND)
    if (NOT IS_FIND EQUAL -1)
        set(${RESULT} 1 PARENT_SCOPE)
    endif()
endfunction()

function(_parse_target_args TARGET_NAME KW_LIST)
    set(key "")
    set(to_parent_scope FALSE)
    foreach(arg IN LISTS ARGN)
        # Check is 'arg' a keyword.
        _is_kw(${arg} "${KW_LIST}" is_keyword)

        # If 'arg' is keyword - save 'arg' to 'key' variable and save key-flag to parent scope.
        if (is_keyword)
            if (to_parent_scope)
                if (NOT DEFINED ${TARGET_NAME}_${key})
                    set(${TARGET_NAME}_${key} TRUE)
                endif()
                set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}}" PARENT_SCOPE)
                set(to_parent_scope FALSE)
            endif()

            set(key "${arg}")
            set(to_parent_scope TRUE)
            continue()
        endif()

        # If 'key' variable is defined - add data to key args and add to parent scope.
        if (key)
            if (NOT DEFINED ${TARGET_NAME}_${key})
                set(${TARGET_NAME}_${key} "${arg}")
            else()
                set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}};${arg}")
            endif()
        endif()
    endforeach()

    if (to_parent_scope)
        if (NOT DEFINED ${TARGET_NAME}_${key})
            set(${TARGET_NAME}_${key} TRUE)
        endif()
        set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}}" PARENT_SCOPE)
        set(to_parent_scope FALSE)
    endif()
endfunction()

macro(_validate_args TARGET_NAME KW_LIST FLAG_KW_LIST VALUES_KW_LIST)
    foreach(key IN LISTS ${KW_LIST})
        if (NOT DEFINED ${TARGET_NAME}_${key})
            continue()
        endif()

        _is_kw(${key} "${FLAG_KW_LIST}" is_flag)
        if (is_flag)
            if ("${${TARGET_NAME}_${key}}" MATCHES "TRUE")
                continue()
            elseif ("${${TARGET_NAME}_${key}}" MATCHES "FALSE")
                continue()
            else()
                message(FATAL_ERROR " Invalid flag value for key '${key}'")
            endif()

            continue()
        endif()

        _is_kw(${key} "${VALUES_KW_LIST}" is_value)
        if (is_value)
            if ("${${TARGET_NAME}_${key}}" MATCHES "TRUE")
                message(FATAL_ERROR " Invalid value for key '${key}'")
            elseif ("${${TARGET_NAME}_${key}}" MATCHES "FALSE")
                message(FATAL_ERROR " Invalid value for key '${key}'")
            endif()

            continue()
        endif()

        message(ERROR " Unsupported key '${key}'")
    endforeach()
endmacro()

