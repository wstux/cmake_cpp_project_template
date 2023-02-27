include(ExternalProject)

include(build_utils)

################################################################################
# Keywords
################################################################################

set(_EXT_TARGET_KW  BUILD_ARGS
                    BUILD_CMD
                    BUILDSYS
                    DEPENDS
                    FIND_PACKAGE
                    INCLUDE_DIR
                    INSTALL_DIR
                    LIBRARIES
                    LIBRARY_DIR
                    SEARCH_DIR
                    SOURCE_DIR
)

################################################################################
# Targets
################################################################################

function(ExternalTarget EXT_TARGET_NAME)
    _parse_target_args(${EXT_TARGET_NAME} _EXT_TARGET_KW ${ARGN})

    if (DEFINED ${EXT_TARGET_NAME}_FIND_PACKAGE)
    
    else()
        if (DEFINED ${EXT_TARGET_NAME}_BUILDSYS)
            if (${EXT_TARGET_NAME}_BUILDSYS STREQUAL cmake)
                if (DEFINED ${EXT_TARGET_NAME}_BUILD_ARGS)
                    list(APPEND cmake_args ${${EXT_TARGET_NAME}_BUILD_ARGS})
                endif()
                
                if (DEFINED ${EXT_TARGET_NAME}_INSTALL_DIR)
                    list(APPEND cmake_args -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)
                endif()
            endif()
        else()
            message(FATAL_ERROR " BUILDSYS_NOT_DEFINED branch not supported now")
        endif()

        if (DEFINED ${EXT_TARGET_NAME}_SOURCE_DIR)
            set(source_dir "${CMAKE_CURRENT_SOURCE_DIR}/${${EXT_TARGET_NAME}_SOURCE_DIR}")
        else()
            message(FATAL_ERROR " SOURCE_DIR_NOT_DEFINED branch not supported now")
        endif()
        if (DEFINED ${EXT_TARGET_NAME}_INCLUDE_DIR)
            set(include_dir "${${EXT_TARGET_NAME}_INCLUDE_DIR}")
        else()
            message(FATAL_ERROR " INCLUDE_DIR_NOT_DEFINED branch not supported now")
        endif()
        if (DEFINED ${EXT_TARGET_NAME}_LIBRARIES)
            foreach(lib IN LISTS ${EXT_TARGET_NAME}_LIBRARIES)
                list(APPEND libraries ${lib})
            endforeach()
#            set(libraries "${${EXT_TARGET_NAME}_LIBRARIES}")
        else()
            message(FATAL_ERROR " LIBRARIES_NOT_DEFINED branch not supported now")
        endif()

        ExternalProject_Add(
            ${EXT_TARGET_NAME}
            PREFIX ${CMAKE_BINARY_DIR}/externals/${EXT_TARGET_NAME}
            STAMP_DIR ${CMAKE_BINARY_DIR}/externals/${EXT_TARGET_NAME}/${EXT_TARGET_NAME}-stamp
            TMP_DIR ${CMAKE_BINARY_DIR}/externals/${EXT_TARGET_NAME}/${EXT_TARGET_NAME}-tmp
            SOURCE_DIR ${source_dir}
            DEPENDS ${${EXT_TARGET_NAME}_DEPENDS}
            CMAKE_ARGS ${cmake_args}
            CMAKE_CACHE_ARGS ${cmake_args}
            INSTALL_DIR ${${EXT_TARGET_NAME}_INSTALL_DIR}
            BUILD_COMMAND "${${EXT_TARGET_NAME}_BUILD_CMD}"
        )

        set_target_properties(${EXT_TARGET_NAME}
                              PROPERTIES
                                  INCLUDE_DIRECTORIES "${include_dir}"
        )
        set_target_properties(${EXT_TARGET_NAME}
                              PROPERTIES
                                  LIBRARIES "${libraries}")
    endif()
endfunction()

