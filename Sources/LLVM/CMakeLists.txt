add_library(LLVM_Utils
    LLVM_Utils.swift)
target_compile_options(LLVM_Utils PUBLIC
    "-emit-module"
    "SHELL:-Xcc -std=c++17"
    "SHELL:-Xcc -fapinotes"
    "SHELL:-Xcc -fapinotes-modules"
    "SHELL:-Xcc -iapinotes-modules -Xcc ${CMAKE_CURRENT_SOURCE_DIR}"
    "-cxx-interoperability-mode=default")
target_include_directories(LLVM_Utils PUBLIC
    "${LLVM_MAIN_INCLUDE_DIR}"
    "${LLVM_INCLUDE_DIR}")
install(TARGETS LLVM_Utils
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib)
install(FILES LLVM_Utils.apinotes
    DESTINATION include/apinotes)
