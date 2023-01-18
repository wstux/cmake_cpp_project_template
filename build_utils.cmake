################################################################################
# Functions
################################################################################

function(_is_kw CHECK_STR KW_LIST RESULT)
    set(${RESULT} 0 PARENT_SCOPE)
    list(FIND ${KW_LIST} "${CHECK_STR}" IS_FIND)
    if(NOT IS_FIND EQUAL -1)
        set(${RESULT} 1 PARENT_SCOPE)
    endif()
endfunction()

function(_parse_target_args TARGET_NAME KW_LIST)
    set(key "")
    set(to_parent_scope FALSE)
    foreach(arg IN LISTS ARGN)
        # Check is 'arg' a keyword.
        _is_kw(${arg} "${KW_LIST}" is_keyword)
        # Check is 'arg' a keyword and applies to flags keyword.
        _is_kw(${arg} _FLAG_KW is_flag)

        # If 'arg' is keyword - save 'arg' to 'key' variable and save key-flag to parent scope.
        if(is_keyword)
            if (to_parent_scope)
                set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}}" PARENT_SCOPE)
                set(to_parent_scope FALSE)
            endif()

            set(key "${arg}")

            if(is_flag)
                set(${TARGET_NAME}_${key} TRUE PARENT_SCOPE)
            endif()

            continue()
        endif()

        # If 'key' variable is defined - add data to key args and add to parent scope.
        if(key)
            if(NOT DEFINED ${TARGET_NAME}_${key})
                set(${TARGET_NAME}_${key} "${arg}")
                set(to_parent_scope TRUE)
            else()
                _is_kw(${key} _LIST_VALUES_KW is_valid)
                if(NOT is_valid)
                    message(ERROR " Invalid value for key '${key}'")
                endif()
                
                set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}};${arg}")
                set(to_parent_scope TRUE)
            endif()
        endif()
    endforeach()

    if (to_parent_scope)
        set(${TARGET_NAME}_${key} "${${TARGET_NAME}_${key}}" PARENT_SCOPE)
        set(to_parent_scope FALSE)
    endif()
endfunction()

