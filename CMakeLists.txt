# Preconditions and project definitions
cmake_minimum_required(VERSION 3.16)

project(atl0cc-x86_64
    VERSION 0.0.1
    DESCRIPTION "ATL0 Compiler for x86_64 ISA machines"
    LANGUAGES CXX
)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

# Add source files to atl0cc target
add_subdirectory(src)