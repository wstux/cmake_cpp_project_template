#pragma once

#include <string>
#include <type_traits>

/**
 *  \brief  Function for testing interface library types.
 *  \return Return "interface_lib_func" string.
 */
template<typename TType>
TType interface_lib_func()
{
    static_assert(std::is_same<TType, std::string>::value, "Unsupported type");

    const TType var = "interface_lib_func";
    return var;
}

