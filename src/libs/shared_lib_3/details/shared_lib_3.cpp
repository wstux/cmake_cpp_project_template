#include "interface_lib/interface_lib.h"
#include "shared_lib_3/shared_lib_3.h"

std::string shared_lib_func_3()
{
    return interface_lib_func<std::string>();
}

