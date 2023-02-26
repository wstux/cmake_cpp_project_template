#include <ext_shared_lib/ext_shared_lib.h>

#include "static_lib_2/static_lib_2.h"

std::string static_lib_func_2()
{
    return ext_shared_lib_func() + "_2";
}

