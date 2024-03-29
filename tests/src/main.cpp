#include <iostream>
#include <string>

#if defined(CHECK_FIND_PACKAGE_BOOST)
    #include <boost/program_options.hpp>
#endif

#include <ext_shared_lib/ext_shared_lib.h>
#include <ext_shared_lib_2.h>

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


int main(int argc, char** argv)
{
#if defined(CHECK_FIND_PACKAGE_BOOST)
    namespace po = boost::program_options;

    po::options_description desc("Allowed options");
    desc.add_options()
        ("help,h", "print usage message");
    // Parse command line arguments
    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv).options(desc).run(), vm);
    po::notify(vm);
    if (vm.count("help")) {
        std::cout << desc << std::endl;
        return 0;
    }
#else
    (void)argc;
    (void)argv;
#endif

    int rc = 0;

    TEST_LIB(interface_lib_func<std::string>(), "interface_lib_func");
    TEST_LIB(shared_lib_func(), "shared_lib");
    TEST_LIB(static_lib_func(), "static_lib_func");

    TEST_LIB(ext_shared_lib_func(), "ext_shared_lib_func");
    TEST_LIB(ext_interface_lib_func(), "ext_interface_lib_func");

    TEST_LIB(shared_lib_func_2(), "shared_lib_2");
    TEST_LIB(static_lib_func_2(), "ext_shared_lib_func_2");

    return rc;
}

