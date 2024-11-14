# The MIT License
#
# Copyright (c) 2022 wstux
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include(build_utils)

################################################################################
# Targets
################################################################################

macro(CustomTarget TARGET_NAME)
    add_custom_target(${TARGET_NAME} ${ARGN})
endmacro()

macro(LibTarget TARGET_NAME)
    set(_flags_kw   MODULE SHARED STATIC INTERFACE)
    set(_values_kw  COMMENT INCLUDE_DIR)
    set(_lists_kw   HEADERS SOURCES LIBRARIES DEPENDS COMPILE_DEFINITIONS)
    _parse_target_args(${TARGET_NAME}
        _flags_kw _values_kw _lists_kw ${ARGN}
    )

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
        add_library(${TARGET_NAME} ${LIB_TYPE} ${${TARGET_NAME}_HEADERS}
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

    set_property(TARGET ${TARGET_NAME} PROPERTY ${TARGET_NAME}_INCLUDE_DIR
                 ${PROJECT_SOURCE_DIR}/${${TARGET_NAME}_INCLUDE_DIR}
    )

    _configure_target(${TARGET_NAME})

    if (${TARGET_NAME}_SHARED)
        set_target_properties(${TARGET_NAME}
            PROPERTIES
                LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        )
    elseif (${TARGET_NAME}_STATIC)
        set_target_properties(${TARGET_NAME}
            PROPERTIES
                ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/arch"
        )
    endif()
endmacro()

macro(ExecTarget TARGET_NAME)
    set(_flags_kw   )
    set(_values_kw  COMMENT INCLUDE_DIR)
    set(_lists_kw   HEADERS SOURCES LIBRARIES DEPENDS COMPILE_DEFINITIONS)
    _parse_target_args(${TARGET_NAME}
        _flags_kw _values_kw _lists_kw ${ARGN}
    )

#    message(INFO " Configure EXEC target '${TARGET_NAME}'")
    add_executable(${TARGET_NAME} ${${TARGET_NAME}_HEADERS}
                                  ${${TARGET_NAME}_SOURCES}
    )

    _configure_target(${TARGET_NAME})

    set_target_properties(${TARGET_NAME}
        PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
endmacro()

macro(TestTarget TARGET_NAME)
    set(_flags_kw   DISABLE)
    set(_values_kw  COMMENT INCLUDE_DIR)
    set(_lists_kw   HEADERS SOURCES LIBRARIES DEPENDS COMPILE_DEFINITIONS)
    _parse_target_args(${TARGET_NAME}
        _flags_kw _values_kw _lists_kw ${ARGN}
    )

    set(_target_dir "${CMAKE_BINARY_DIR}/test")
    set(_enable_autorun true)
    if (${TARGET_NAME}_DISABLE)
        set(_enable_autorun false)
    endif()

#    message(INFO " Configure TEST target '${TARGET_NAME}'")
    add_executable(${TARGET_NAME} ${${TARGET_NAME}_HEADERS}
                                  ${${TARGET_NAME}_SOURCES}
    )
    _configure_target(${TARGET_NAME})

    if (${_enable_autorun})
        add_test(
            NAME ${TARGET_NAME}
            COMMAND $<TARGET_FILE:${TARGET_NAME}>
        )
    endif()

    CustomTarget(${TARGET_NAME}_run
        COMMAND "${_target_dir}/${TARGET_NAME}"
        DEPENDS ${TARGET_NAME}
        VERBATIM
    )

    set_target_properties(${TARGET_NAME}
        PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${_target_dir}"
    )
endmacro()

