cmake_minimum_required(VERSION 3.16.3)

project(udp_toolkit_native LANGUAGES C)

add_library(udp_toolkit_native SHARED src/udp_toolkit_native.c)
set_target_properties(udp_toolkit_native PROPERTIES PREFIX "")

if($ENV{TARGET_OS} STREQUAL "win")


    set(CMAKE_SYSTEM_NAME Windows)
    set(TOOLCHAIN_PREFIX x86_64-w64-mingw32)
    set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc)

    set(CMAKE_FIND_ROOT_PATH /usr/${TOOLCHAIN_PREFIX})

    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

    target_link_libraries(udp_toolkit_native ws2_32)

    set_target_properties(udp_toolkit_native PROPERTIES SUFFIX ".dll")
endif()