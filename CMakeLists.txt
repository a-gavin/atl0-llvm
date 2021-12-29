# Preconditions and project definitions
cmake_minimum_required(VERSION 3.16)

project(atl0cc-x86_64
    VERSION 0.0.1
    DESCRIPTION "ATL0 Compiler for x86_64 ISA machines"
    LANGUAGES CXX
)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)


# Generate custom build rule to generate parser and scanner
BISON_TARGET(atl0Parser
    ATL0.y
    ${CMAKE_CURRENT_BINARY_DIR}/parse.cc
    COMPILE_FLAGS -y
    DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/y.tab.h
)
FLEX_TARGET(atl0Scanner
    scan.l
    ${CMAKE_CURRENT_BINARY_DIR}/scan.cc
)
ADD_FLEX_BISON_DEPENDENCY(atl0Scanner atl0Parser)

# Create atl0cc target and add source files
add_executable(atl0cc
    main.cc
    util.cc
    ${FLEX_atl0Scanner_OUTPUTS}
    ${BISON_atl0Parser_OUTPUTS}
)

# Track include files for atl0cc target
target_include_directories(atl0cc
    PRIVATE
        include
        ${CMAKE_CURRENT_BINARY_DIR}
)

# Track flex library to link for atl0cc target
target_link_libraries(atl0cc -ll)
target_compile_options(atl0cc PRIVATE -Wno-write-strings)
