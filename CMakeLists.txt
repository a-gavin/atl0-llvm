# Preconditions and project definitions
cmake_minimum_required(VERSION 3.16)

project(atl0cc-x86_64
    VERSION 0.0.1
    DESCRIPTION "ATL0 Compiler for x86_64 ISA machines"
    LANGUAGES CXX
)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Setup LLVM definitions
include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

# Add source files to atl0cc target
add_subdirectory(src)
