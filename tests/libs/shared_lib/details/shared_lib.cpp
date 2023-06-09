#include "shared_lib/shared_lib.h"

std::string shared_lib_func()
{
#if defined(TEST_COMPILE_DEFINITIONS)
    return TEST_COMPILE_DEFINITIONS;
#else
    return "shared_lib_func";
#endif
}

