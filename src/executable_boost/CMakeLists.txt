ExecTarget(executable_boost
    SOURCES
        main.cpp
    COMPILE_DEFINITIONS
        BOOST_LOG_DYN_LINK
    DEPENDS
        boost
        pthread
)

