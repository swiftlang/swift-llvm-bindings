add_library(LLVM_Utils
    LLVM_Utils.swift)
target_compile_options(LLVM_Utils PUBLIC
    "-emit-module"
    "-Xfrontend" "-enable-experimental-cxx-interop")
target_include_directories(LLVM_Utils PUBLIC
    "${LLVM_MAIN_INCLUDE_DIR}"
    "${LLVM_INCLUDE_DIR}")
