function(AddPlatform PLATFORM)
    get_property(_supported_platform_list GLOBAL PROPERTY supported_platform_list)

    list(APPEND _supported_platform_list "${PLATFORM}")
    set_property(GLOBAL PROPERTY supported_platform_list "${_supported_platform_list}")
endfunction()

function(_is_supported_platform PLATFORM RESULT)
    set(${RESULT} 0 PARENT_SCOPE)
    get_property(_supported_platform_list GLOBAL PROPERTY supported_platform_list)

    if (NOT DEFINED _supported_platform_list)
        return()
    endif()
    
    list(FIND _supported_platform_list "${PLATFORM}" IS_FIND)
    if (NOT IS_FIND EQUAL -1)
        set(${RESULT} 1 PARENT_SCOPE)
    endif()
endfunction()

