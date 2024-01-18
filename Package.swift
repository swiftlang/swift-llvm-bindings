// swift-tools-version:5.9
// WARNING: Swift Package Manager support is experimental, please consider using CMake to build this project.

import PackageDescription
import class Foundation.ProcessInfo

let env = ProcessInfo.processInfo.environment

func getLLVMSwiftSettings() -> [SwiftSetting]? {
    let env = ProcessInfo.processInfo.environment
    guard let llvmHeaderPath = env["SWIFT_LLVM_BINDINGS_PATH_TO_LLVM_HEADERS"] else {
        print("please pass an environment variable to swift-package: " +
              "SWIFT_LLVM_BINDINGS_PATH_TO_LLVM_HEADERS " +
              "(e.g. swift/llvm-project/llvm/include)")
        return nil
    }
    let llvmModuleMapPath = "\(llvmHeaderPath)/module.modulemap"
    guard let llvmGeneratedHeaderPath = env["SWIFT_LLVM_BINDINGS_PATH_TO_LLVM_GENERATED_HEADERS"] else {
        print("please pass an environment variable to swift-package: " +
              "SWIFT_LLVM_BINDINGS_PATH_TO_LLVM_GENERATED_HEADERS " +
              "(e.g. swift/build/Ninja-DebugAssert/llvm-macosx-arm64/include)")
        return nil
    }

    return [
        .interoperabilityMode(.Cxx),
        .unsafeFlags([
             "-I\(llvmHeaderPath)",
             "-Xcc", "-I\(llvmHeaderPath)",
             "-I\(llvmGeneratedHeaderPath)",
             "-Xcc", "-I\(llvmGeneratedHeaderPath)",
             "-Xcc", "-fmodule-map-file=\(llvmModuleMapPath)",
        ]),
    ]
}

let package = Package(
  name: "SwiftLLVMBindings",
  products: [
    .library(name: "SwiftLLVM_Utils", targets: ["SwiftLLVM_Utils"]),
  ],
  targets: [
    .target(
      name: "SwiftLLVM_Utils",
      path: "Sources/LLVM",
      exclude: ["CMakeLists.txt"],
      sources: ["LLVM_Utils.swift"],
      swiftSettings: getLLVMSwiftSettings()
    ),
  ],
  cxxLanguageStandard: .cxx17
)
