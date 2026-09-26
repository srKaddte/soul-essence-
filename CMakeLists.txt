cmake_minimum_required(VERSION 3.16)
project(soul_essence_nextos C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

if(NOT CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|ARM64")
  message(FATAL_ERROR "Soul Essence NextOS native target must be AArch64")
endif()

find_package(PkgConfig REQUIRED)
pkg_check_modules(SDL2 REQUIRED sdl2)

add_executable(soul-essence-nextos
  src/main.c
)

target_include_directories(soul-essence-nextos PRIVATE
  ${SDL2_INCLUDE_DIRS}
)

target_compile_options(soul-essence-nextos PRIVATE
  -Wall -Wextra -Wpedantic
)

target_link_libraries(soul-essence-nextos PRIVATE
  ${SDL2_LIBRARIES}
  dl
  m
  pthread
)
