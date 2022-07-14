# Swift Bindings for LLVM

This project aims at making it easier and more convenient to
use [LLVM](https://github.com/llvm/llvm-project) APIs from Swift code.
It relies on the experimental Swift/C++ Interoperability, which allows calling
C++ APIs directly from Swift, removing the need for a C bridging layer.

This is a work-in-progress. The design of the bindings will be changing as
Swift/C++ Interoperability evolves.

## Trying it out

### Within the Swift compiler project

(This will be updated once the Swift compiler starts using Swift LLVM Bindings.)

### As a standalone project

A [Swift Development Snapshot](https://www.swift.org/download/#snapshots)
toolchain is required to build the project. Using the latest available trunk
snapshot is recommended.

Since the bindings rely on LLVM headers, you will need a fresh checkout of LLVM
locally. Both upstream LLVM
([llvm/llvm-project](https://github.com/llvm/llvm-project)) and Apple's
LLVM fork ([apple/llvm-project](https://github.com/apple/llvm-project)) are
supported.

Similarly to LLVM, CMake is used to build the bindings. To configure the build
process, run the following command:

```
cmake -G Ninja \
      -D CMAKE_BUILD_TYPE=Debug \
      -D CMAKE_Swift_COMPILER=/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-{YYYY-MM-DD}.xctoolchain/usr/bin/swiftc \
      -D LLVM_DIR={PATH_TO_LLVM_BUILD_ROOT}/lib/cmake/llvm \
      -B {PATH_TO_BUILD_ROOT}
```

To build all of the bindings, run:

```
cmake --build {PATH_TO_BUILD_ROOT} --target all
```

To build the bindings for a specific LLVM module (e.g. `LLVM_Utils`), run:

```
cmake --build {PATH_TO_BUILD_ROOT} --target LLVM_Utils
```
