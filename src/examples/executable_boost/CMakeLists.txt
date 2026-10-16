ExecTarget(executable_boost
    SOURCES
        main.cpp
    COMPILE_DEFINITIONS
        #BOOST_LOG_DYN_LINK
        BOOST_LOG_STATIC_LINK
    DEPENDS
        boost
        pthread
)
target_compile_options(executable_boost PRIVATE -Wno-maybe-uninitialized)
target_link_options(executable_boost PRIVATE -Wno-maybe-uninitialized)

ExampleTarget(example_boost
    SOURCES
        main.cpp
    COMPILE_DEFINITIONS
        #BOOST_LOG_DYN_LINK
        BOOST_LOG_STATIC_LINK
    DEPENDS
        boost
        pthread
)
