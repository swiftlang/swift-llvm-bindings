cmake_minimum_required(VERSION 3.18)

project(SwiftLLVMBindings LANGUAGES C Swift)

if(CMAKE_SYSTEM_NAME STREQUAL Windows OR CMAKE_SYSTEM_NAME STREQUAL Darwin)
  option(BUILD_SHARED_LIBS "Build shared libraries by default" YES)
endif()

set(min_supported_swift_version 5.8)
if(CMAKE_Swift_COMPILER_VERSION VERSION_LESS "${min_supported_swift_version}")
  message(FATAL_ERROR "Outdated Swift compiler: "
      "Swift ${min_supported_swift_version} or newer is required.")
endif()

find_package(LLVM CONFIG REQUIRED)
message(STATUS "Found LLVM headers: ${LLVM_MAIN_INCLUDE_DIR}")
message(STATUS "Found LLVM generated headers: ${LLVM_INCLUDE_DIR}")

add_subdirectory(Sources)
