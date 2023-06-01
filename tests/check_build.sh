#!/bin/bash

BUILD_TYPE=""
SUCCESS_BUILDS=()
FAILED_BUILDS=()

function check_build_target
{
    local _target="$1"
    echo "[ INFO ] Begin to build target '${_target}'"
    make ${_target}
    if [[ $? -eq 0 ]]; then
        SUCCESS_BUILDS+=("${_target}")
    else
        FAILED_BUILDS+=("${_target}")
    fi
    echo "[ INFO ] End to build target '${_target}'"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--release)
            BUILD_TYPE="release"
            shift # past argument
            ;;
        -d|--debug)
            BUILD_TYPE="debug"
            shift # past argument
            ;;
        -b|--build_type)
            BUILD_TYPE="$2"
            shift # past argument
            shift # past value
            ;;
        -h|--help)
            shift # past argument
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            echo "Unknown option $1"
            shift # past argument
            ;;
    esac
done

if [[ -z "${BUILD_TYPE}" ]]; then
    echo "Build type is not setted"
    exit 1
fi

if [[ "${BUILD_TYPE}" != "debug" && "${BUILD_TYPE}" != "release"  ]]; then
    echo "Invalid build type"
    exit 1
fi

TARGETS_LIST=(
    'all'
    'hello_module'
    'ext1' 'ext2'
#    'interface_lib'
    'shared_lib' 'shared_lib_2' 'static_lib' 'static_lib_2'
    'executable' 'ut_test_target'
    'all_ut_run')

check_build_target
for target in ${TARGETS_LIST[@]}; do
    check_build_target "${BUILD_TYPE}/${target}"
done

if [[ ${#SUCCESS_BUILDS[@]} -ne 0 ]]; then
    echo "[ INFO ] Success builds:"
    for target in ${SUCCESS_BUILDS[@]}; do
        echo "  - ${target}"
    done
fi
if [[ ${#FAILED_BUILDS[@]} -ne 0 ]]; then
    echo "[ INFO ] Failed builds:"
    for target in ${FAILED_BUILDS[@]}; do
        echo "  - ${target}"
    done
fi
