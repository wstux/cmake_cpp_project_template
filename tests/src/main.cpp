#include <iostream>
#include <string>

#include <ext_shared_lib/ext_shared_lib.h>

#include "interface_lib/interface_lib.h"
#include "shared_lib/shared_lib.h"
#include "shared_lib_2/shared_lib_2.h"
#include "static_lib/static_lib.h"
#include "static_lib_2/static_lib_2.h"


#define TEST_LIB(lib_fn, et)                    \
    if (lib_fn != et) {                         \
        std::cerr << "lib_fn('" << lib_fn       \
                  << "') != '" << et            \
                  << "'" << std::endl;          \
        rc = 1;                                 \
    }


int main(int /*argc*/, char** /*argv*/)
{
    int rc = 0;

    TEST_LIB(interface_lib_func<std::string>(), "interface_lib_func");
    TEST_LIB(shared_lib_func(), "shared_lib_func");
    TEST_LIB(static_lib_func(), "static_lib_func");

    TEST_LIB(ext_shared_lib_func(), "ext_shared_lib_func");

    TEST_LIB(shared_lib_func_2(), "shared_lib_func_2");
    TEST_LIB(static_lib_func_2(), "ext_shared_lib_func_2");

    return rc;
}

