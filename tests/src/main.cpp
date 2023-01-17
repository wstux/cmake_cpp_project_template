#include <string>

#include "interface_lib/interface_lib.h"
#include "shared_lib/shared_lib.h"
#include "static_lib/static_lib.h"

int main(int /*argc*/, char** /*argv*/)
{
    const std::string if_lib = interface_lib_func<std::string>();
    if (if_lib != "interface_lib_func") {
        return 1;
    }
    const std::string sh_lib = shared_lib_func();
    if (sh_lib != "shared_lib_func") {
        return 1;
    }
    const std::string st_lib = static_lib_func();
    if (st_lib != "static_lib_func") {
        return 1;
    }
    
    return 0;
}

