#include "interface_lib/interface_lib.h"
#include "static_lib_3/static_lib_3.h"

std::string static_lib_func_3()
{
    return interface_lib_func<std::string>();
}

