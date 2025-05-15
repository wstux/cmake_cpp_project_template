#include <boost/date_time/gregorian/gregorian.hpp>

#include "static_lib_boost/static_lib_boost.h"

std::string static_lib_boost()
{
    std::string s("2001-10-9"); //2001-October-09
    boost::gregorian::date d(boost::gregorian::from_simple_string(s));
    boost::gregorian::greg_weekday wd = d.day_of_week();
    return wd.as_long_string() + std::string(" ") + boost::gregorian::to_simple_string(d);
}

