#include <iostream>
#include <string>

#include "interface_lib/interface_lib.h"
#include "shared_lib/shared_lib.h"
#include "static_lib/static_lib.h"

#define CHECK(td, et)                                                       \
    if (td != et) {                                                         \
        std::cerr << "[FAIL] Function call result ('" << td << "') "        \
                  << "not equal etalon data ('" << et << "')" << std::endl; \
    } else                                                                  \
        std::cout << "[ OK ] Function call '" << td << "'" << std::endl

int main(int /*argc*/, char** /*argv*/)
{
    CHECK(interface_lib_func<std::string>(), "interface_lib_func");
    CHECK(shared_lib_func(), "shared_lib");
    CHECK(static_lib_func(), "static_lib_func");
    
    return 0;
}

