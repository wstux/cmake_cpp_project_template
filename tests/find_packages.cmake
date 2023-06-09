find_package(Boost 1.74.0
             COMPONENTS program_options
#             REQUIRED
)
if(Boost_FOUND)
    add_custom_target(boost)
    set_target_properties(boost
                          PROPERTIES
                              LIBRARIES "${Boost_LIBRARIES}"
    )
    set_target_properties(boost
                          PROPERTIES
                              INCLUDE_DIRECTORIES "${Boost_INCLUDE_DIRS}"
    )
else()
    message(INFO " boost not found")
endif()

