add_library(LLVM_Utils
    LLVM_Utils.swift)
target_compile_options(LLVM_Utils PUBLIC
    "-emit-module"
    "SHELL:-Xcc -std=c++17"
    "-cxx-interoperability-mode=default")
target_include_directories(LLVM_Utils PUBLIC
    "${LLVM_MAIN_INCLUDE_DIR}"
    "${LLVM_INCLUDE_DIR}")
install(TARGETS LLVM_Utils
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib)
