# Create atl0cc target
add_executable(atl0cc
    main.cc
    util.cc
)

# Track include files for atl0cc target
target_include_directories(atl0cc
    PRIVATE
        # Don't like this, but ${CMAKE_SOURCE_DIR} will break when run in script mode
        ../include
        ${CMAKE_CURRENT_BINARY_DIR}
)

# Track flex library to link for atl0cc target,
# ignore some Flex/Bison warnings,
# set executable output location
target_link_libraries(atl0cc -ll)
target_compile_options(atl0cc PRIVATE -Wno-write-strings)
set_target_properties(atl0cc PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Generate custom build rule to generate parser and scanner
add_subdirectory(parse)

BISON_TARGET(atl0Parser
    parse/ATL0.y
    ${CMAKE_CURRENT_BINARY_DIR}/parse/parse.cc
    COMPILE_FLAGS -y
    DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parse/y.tab.h
)
FLEX_TARGET(atl0Scanner
    parse/scan.l
    ${CMAKE_CURRENT_BINARY_DIR}/parse/scan.cc
)
ADD_FLEX_BISON_DEPENDENCY(atl0Scanner atl0Parser)

# Add parser and scanner files to atl0cc target
target_sources(atl0cc
    PRIVATE
        ${FLEX_atl0Scanner_OUTPUTS}
        ${BISON_atl0Parser_OUTPUTS}
)

# Setup and link LLVM libraries to target
llvm_map_components_to_libnames(llvm_libs support core irreader)
target_link_libraries(atl0cc ${llvm_libs})