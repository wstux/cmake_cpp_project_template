#include "shared_lib/shared_lib.h"
#include "shared_lib_2/shared_lib_2.h"

std::string shared_lib_func_2()
{
    return shared_lib_func() + "_2";
}

